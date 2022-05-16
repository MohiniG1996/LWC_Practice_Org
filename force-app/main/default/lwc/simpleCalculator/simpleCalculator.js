import { LightningElement } from 'lwc';

export default class SimpleCalculator extends LightningElement {
    firstNumber;
    secondNumber;
    result;
    showPreviousToggle;
   previousResult=[];

    onNumberChange(event){
        debugger;
        const fieldName=event.target.name;
        if(fieldName=="firstNumber"){
            this.firstNumber=parseInt(event.target.value);
        }if(fieldName=="secondNumber"){
            this.secondNumber=parseInt(event.target.value);
        }
    }

    addHandler(){
        debugger;
            var firstN=parseInt(this.firstNumber);
            var secondN=parseInt(this.secondNumber);
            this.result=`Result of Addition ${firstN} and ${secondN} is ${firstN+secondN}`;
    }

    subtractHandler(){
        const firstN=parseInt(this.firstNumber);
        const secondN=parseInt(this.secondNumber);
        this.result=`Result of Subtraction ${firstN} and ${secondN} is ${firstN-secondN}`;
        this.previousResult.push(this.result);
    }

    multiHandler(){
        const firstN=parseInt(this.firstNumber);
        const secondN=parseInt(this.secondNumber);
        this.result=`Result of Multiplication ${firstN} and ${secondN} is ${firstN*secondN}`;
        this.previousResult.push(this.result);

    }

    divisionHandler(){
        const firstN=parseInt(this.firstNumber);
        const secondN=parseInt(this.secondNumber);
        this.result=`Result of Division ${firstN} and ${secondN} is ${firstN/secondN}`;
        this.previousResult.push(this.result);

    }

    showPreviousResult(event){
        this.showPreviousToggle=event.target.checked;
        console.log('showPreviousToggelre==>'+this.showPreviousToggle);
        console.log('previousResult==>'+this.previousResult);
    }
}