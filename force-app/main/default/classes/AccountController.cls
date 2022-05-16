public with sharing class AccountController {
    public AccountController() {

    }
    @AuraEnabled(cacheable=true)
    public static List<account>  getAccountList(String searchKey){
        String key = '%' + searchKey + '%';
        String query = 'SELECT Id, Name,Phone,Industry FROM Account where like '+key+' limit 10';

        return Database.query( query );
    }

}
