import { LightningElement,api } from 'lwc';

export default class ChildComp extends LightningElement {
    @api getValueFromParent;
    searchKey;

    @api
    handleCapitalise(){
        debugger;
        console.log(this.getValueFromParent.toUpperCase());
    }
    handleChange(event){
        debugger;
        this.searchKey=event.target.value;
        const searchEvent=new customEvent("getsearchvalue",{
        detail:this.searchKey
        });
        this.dispatchEvent(searchEvent);
    }

    
}