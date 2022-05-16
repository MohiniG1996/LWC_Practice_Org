public class StaticKeywordExample {
    
      Integer num2; 
     Static Integer num1=100; //variable declaration+intiliaztion
     Static Integer num2=200;
    //static block get called at time of class loading 
    Static{
      System.debug('Static BLock get Called');
    }
   
    
    
        
    //static method
         public static void displayMessage(){
             integer result=num1+num2;
             System.debug('Hello Static keyword==>'+result);
         }   
    	
 //Non static method
    public  void displayErrorMessage(){
	        System.debug('Error MEssage==>'+num1);
    }
    
}