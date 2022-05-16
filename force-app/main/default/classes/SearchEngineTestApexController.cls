public with sharing class SearchEngineTestApexController {
    public SearchEngineTestApexController() {

    }
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> getOpps( String searchKey, String sortBy,String sortDirection) {
       
        String query = 'SELECT Id, Name,StageName,CloseDate FROM Opportunity';
        system.debug('query---'+query);
        if ( searchKey != null && searchKey != '' ) {
            String key = '%' + searchKey + '%';
            query += ' WHERE Name LIKE :key';
        }
        if ( sortBy != null && sortDirection != null ) {
            query += ' ORDER BY ' + sortBy + ' ' + sortDirection;
        }
        query = query + ' LIMIT 10';
        return Database.query( query );
    }
    @AuraEnabled
    public static string updateAccount(Object data) {
        List<Opportunity> accountsForUpdate = (List<Opportunity>) JSON.deserialize(JSON.serialize(data),List<Opportunity>.class);
        try {
            update accountsForUpdate;
            return 'Success: contacts updated successfully';
        }
        catch (Exception e) {
            return 'The following exception has occurred: ' + e.getMessage();
        }
    }
 
}
