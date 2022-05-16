public class HelloWorld2 {

    public static void switchMethod(Integer option){
        switch on option {
            when 1 {
                System.debug('your account statement');
            }
            when 2 {
                System.debug('withdrawal Money');
            }
            when 3{
                System.debug('Reset Pin Money');
            }
                
            When else {
                System.debug('Invalid Option');
            }
        }
    }
    
  
    
}