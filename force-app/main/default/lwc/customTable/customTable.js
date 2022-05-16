import { LightningElement,wire, track,api } from 'lwc';
import getAllRecord from '@salesforce/apex/SearchEngineApexController.getAllRecord';
import updateAccount from '@salesforce/apex/SearchEngineApexController.updateAccount';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import { getRecordNotifyChange } from 'lightning/uiRecordApi';


const columns = [
    {
        label: 'Name',
        fieldName: 'Name',
        type: 'text',
    }, {
        label: 'Phone',
        fieldName: 'Phone',
        type: 'phone',
        editable: true,
    }, {
        label: 'Industry',
        fieldName: 'Industry',
        type: 'text',
        editable: true,
    }, {
        label: 'Type',
        fieldName: 'Type',
        type: 'Picklist',
        editable: true
    }, {
        label: 'Description',
        fieldName: 'Description',
        type: 'text',
        editable: true
    }
    
];
export default class customTable extends LightningElement {
columns = columns;
 searchText;
@track allRecord;
fldsItemValues = [];
isLoading = false;

/**Pagination Variables */
@api sortedDirection = 'asc';
@api sortedBy = 'Name';
data = []; 
 allSelectedRows = [];
 page = 1; 
 items = []; 
 columns; 
 startingRecord = 1;
 endingRecord = 0; 
 pageSize = 10; 
 totalRecountCount = 0;
 totalPage = 0;
isPageChanged = false;
initialLoad = true;
mapoppNameVsOpp = new Map();

//This method fires when CustomTable component gets loaded
connectedCallback() {
    this.isLoading = true;
        getAllRecord({ searchText: this.searchText,sortedBy:this.sortedBy, sortedDirection:this.sortedDirection})
        .then(result => {
                this.allRecord = result;
                this.processRecords(this.allRecord);
                this.error = undefined;    
                this.isLoading = false;
        })
        .catch(error => {
            this.error = error;
            this.allRecord = undefined;
            this.isLoading = false;

        });
    }
    
    
    processRecords(allRecord){
            this.items = allRecord;
            this.totalRecountCount = allRecord.length; 
            this.totalPage = Math.ceil(this.totalRecountCount / this.pageSize); 
            
            this.allRecord = this.items.slice(0,this.pageSize); 
            this.endingRecord = this.pageSize;
            this.columns = columns;
    }

    //clicking on previous button this method will be called
        previousHandler() {
            this.isPageChanged = true;
            if (this.page > 1) {
                this.page = this.page - 1; //decrease page by 1
                this.displayRecordPerPage(this.page);
            }
              var selectedIds = [];
              for(var i=0; i<this.allSelectedRows.length;i++){
                selectedIds.push(this.allSelectedRows[i].Id);
              }
            this.template.querySelector(
                '[data-id="table"]'
              ).selectedRows = selectedIds;
        }

            //clicking on next button this method will be called
    nextHandler() {
        this.isPageChanged = true;
        if((this.page<this.totalPage) && this.page !== this.totalPage){
            this.page = this.page + 1; //increase page by 1
            this.displayRecordPerPage(this.page);            
        }
          var selectedIds = [];
          for(var i=0; i<this.allSelectedRows.length;i++){
            selectedIds.push(this.allSelectedRows[i].Id);
          }
        this.template.querySelector(
            '[data-id="table"]'
          ).selectedRows = selectedIds;
    }



    //this method displays records page by page
    displayRecordPerPage(page){

        this.startingRecord = ((page -1) * this.pageSize) ;
        this.endingRecord = (this.pageSize * page);

        this.endingRecord = (this.endingRecord > this.totalRecountCount) 
                            ? this.totalRecountCount : this.endingRecord; 

        this.allRecord = this.items.slice(this.startingRecord, this.endingRecord);
        this.startingRecord = this.startingRecord + 1;
    }    

    sortColumns( event ) {
        this.sortedBy = event.detail.fieldName;
        this.sortedDirection = event.detail.sortDirection;
        return refreshApex(this.result);
        
    }
    
    onRowSelection(event){
        if(!this.isPageChanged || this.initialLoad){
            if(this.initialLoad) this.initialLoad = false;
            this.processSelectedRows(event.detail.selectedRows);
        }else{
            this.isPageChanged = false;
            this.initialLoad =true;
        }
        
    }
    processSelectedRows(selectedOpps){
        var newMap = new Map();
        for(var i=0; i<selectedOpps.length;i++){
            if(!this.allSelectedRows.includes(selectedOpps[i])){
                this.allSelectedRows.push(selectedOpps[i]);
            }
            this.mapoppNameVsOpp.set(selectedOpps[i].Name, selectedOpps[i]);
            newMap.set(selectedOpps[i].Name, selectedOpps[i]);
        }
        for(let [key,value] of this.mapoppNameVsOpp.entries()){
            if(newMap.size<=0 || (!newMap.has(key) && this.initialLoad)){
                const index = this.allSelectedRows.indexOf(value);
                if (index > -1) {
                    this.allSelectedRows.splice(index, 1); 
                }
            }
        }
    }


    
    


//For updating only Single records in Lightning Data Table
handleSaveForSingleRecords(event) {
        this.fldsItemValues = event.detail.draftValues;
        const inputsItems = this.fldsItemValues.slice().map(draft => {
            const fields = Object.assign({}, draft);
            return { fields };
        });
        const promises = inputsItems.map(recordInput => updateRecord(recordInput));
        Promise.all(promises).then(res => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Records Updated Successfully!!',
                    variant: 'success'
                })
            );
            // Clear all draft values in the datatable
           // this.fldsItemValues = [];
            // Display fresh data in the datatable
            /*refreshApex(this.allRecord).then(() => {
                // do something with the refreshed data in this.allRecord
                this.refreshTheView();
            });*/

            return refreshApex(this.allRecord);
        }).catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error updating or reloading record',
                    message: 'error.body.message',
                    variant: 'error'
                })
            );  
        })
        
    }


//For updating only Multiples records in Lightning Data Table
async handleSaveForMultipleRecords(event) {
        const updatedFields = event.detail.draftValues;
            
         // Prepare the record IDs for getRecordNotifyChange()
         const notifyChangeIds = updatedFields.map(row => { return { "recordId": row.Id } });
            try {
                // Pass edited fields to the UpdateAccount Apex controller
                const result = await updateAccount({data: updatedFields});
                console.log(JSON.stringify("Apex update result: "+ result));
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Contact updated',
                        variant: 'success'
                    })
                );
                // Refresh LDS cache and fldsItemValues = [];
                getRecordNotifyChange(notifyChangeIds);
                // Clear all draft values in the datatable
                //this.draftValues = [];
                // Display fresh data in the datatable
               /* refreshApex(this.allRecord).then(() => {
                    // do something with the refreshed data in this.allRecord
                    this.refreshTheView();
                });*/
                this.refreshTheView();
              } catch(error) {
              console.log('Error==>'+Error);
                   this.dispatchEvent(
                       new ShowToastEvent({
                           title: 'Error updating or refreshing records',
                           message:error.message,
                           variant: 'error'
                       })
                 );
            };
        }
//This method for refreshing the SearchEngin Page once update is done        
refreshTheView() {
    setTimeout(() => {eval("$A.get('e.force:refreshView').fire();");}, 200); 
}
   
@api
handleKeyChange( event ) {
    this.searchText = event.target.value;
    var data = [];
    for(var i=0; i<this.items.length;i++){
        if(this.items[i]!= undefined && this.items[i].Name.includes(this.searchText)){
            data.push(this.items[i]);
        }
    }
    this.processRecords(data);
}


   
}