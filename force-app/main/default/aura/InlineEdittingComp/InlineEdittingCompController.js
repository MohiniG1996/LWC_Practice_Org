({    
      
    onInit : function( component, event, helper ) {    
          
        component.set( 'v.mycolumns', [    
            {
                label: 'Contact Name', 
                fieldName: 'Name', 
                type: 'text', 
				typeAttributes: { label: { fieldName: "Name" }, target: "_self" },
                sortable:true,
            },    
            {label: 'Sequence', fieldName: 'Seq No.', type: 'text', editable:'true'},
            {label: 'Lead Source', fieldName: 'LeadSource', type: 'picklist',editable:'true'},    
            {label: 'Created Date', fieldName: 'CreatedDate', type: 'date', typeAttributes: {  
                day: 'numeric',  
                month: 'short',  
                year: 'numeric',  
                hour: '2-digit',  
                minute: '2-digit',  
                second: '2-digit',  
                hour12: true}},    
            {label: 'Account', fieldName: 'Account.Name', type: 'Lookup'}    
        ]);    
        helper.fetchAccounts(component);  
          
    },  
      
    onSave : function( component, event, helper ) {   
          debugger;
        var updatedRecords = component.find( "acctTable" ).get( "v.draftValues" );  
        console.log('updateRecords==>'+updatedRecords);
        var action = component.get( "c.updateContacts" );  
        action.setParams({  
              
            'updateConList' : updatedRecords  
              
        });  
        action.setCallback( this, function( response ) {  
              
            var state = response.getState();   
            if ( state === "SUCCESS" ) {  
  
                if ( response.getReturnValue() === true ) {  
                      
                    helper.toastMsg( 'success', 'Records Saved Successfully.' );  
                    component.find( "acctTable" ).set( "v.draftValues", null );  
                      
                } else {   
                      
                    helper.toastMsg( 'error', 'Something went wrong. Contact your system administrator.' );  
                      
                }  
                  
            } else {  
                  
                helper.toastMsg( 'error', 'Something went wrong. Contact your system administrator.' );  
                  
            }  
              
        });  
        $A.enqueueAction( action );  
          
    }  
      
})