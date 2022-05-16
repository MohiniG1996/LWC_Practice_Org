public with sharing class SearchEngineController {
    public SearchEngineController() {

    }
    //Fetching Object list from custom metdata
    public static List<Search_Engine_Object__mdt> getObjectList(){
        return [Select Id,Object_Names__c,Object_Field  s_API_Name__c,isActive__c from Search_Engine_Object__mdt where isActive__c=true ];
    }
    //fetch all records
    @AuraEnabled
    public static List<List<sObject>> getAllRecord(String searchKey){
        try{
            String fieldPrepare='';
            Map<String,List<String>> customMetadata=new Map<String,List<String>>();
            Integer customMetaData_Size=SearchEngineController.getObjectList().size();
            List<Search_Engine_Object__mdt> customMetaDataList=SearchEngineController.getObjectList();
            for(Search_Engine_Object__mdt customMetaDataRec:customMetaDataList){
                customMetadata.put(customMetaDataRec.Object_Names__c,customMetaDataRec.Object_Fields_API_Name__c.split(','));
                if(customMetaDataList.indexOf(customMetaDataRec)<customMetaData_Size-1){
                    fieldPrepare=fieldPrepare+customMetaDataRec.Object_Names__c+'('+customMetaDataRec.Object_Fields_API_Name__c+')'+',';
                }else{
                    fieldPrepare=fieldPrepare+customMetaDataRec.Object_Names__c+'('+customMetaDataRec.Object_Fields_API_Name__c+')';
                }
            }
            String searchStr1 = '*'+searchKey+'*';
            String searchQuery = 'FIND {' + searchStr1 + '}'+' IN ALL FIELDS RETURNING  '+fieldPrepare;
            System.debug('SearchQuery==>'+searchQuery);
            List<List<sObject>> allRecord= search.query(searchQuery);  
            return allRecord; 
        }catch(Exception e){
            System.debug('Error Line Number:'+e.getLineNumber()+'Error Message:'+e.getMessage());
        }
        return null;
    }

    public static void getRecordsInWrapper(List<List <sObject>> recordList,Map<String,List<String>> customMetadata){
        try{
            List<DataWrapper.objectWrapper> objWrapList=new List<DataWrapper.objectWrapper>();
            List<DataWrapper> dataWrapper=new List<DataWrapper>();
            for(List<sObject> recList:recordList){
                DataWrapper dataWrap=new DataWrapper();
                if(recList.size()>0 ){
                    for(sobject rec:recList){
                        DataWrapper.objectWrapper objWrap=new DataWrapper.objectWrapper();
                        objWrap=findObjectAPI_LabelName(rec.id);
                        objWrap.fieldWrapper=getFieldWrapper(customMetadata,objWrap.objAPIName); 
                        objWrapList.add(objWrap);
                    }
                }
                dataWrap.objWrapper=objWrapList;
                dataWrap.recordList=recList;
            }
        }catch(Exception e){
            System.debug('Error Line Number:'+e.getLineNumber()+'Error Message:'+e.getMessage());
        }
    }
    //this method return object Label Name & its API Name from recordId
     public static DataWrapper.objectWrapper findObjectAPI_LabelName( String recordId ){
         DataWrapper.objectWrapper objWrap=new DataWrapper.objectWrapper();
         if(recordId == null)
             return null;
         String objectAPIName = '';
         String objectLabelName='';
         String keyPrefix = recordId.substring(0,3);
         for( Schema.SObjectType obj : Schema.getGlobalDescribe().Values() ){
             String prefix = obj.getDescribe().getKeyPrefix();
             if(prefix == keyPrefix){
                 objWrap.objAPIName=obj.getDescribe().getName();
                 objWrap.objLabelName=obj.getDescribe().getLabel();
                 break;
             }
         }
         return objWrap;
	}
    public static String getFieldLabelName(String fieldAPIName,String objName){
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType leadSchema = schemaMap.get(objName);
        Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
		String labelName= fieldMap.get(fieldAPIName).getDescribe().getLabel();//It provides to get the object fields label.
        return labelName;
    }        
    public static List<DataWrapper.FieldWrapper> getFieldWrapper(Map<String,List<String>> customMetadata,String objAPIName){
        List<DataWrapper.fieldWrapper> fieldWrapList=new List<DataWrapper.fieldWrapper>();
        for(String fieldApiName : customMetadata.get(objAPIName)){
            DataWrapper.fieldWrapper fieldWrapRec=new DataWrapper.FieldWrapper();
            fieldWrapRec.labelName=getFieldLabelName(fieldApiName,objAPIName);
            fieldWrapRec.apiName=fieldApiName;
            fieldWrapList.add(fieldWrapRec);
        }
        return fieldWrapList;
    }

}