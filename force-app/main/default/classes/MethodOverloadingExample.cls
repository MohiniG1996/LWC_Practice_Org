public class MethodOverloadingExample {
    
    public Integer sum(Integer num1,Integer num2){
        return num1+num2;
    }   
    public Integer sum(Integer num1,Integer Num2,Integer num3){
        return num1+num2+num3;
    }
	  public Integer sum(Integer num1,Integer Num2,Long num3){
        return num1+num2;
    }
     public Integer sum(Integer num1,Integer Num2,INteger num3,Integer num4){
        return num1+num2+num3;
    }
    public Integer sum(Integer num1,String str){
        System.debug('num1==>'+num1);
        return num1;
    }
    public String sum(String str1,String str2){
        return str1;
    }
    
}