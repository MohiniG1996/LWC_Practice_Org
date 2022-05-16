/*
    @Author      : Mohammad Usman
    @version     : 1.0
    @Description : Yahoo News Integration Using RSS feed with Salesforce.
*/
public with sharing class RSSNewsReader { 
  /*  public String rssQuery {get;set;}
    public boolean recordNotFound{get;set;}
    public String age{get;set;}     
    public YahooRssWrapper.channel rssFeed {get;set;}
    
    public RSSNewsReader(ApexPages.StandardController controller) {
        age = apexpages.currentpage().getparameters().get('age');
        String query = apexpages.currentpage().getparameters().get('q');
        if(age == null || age.trim().equals('')){
            age = '';
        }
        if(query == null || query.trim().equals('')){
            System.debug('Record ID:'+controller.getRecord().Id);
                Account objAcc = [SELECT Name FROM Account WHERE Id='0015g00000Bnexp' ];
            rssQuery = ObjAcc.Name;//default on load
        } else{
            rssQuery = query;
        }

        init('https://news.search.yahoo.com/search?p='+EncodingUtil.urlEncode(rssQuery,'UTF-8')+'&fr=sfp&age=' + age.trim());
    }


    private void init(String rssURL) {
        try{
            recordNotFound = true;
            rssFeed = YahooRssWrapper.getRSSData(rssURL);     
            System.debug('rssFeed==>'+rssFeed);
        }catch(Exception ex){
            recordNotFound = false;
        }
    }
    
     public pagereference getRSSFeed2() {  
        apexpages.currentpage().getparameters().put('q',rssQuery);      
        init('https://news.search.yahoo.com/search?p='+EncodingUtil.urlEncode(rssQuery,'UTF-8')+'&fr=sfp&age=' + age.trim());        
        return null;
     }*/
}