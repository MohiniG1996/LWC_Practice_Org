import { LightningElement, wire, track } from 'lwc';
import { deleteRecord } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';

import getLatestAccounts from '@salesforce/apex/AccountController.getAccountList';
const COLS = [
  { label: 'Name', fieldName: 'Name', type: 'text' },
  { label: 'Stage', fieldName: 'Phone', type: 'text' },
  { label: 'Amount', fieldName: 'Industry', type: 'text' }
];
export default class LwcRefreshApex extends LightningElement {
  cols = COLS;
  @track selectedRecord;
  @track accountList = [];
  @track error;
   wiredAccountList = [];


   @wire(getLatestAccounts, { searchKey: 'mohini' })
   wiredServiceAccount(result) {
       console.log('wire........ service called'+this.wiredAccountList.data);
       // Hold on to the provisioned value so we can refresh it later.
       this.wiredAccountList = result;
       // Destructure the provisioned value 
     //  const { data, error } = this.wiredAccountList;
       if (this.wiredAccountList.data) { 
        this.accountList = this.wiredAccountList.data;
        console.log('accountList:'+this.accountList);
        this.error = undefined;
        }
       else if (this.wiredAccountList.error) { 
        this.error = this.wiredAccountList.error;
        this.accountList = [];
  
        }
   }
   

   /* if (result) {
        console.log('wire service has been called');
      this.accountList = result.data;
      this.error = undefined;
    } else if (result.error) {
      this.error = result.error;
      this.accountList = [];
    }
  }*/

  handelSelection(event) {
    if (event.detail.selectedRows.length > 0) {
      this.selectedRecord = event.detail.selectedRows[0].Id;
    }
  }
  deleteRecord() {
    deleteRecord(this.selectedRecord)
      .then(() => {
        console.log('delete service has been called');
        refreshApex(this.wiredAccountList);
        console.log('referesh apex');

      })
      .catch(error => {
      })
  }
}
