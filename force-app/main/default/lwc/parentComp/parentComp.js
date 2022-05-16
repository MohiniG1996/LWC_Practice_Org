import { LightningElement } from 'lwc';

export default class ParentComp extends LightningElement {
    value='Passing value from Parent to child';
    searchValue;
    callChildMethod(){
        debugger;
        this.template.querySelector("c-child-comp").handleCapitalise();
    }
    handleSearchValue(event){
        debugger;
        this.searchValue=event.detail;
    }
}