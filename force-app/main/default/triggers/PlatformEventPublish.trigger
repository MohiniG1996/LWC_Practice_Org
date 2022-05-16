trigger PlatformEventPublish on Account (before insert, after update) {
    If(trigger.isAfter && trigger.isUpdate){
       /* List<Employee_On_boarding__e> publishEvents = new List<Employee_On_boarding__e>();
        for(Account a : Trigger.new){
            System.debug('publish');
            Employee_On_boarding__e eve = new Employee_On_boarding__e();
            eve.Name__c = a.Name ;
            eve.Phone__c = a.Phone ;
            eve.Salary__c = a.AnnualRevenue ;
            publishEvents.add(eve);            
        }*/
        List<Account_Event__e> publishAccountEvents=new List<Account_Event__e>();
        for(Account a:trigger.new){
            Account_Event__e eve=new Account_Event__e();
            eve.Account_Name__c=a.Name;
            eve.Account_Description__c=a.Description;
            publishAccountEvents.add(eve);
        }
        if(publishAccountEvents.size()>0){
            EventBus.publish(publishAccountEvents);
        }
        
    }
}