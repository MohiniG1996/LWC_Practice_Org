/*
Created By: Mohini Gorakhpuriya
Date 	  : 17th June 2021
functionality: it prints the message on debug logs
*/
public class HelloWorldApexClass {
    
    Integer num1;
    Integer numb2;
    String subject;
    //default constructor
    public  HelloWorldApexClass(){
        System.debug('Hello Constructor');
    }
    public HelloWorldApexClass(Integer num,Integer num2){
        num1=num;
        numb2 =num2;   
        System.debug('num1 value===>'+num1);
        System.debug('num2 value===>'+numb2);
    }
   public HelloWorldApexClass(String name1,string name2){
         
    }
    public HelloWorldApexClass(List<Integer> numLIst,string name2){
        
    }
     public HelloWorldApexClass(List<Integer> numLIst,List<Integer> name2){
        
    }
    
    
    //it displays the Message
    void displayMessage(){
        System.debug('Hello World');
    }
    
    void addNumbers(Integer num1,Integer num2){
        Integer sum=num1+num2;
        System.debug('Addition of '+num1+' '+num2+'===>'+Sum);
    }
       void addNumbers(List<Integer> num1,Integer num2){
        
    }
     void addNumbers(string num1,String num2){
        System.debug('Addition of '+num1+' '+num2);
    }
    void addNumbers(String num1,Integer num2){
        System.debug('Addition of '+num1+' '+num2);
    }
}