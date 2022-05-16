public with sharing class ApexController {
    public ApexController() {

    }
    @AuraEnabled(cacheable=true)
    public static List<Account> getAllRecord() {
       String query = 'SELECT Id, Name, Phone,Type,Industry,Description,BillingStreet,BillingState,BillingCity,BillingCountry FROM Account';
        /* if (searchText != null && searchText != '' ) {

            String key = '\'%' + searchText + '%\'';
           //query += ' WHERE BillingStreet LIKE '+key+' OR BillingCity LIKE '+key+' OR BillingCountry LIKE '+key+' OR Name LIKE '+key;
        }   
        //query = query +' LIMIT 200;*/
        System.debug('query:'+query);
        return Database.query( query );
    }    
    @AuraEnabled
    public static String updateAccount(Object data) {
        System.debug('data==>'+data);
        List<Account> accountsForUpdate = (List<Account>) JSON.deserialize(JSON.serialize(data),List<Account>.class);
        try {
            update accountsForUpdate;
            return 'Success';
        }
        catch (Exception e) {
            return 'failure';
        }
    }

}
