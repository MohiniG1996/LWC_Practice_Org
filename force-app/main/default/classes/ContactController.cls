public inherited sharing class ContactController {
    @AuraEnabled(Cacheable = true)
    public static List<Contact> getContacts(String accId) {
        return [SELECT Id,FirstName,LastName,Phone from Contact limit 20];
    }    
    @AuraEnabled
    public static string updateContacts(Object data) {
        List<Contact> contactsForUpdate = (List<Contact>) JSON.deserialize(JSON.serialize(data),List<Contact>.class);
        try {
            update contactsForUpdate;
            return 'Success: contacts updated successfully';
        }
        catch (Exception e) {
            return 'The following exception has occurred: ' + e.getMessage();
        }
    }
}
