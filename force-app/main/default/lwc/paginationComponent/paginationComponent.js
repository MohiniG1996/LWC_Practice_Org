import { LightningElement, wire, api, track} from 'lwc';
import { refreshApex } from '@salesforce/apex';
import getAllRecord from '@salesforce/apex/SearchEngineApexController.getAllRecord';
import UpdateObject from '@salesforce/apex/SearchEngineApexController.UpdateObject';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class paginationComponent extends LightningElement {
@track value;
@track error;
@track data=[];
@api sortedDirection = 'asc';
@api ComponentTitile='Search Tool';
@api objectName='Account';
@api fieldNames='Id, Name, Phone,Type,Description,BillingStreet,BillingState,BillingCity,BillingCountry,Industry';
@api RecordLimit='';
@api filterFieldName='LastName';

sortedBy = 'Name';
searchKey = '';
result;
page = 1; 
items = []; 
data = []; 
startingRecord = 1;
endingRecord = 0; 
@api pageSize = 10; 
totalRecountCount = 0;
totalPage = 0;
isPageChanged = false;
initialLoad = true;
draftValues = [];
wiredAccountList=[];
isLoading=false;
updateValues=[];
columns;
isDataPresent=false;
isShow=false;

@wire(getAllRecord, { objectName:'$objectName',fieldNames:'$fieldNames',RecordLimit:'$RecordLimit'})
wiredAccounts(result) {
    this.isLoading=true;
    this.wiredAccountList = result;
    if (result.data) { 
        try {
            //logic to handle result
            if(result.data.allRecords.length>0){
                this.isDataPresent=true;
                this.data=result.data.allRecords;
                this.isLoading=false;
            }else{
                this.isDataPresent=false;
                this.isShow=true;
                this.isLoading=false;

            }
            this.columns=result.data.allFieldsDetail;
            this.processRecords(this.data);
            if(this.page){
            this.displayRecordPerPage(this.page); 
            }
    
        } catch(e){
            this.isLoading=false;
            this.isShow=true;
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error Occcured while fetching the data from backend',
                    message: e.message,
                    variant: 'error'
                })
            );

        }

        this.error = undefined;
    }
    else if (this.wiredAccountList.error) { 
        this.isLoading=false;
        this.isShow=true;
        this.error = this.wiredAccountList.error;
        this.Data = [];
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error Occcured while fetching the data from backend',
                message: 'Error Occured',
                variant: 'error'
            })
        );

        }
}
/**This Method does the calculation for pagination**/
processRecords(data){
        this.items = data;
        this.totalRecountCount = data.length; 
        this.totalPage = Math.ceil(this.totalRecountCount / this.pageSize); 
        this.data = this.items.slice(0,this.pageSize); 
        this.endingRecord = this.pageSize;
        this.columns = this.columns;
}
/**This Method invokes on previous button action**/
previousHandler() {
    this.isPageChanged = true;
    if (this.page > 1) {
        this.page = this.page - 1; //decrease page by 1
        this.displayRecordPerPage(this.page);
    }
}

/**This Method invokes on next button action**/
nextHandler() {
    this.isPageChanged = true;
    if((this.page<this.totalPage) && this.page !== this.totalPage){
        this.page = this.page + 1; //increase page by 1
        this.displayRecordPerPage(this.page);            
    }
}

/**This Method displays records page by page**/
displayRecordPerPage(page){
    this.startingRecord = ((page -1) * this.pageSize) ;
    this.endingRecord = (this.pageSize * page);

    this.endingRecord = (this.endingr7Record > this.totalRecountCount) 
                        ? this.totalRecountCount : this.endingRecord; 

    this.data = this.items.slice(this.startingRecord, this.endingRecord);
    this.startingRecord = this.startingRecord + 1;
}    
/**This Method is for sorting the records based on column**/
sortColumns( event ) {
    this.sortedBy = event.detail.fieldName;
    this.sortedDirection = event.detail.sortDirection;
    this.sortingLogic(event.detail.fieldName, event.detail.sortDirection);

}
/**This Method have the actual logic for sorting**/
sortingLogic(fieldname, direction) {
    let parseData = JSON.parse(JSON.stringify(this.data));
    let keyValue = (a) => {
        return a[fieldname];
    };
    let isReverse = direction === 'asc' ? 1: -1;
    parseData.sort((x, y) => {
        x = keyValue(x) ? keyValue(x) : ''; 
        y = keyValue(y) ? keyValue(y) : '';
        console.log('sorting calculation:'+isReverse * ((x > y) - (y > x)));
        return isReverse * ((x > y) - (y > x));
    });
    
    this.data = parseData;
}
/**This Method gets invoke on key change and also contain logic for search filter**/
handleKeyChange( event ) {
    this.searchKey = event.target.value;
    if(this.searchKey!=''){
            const data1 = this.wiredAccountList.data.allRecords.filter(dataRec=>{
                if(dataRec[this.filterFieldName].toLowerCase().includes(this.searchKey.toLowerCase())){
                    return dataRec;
                }
            });    
            this.processRecords(data1);
    }else{
        this.processRecords(this.wiredAccountList.data.allRecords);

    }        
}
/**This Method invokes when the inline update**/
async handleSave(event) {
    this.isLoading=true;
    const updatedFields = event.detail.draftValues;
    this.updateValues=event.detail.draftValues;
    updatedFields.map(row => { return { "recordId": row.Id } });
    try {
        // Pass edited fields to the updateContacts Apex controller
        UpdateObject({dataToUpdate: updatedFields})
        .then(result => {
            if(result=='Success'){
                this.isLoading=false;
                this.draftValues = [];
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: ' updated',
                        variant: 'success'
                    })
                );
                return refreshApex(this.wiredAccountList);
            }else{
                this.isLoading=false;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error updating or refreshing records',
                        message: 'Error Occurred',
                        variant: 'error'
                    })
                );
    
            }
        })
    } catch(error) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error updating or refreshing records',
                    message: error.message,
                    variant: 'error'
                })
            );
    };
}

}
