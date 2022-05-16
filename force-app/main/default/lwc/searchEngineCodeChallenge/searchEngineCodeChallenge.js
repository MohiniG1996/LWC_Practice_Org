import { LightningElement,wire } from 'lwc';
import getAllRecord from '@salesforce/apex/SearchEngineApexController.getAllRecord';


export default class searchEngineCodeChallenge extends LightningElement {
    allRecord;
    searchKey;
    isVisible=false;
    sortedDirection = 'asc';
    sortedBy = 'Name';

    /*@wire(getAllRecord, {searchKey: '$searchKey', sortBy: '$sortedBy', sortDirection: '$sortedDirection'})
    wiredAccounts({ error, allRecord }) {
        if (allRecord) {
            this.processRecords(allRecord);
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.data = undefined;
        }
    }*/

    
  /*  searchRecordHandler(event){
        this.searchKey = event.target.value; 
        console.log('searchKey==>'+this.searchKey);       
    }

    handleClick(){
        this.isVisible=true;
    }*/
    handleKeyChangeEvent(event){
        this.isVisible=true;
        this.template.querySelector('c-custom-table').handleKeyChange(event);
    }
}