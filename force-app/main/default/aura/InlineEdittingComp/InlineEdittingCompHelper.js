({  
      
    fetchAccounts : function( component ) {  
          
        var action = component.get( "c.fetchContacts" );  
        action.setCallback(this, function( response ) {    
              
            var state = response.getState();    
            if (state === "SUCCESS")     
                var records=response.getReturnValue();
                if(records.length > 0){
                    records.forEach(function(record) {
                        record.linkName = "/" + record.Id;
                    });
                }
                component.set( "v.acctList", records);                
              
        });    
        $A.enqueueAction(action);   
          
    },  
      
    toastMsg : function( strType, strMessage ) {  
          
        var showToast = $A.get( "e.force:showToast" );   
        showToast.setParams({   
              
            message : strMessage,  
            type : strType,  
            mode : 'sticky'  
              
        });   
        showToast.fire();   
          
    }  
      
})