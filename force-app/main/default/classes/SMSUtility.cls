global class SMSUtility {
    
    @InvocableMethod(label='call Restout' description='method description')
    // here input param is smsRequest of List type
    global static void callOut(smsRequest[] requests ){
        RestAPICallOut1.asynchronousCallOut();
    }
    
    
    global class smsRequest {
        @InvocableVariable(required=true)
        global String toNumber;
        
        @InvocableVariable(required=true)
        global String smsBody;
        
        @InvocableVariable
        global String appointmentDate;
    }
    
}