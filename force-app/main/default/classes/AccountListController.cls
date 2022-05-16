public class AccountListController {
    @AuraEnabled
    public static List < Account > fetchAccts() {
        return [ SELECT Id, Name, Industry, Type FROM Account];
    }
    @AuraEnabled
    public static String deleteAccountRec(Id recordId){
        Account acc=[Select Id,Name from Account where id=:recordId];
        delete acc;
        return 'Success';
    }

}