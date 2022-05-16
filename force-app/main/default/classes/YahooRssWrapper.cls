/*
    @Author      : Mohammad Usman
    @version     : 1.0
    @Description : Yahoo News Integration Using RSS feed with Salesforce.
*/
public with sharing class YahooRssWrapper {
    public class channel {
        public String title {get;set;}
        public String link {get;set;}
        public String description {get;set;}
        public String language {get;set;}
        public String category {get;set;}
        public String copyright {get;set;}
        public String pubDate {get;set;}
        public String ttl {get;set;}
        public YahooRssWrapper.image image {get;set;}
        public list<YahooRssWrapper.item> items {get;set;}
        public channel() {
            items = new list<YahooRssWrapper.item>();
        }
    }
     
    public class image {
        public String url {get;set;}
        public String title {get;set;}
        public String link {get;set;}
    }
     
    public class item {
        public String title {get;set;}
        public String guid {get;set;}
        public String link {get;set;}
        public String description {get;set;}
        public String pubDate {get;set;}
        public String source {get;set;}
        public Date getPublishedDate() {
            Date result = (pubDate != null) ? Date.valueOf(pubDate.replace('T', ' ').replace('Z','')) : null;
            return result;
        }
        public DateTime getPublishedDateTime() {
            DateTime result = (pubDate != null) ? DateTime.valueOf(pubDate.replace('T', ' ').replace('Z','')) : null;
            return result;            
        }
    }
     
    public static YahooRssWrapper.channel getRSSData(string feedURL) {
        //Todo Remove
        //https://news.search.yahoo.com/search?p=Rainmaker&ei=UTF-8&nojs=1
        //feedURL ='http://news.search.yahoo.com/rss?ei=UTF-8&p=Rainmaker&fr=sfp';        
        HttpRequest req = new HttpRequest();
        req.setEndpoint(feedURL);
        req.setMethod('GET');        
        Dom.Document doc = new Dom.Document();
        String xmlDom = '';
        Http h = new Http();
        HttpResponse res; 
        if (!Test.isRunningTest()){ 
            try{
                res = h.send(req);
                System.debug('res==>'+res);
            }catch(Exception ex){
                return null;
            }
            // Generate the HTTP response as an XML stream          
            if(res.getBody() != null){      
                System.debug('Heeeeeeeee!!!!!!!!!!'+res.getBody());
                doc.load(res.getBody().replace('&', EncodingUtil.urlEncode('&','UTF-8')).replace('<![CDATA[','').replace(']]>',''));//res.getBody());
            }            
            
        } else {
            String xmlString = '<?xml version="1.0" encoding="utf-8" ?><rss version="2.0" xmlns:os="http://a9.com/-/spec/opensearch/1.1/"><channel><title>salesforce.com - Bing News</title><link>http://www.bing.com/news</link><description>Search Results for salesforce.com at Bing.com</description><category>News</category><os:totalResults>3370</os:totalResults><os:startIndex>0</os:startIndex><os:itemsPerPage>10</os:itemsPerPage><os:Query role="request" searchTerms="salesforce.com" /><copyright>These XML results may not be used, reproduced or transmitted in any manner or for any purpose other than rendering Bing results within an RSS aggregator for your personal, non-commercial use. Any other use requires written permission from Microsoft Corporation. By using these results in any manner whatsoever, you agree to be bound by the foregoing restrictions.</copyright><image><url>http://www.bing.com/s/a/rsslogo.gif</url><title>Bing</title><link>http://www.bing.com/news</link></image><docs>http://www.rssboard.org/rss-specification</docs><item><title>Salesforce.com Makes Friends With CIOs - Information Week</title><guid>http://informationweek.com/news/cloud-computing/software/232602782</guid><link>http://informationweek.com/news/cloud-computing/software/232602782</link><description>Parade of CIOs at CloudForce shows how social networking inroads are making Salesforce.com a larger part of the IT infrastructure. Salesforce.com isn&apos;t just for sales forces anymore. Its Chatter app has opened a social networking avenue into the enterprise ...</description><pubDate>2012-03-19T15:21:47Z</pubDate><source>Information Week</source></item></channel></rss>';
            doc.load(xmlString);
        }
         
        Dom.XMLNode rss = doc.getRootElement();
        //first child element of rss feed is always channel
        Dom.XMLNode channel = rss.getChildElements()[0];
         
        YahooRssWrapper.channel result = new YahooRssWrapper.channel();
         
        list<YahooRssWrapper.item> rssItems = new list<YahooRssWrapper.item>();
         
        //for each node inside channel        
        for(Dom.XMLNode elements : channel.getChildElements()) {
            if('title' == elements.getName()) {
                    System.debug(')))))))))))))))))'+elements);
                result.title = elements.getText();
            }
            if('link' == elements.getName()) {
                result.link = elements.getText();
            }
            if('description' == elements.getName()) {
                result.description = elements.getText();
            }
            if('category' == elements.getName()) {
                result.category = elements.getText();
            }
            if('copyright' == elements.getName()) {
                result.copyright = elements.getText();
            }
            if('ttl' == elements.getName()) {
                result.ttl = elements.getText();
            }
            if('image' == elements.getName()) {
                YahooRssWrapper.image img = new YahooRssWrapper.image();
                //for each node inside image
                for(Dom.XMLNode xmlImage : elements.getChildElements()) {
                    if('url' == xmlImage.getName()) {
                        img.url = xmlImage.getText();
                    }
                    if('title' == xmlImage.getName()) {
                        img.title = xmlImage.getText();
                    }
                    if('link' == xmlImage.getName()) {
                        img.link = xmlImage.getText();
                    }
                }
                result.image = img;
            }
             
            if('item' == elements.getName()) {
                YahooRssWrapper.item rssItem = new YahooRssWrapper.item();
                //for each node inside item
                for(Dom.XMLNode xmlItem : elements.getChildElements()) {                    
                    if('title' == xmlItem.getName()) {
                        rssItem.title = EncodingUtil.urlDecode(xmlItem.getText(),'UTF-8');
                    }
                    if('guid' == xmlItem.getName()) {
                        rssItem.guid = xmlItem.getText();
                    }
                    if('link' == xmlItem.getName()) {
                        rssItem.link = xmlItem.getText();
                    }
                    if('description' == xmlItem.getName()) {
                        rssItem.description = EncodingUtil.urlDecode(xmlItem.getText(),'UTF-8');
                    }
                    if('pubDate' == xmlItem.getName()) {
                        rssItem.pubDate = EncodingUtil.urlDecode(xmlItem.getText(),'UTF-8');
                    }
                    if('source' == xmlItem.getName()) {
                        rssItem.source = EncodingUtil.urlDecode(xmlItem.getText(),'UTF-8');
                    }
                }
                //for each item, add to rssItem list
                rssItems.add(rssItem);
            }
        }
        //finish YahooRssWrapper.channel object by adding the list of all rss items
        result.items = rssItems;        
        return result;
    }
     
   /* static testMethod void RSSTest() {
        YahooRssWrapper.channel chan = YahooRssWrapper.getRSSData('test');
        Date pDate = chan.items[0].getPublishedDate();
        DateTime pDateTime = chan.items[0].getPublishedDateTime();
    }*/
   
}