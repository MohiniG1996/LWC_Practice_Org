global class RestAPICallOut {
    
      @InvocableMethod (label='Rest Callout' description='method description')
    global static void callOut(smsRequest[] request){
        		System.debug('request==>'+Request[0]);
        RestAPICallOut1.asynchronousCallOut();
		System.debug('request==>'+Request);

    }
    
    global class smsRequest {
        @InvocableVariable
        global String toNumber;
        
        @InvocableVariable
        global String smsBody;
        
        @InvocableVariable
        global String appointmentDate;
        
        @InvocableVariable
        global String appName;

    }

}