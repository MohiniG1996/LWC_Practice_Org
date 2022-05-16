import { LightningElement,track } from 'lwc';
import searchImperativeContactList from '@salesforce/apex/LWC_ContactController.searchImperativeContactList'; 
import getAllRecord from '@salesforce/apex/SearchEngineController.getAllRecord'; 

export default class ShowContactsWMP extends LightningElement {

    @track contacts;
    @track error;
    allRecord;
 
    searchContact(event){        
        this.searchKey = event.target.value;        
    }
 
    doSearch() {
        searchImperativeContactList({ accountName: this.searchKey })
            .then(result => {
                this.contacts = result;
                console.log('contact==>'+this.contacts);
                this.error = undefined;
            })
            .catch(error => {
                this.error = error;
                this.contacts = undefined;
            });
    }

    allRecord(){
        alert('Record !!!!!');
        getAllRecord({ searchKey: this.searchKey })
        .then(result => {
            this.allRecord = result;
            console.log('allRecord==>'+this.allRecord);
            this.error = undefined;
        })
        .catch(error => {
            this.error = error;
            this.allRecord = undefined;
        });
    }

}