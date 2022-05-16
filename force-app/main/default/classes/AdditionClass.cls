public class AdditionClass {
    
    //Variable Declaration global variable
    Integer number1;
    Integer number2;
    
    //Method defination
    public void addTwoNumber(Integer number1,Integer number2){
       Integer result=number1+number2; //local variable
        System.debug('Addition of Two Number is:'+result);
    }
    
    public void displayValue(){
        System.debug('display value method called');
    }

}