public class InlineEdittingController {
 @AuraEnabled    
    public static List < Account > fetchAccts() {    
            
        return [ SELECT Id, Name, Industry, Type, CreatedDate FROM Account LIMIT 100 ];    
            
    }    
      
    @AuraEnabled    
    public static boolean updateAccts( List < Account > updatedAccountList ) {    
        try {  
            update updatedAccountList;  
            return true;  
              
        } catch(Exception e) {  
          
            return false;  
              
        }  
            
    } 
     @AuraEnabled    
    public static List < Contact > fetchContacts() {    
            
        return [ SELECT Id, Name, LeadSource, Account.Name,CreatedDate FROM Contact LIMIT 100 ];    
            
    }    
      
    @AuraEnabled    
    public static boolean updateContacts( List < Contact > updateConList ) {    
        try {  
            update updateConList;  
            return true;  
        } catch(Exception e) {  
            return false;  
        }  
    }    

}