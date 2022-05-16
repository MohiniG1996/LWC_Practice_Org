public class ThisKeywordExample {
    
    //Variable Decalarion
    //Instance variable
    Integer number1;
    Integer number2;
    
    //default constructor
  public  ThisKeywordExample(){
		System.debug('default constructor called!!!!!!!!!!');
    }
    
    
    // Constructor
   public ThisKeywordExample(Integer number1,Integer number2){
       System.debug('parametrized constructor called');
        this.number1=number1;
        this.number2=number2;
               System.debug('obj===>'+this.number1+'  '+this.number2);

    }    
    
    public void displayValues(){

        

    }
    
    

}