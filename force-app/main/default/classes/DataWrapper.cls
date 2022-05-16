public with sharing class DataWrapper {
    @AuraEnabled
    public  List<objectWrapper> objWrapper{get;set;}
	@AuraEnabled
	public List<Sobject> recordList{get;set;}

    public class objectWrapper{
        @AuraEnabled
       public String objLabelName{get;set;}
        @AuraEnabled
       public String objAPIName{get;set;}
        @AuraEnabled
        public List<fieldWrapper> fieldWrapper{get;set;}
    }
    public class fieldWrapper{
        @AuraEnabled
        public String apiName{get;set;}
        @AuraEnabled
        public String labelName{get;set;}
    }
    
}