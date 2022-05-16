({
    fetchAccounts : function(component, event, helper) {
        component.set('v.mycolumns', [
			{label: 'Sequence', fieldName: 'Seq No.', type: 'text'},
            {label: 'Account Name', fieldName: 'Name', type: 'text'},
            {label: 'Industry', fieldName: 'Industry', type: 'text'},
            {label: 'Type', fieldName: 'Type', type: 'Text'},
            {type: "button", typeAttributes: {
                label: 'View',
                name: 'View',
                title: 'View',
                disabled: false,
                value: 'view',
                iconPosition: 'left'
            }},
            {type: "button", typeAttributes: {
                label: 'Edit',
                name: 'Edit',
                title: 'Edit',
                disabled: false,
                value: 'edit',
                iconPosition: 'left'
            }},
			{type: "button", typeAttributes: {
                label: 'Delete',
                name: 'Delete',
                title: 'Delete',
                disabled: false,
                value: 'Delete',
                iconPosition: 'left'
            }}

        ]);
        var action = component.get("c.fetchAccts");
        action.setParams({
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.acctList", response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    viewRecord : function(component, event, helper) {
        debugger;
        var recId = event.getParam('row').Id;
        var actionName = event.getParam('action').name;
        if ( actionName == 'Edit' ) {
            var editRecordEvent = $A.get("e.force:editRecord");
            editRecordEvent.setParams({
                "recordId": recId
            });
            editRecordEvent.fire();
        } else if ( actionName == 'View') {
            alert('view');
            var viewRecordEvent = $A.get("e.force:navigateToURL");
            viewRecordEvent.setParams({
                
                "url": "/"+recId,
				"isredirect": "true"

            });
            viewRecordEvent.fire();
        }else if(actionName=='Delete'){
            debugger;
            var deleteAccount = component.get("c.deleteAccountRec");
			deleteAccount.setParams({"recordId" :recId  });
            deleteAccount.setCallback(this, function(response){
                var state = response.getState();
                var res	  = response.getReturnValue();
                if(state == 'SUCCESS') {
                    if(res=='Success'){
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title : 'Success',
                            message: 'Record Deleted Successfully!!',
                            duration:' 5000',
                            key: 'info_alt',
                            type: 'success',
                            mode: 'pester'
                        });
                        toastEvent.fire();
                        $A. get('e. force:refreshView'). fire();
                    }else{
                        var toastEvent = $A.get("e.force:showToast");
                        toastEvent.setParams({
                            title : 'Info',
                            message: 'Error Occurred',
                            duration:' 5000',
                            key: 'info_alt',
                            type: 'info',
                            mode: 'dismissible'
                        });
                        toastEvent.fire();
                    }
                }
            });
            $A.enqueueAction(deleteAccount);
        }
    }   


})