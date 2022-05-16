import { LightningElement } from 'lwc';
import getAllRecord from'@salesforce/apex/SearchEngineController.getAllRecord';

export default class searchLWC extends LightningElement {
    searchKey;
    allRecord;
    isVisible=false;
    
    searchContact(event){        
        this.searchKey = event.target.value;        
    }

    handleClick(){
        getAllRecord({ searchKey: this.searchKey })
        .then(result => {
            if(this.result!=null){
                this.allRecord = result;
                this.error = undefined;    
                this.isVisible=true;
                console.log('isVisible==>'+this.isVisible);
            }
        })
        .catch(error => {
            this.error = error;
            this.allRecord = undefined;
        });
   }
}