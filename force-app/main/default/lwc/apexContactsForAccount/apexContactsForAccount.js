import { LightningElement, wire, api,track } from 'lwc';
import getContacts from '@salesforce/apex/ContactController.getContacts';
import updateContacts from '@salesforce/apex/ContactController.updateContacts';

import { refreshApex } from '@salesforce/apex';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import ID_FIELD from '@salesforce/schema/Contact.Id';
import { getRecordNotifyChange } from 'lightning/uiRecordApi';



const COLS = [
    { label: 'First Name', fieldName: 'FirstName', editable: true },
    { label: 'Last Name', fieldName: 'LastName', editable: true },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Email', fieldName: 'Email', type: 'email' }
];
export default class DatatableUpdateExample extends LightningElement {

    @api recordId;
    columns = COLS;
    draftValues = [];
    @track allRecord;

    /*@wire(getContacts, { accId: '$recordId' })
    contact;*/

    connectedCallback() {
        console.log('Child component connectedCallback being called');
        getContacts({ accId: this.recordId })
        .then(result => {
                this.allRecord = result;
                this.error = undefined;    
        })
        .catch(error => {
            this.error = error;
            this.allRecord = undefined;
        });
        console.log('ALL records:'+JSON.stringify(this.allRecord));
    }


    //for updating only single records in Lightning Data Table
    handleSave(event) {

        const fields = {}; 
        fields[ID_FIELD.fieldApiName] = event.detail.draftValues[0].Id;
        fields[FIRSTNAME_FIELD.fieldApiName] = event.detail.draftValues[0].FirstName;
        fields[LASTNAME_FIELD.fieldApiName] = event.detail.draftValues[0].LastName;

        const recordInput = {fields};

        updateRecord(recordInput)
        .then(() => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Contact updated',
                    variant: 'success'
                })
            );
            // Clear all draft values in the datatable
           // this.updateRecordView();
            this.draftValues = [];
            // Display fresh data in the datatable
            return refreshApex(this.allRecord);
        }).catch(error => {
            console.log('error==>'+error);
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error updating or reloading record',
                    message: error.message,
                    variant: 'error'
                })
            );
        });
    }

    //for updating only Multiples records in Lightning Data Table
    async handleSaveForMultipleRecords(event) {
        const updatedFields = event.detail.draftValues;
        
        // Prepare the record IDs for getRecordNotifyChange()
        const notifyChangeIds = updatedFields.map(row => { return { "recordId": row.Id } });
    
        try {
            // Pass edited fields to the updateContacts Apex controller
            const result = await updateContacts({data: updatedFields});
            console.log(JSON.stringify("Apex update result: "+ result));
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Contact updated',
                    variant: 'success'
                })
            );
    
            // Refresh LDS cache and wires
            getRecordNotifyChange(notifyChangeIds);
            // Clear all draft values in the datatable
           // this.draftValues = [];
            // Display fresh data in the datatable
            return refreshApex(this.allRecord);
            
    
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
    





    updateRecordView() {
        setTimeout(() => {
             eval("$A.get('e.force:refreshView').fire();");
        }, 90); 
     }
 
}
