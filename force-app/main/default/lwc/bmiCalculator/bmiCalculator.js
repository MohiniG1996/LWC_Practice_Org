import { LightningElement,track } from 'lwc';

export default class BmiCalculator extends LightningElement {
   @track bmiData={
        weight:0,
        height:0,
        bmiResult:0
    };
    onWeightChange(event){
        this.bmiData.weight=parseFloat(event.target.value);
    }
    onHeightChange(event){
        this.bmiData.height=parseFloat(event.target.value);
    }

    calculateBMI(){
        this.bmiData.bmiResult=this.bmiData.weight/(this.bmiData.height*this.bmiData.height);
    }    

    get bmiValue(){
        if(this.bmiData.bmiResult==undefined){
            return "";
        }
        return `your bmi is ${this.bmiData.bmiResult}`;

    }

}