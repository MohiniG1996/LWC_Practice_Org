public with sharing class LWC_ContactController {
    public LWC_ContactController() {

    }
    @AuraEnabled
    public static List<Contact> searchImperativeContactList(String accountName){
        if (String.isBlank(accountName)) {
             return new List<Contact>();
         }
         String key = '%' + accountName + '%';
         return [SELECT Id, Name, Email FROM Contact WHERE Account.Name LIKE : key];
    }

}