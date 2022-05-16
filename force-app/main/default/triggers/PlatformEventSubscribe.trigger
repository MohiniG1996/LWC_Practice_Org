trigger PlatformEventSubscribe on Employee_On_Boarding__e (after insert) {
    List<Account> acc = new List<Account>();
    for(Employee_On_boarding__e oBording :trigger.new){
                RestAPICallOut1.asynchronousCallOut();

        System.debug('subscribe');
        acc.add(new Account(Name =oBording.Name__c+'Subscribe' , Phone =oBording.Phone__c , AnnualRevenue = oBording.Salary__c));
    }
    if(acc.size() >0){
        insert acc ;
    }
    
}