public with sharing class PaginationController {
    public PaginationController() {

    }
    @AuraEnabled
    public static List<Account> getAllRecord(String searchText,String sortBy,String sortDirection) {
       String query = 'SELECT Id, Name, Phone,Type,Description FROM Account';
        if (searchText != null && searchText != '' ) {

            String key = '\'%' + searchText + '%\'';
           query += ' WHERE Name LIKE '+key;
        }
        if (sortBy != null && sortDirection != null ) {
            query += ' ORDER BY ' + sortBy + ' ' + sortDirection;
        }
        query = query +' LIMIT 200';
        System.debug('query:'+query);
        return Database.query( query );
    }    
    @AuraEnabled
    public static string updateAccount(Object data) {
        List<Account> accountsForUpdate = (List<Account>) JSON.deserialize(JSON.serialize(data),List<Account>.class);
        try {
            update accountsForUpdate;
            return 'Success: contacts updated successfully';
        }
        catch (Exception e) {
            return 'The following exception has occurred: ' + e.getMessage();
        }
    }

}
