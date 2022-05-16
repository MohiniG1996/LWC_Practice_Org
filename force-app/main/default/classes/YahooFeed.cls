public class YahooFeed {
    public class channel {
        @AuraEnabled
        public String title {get;set;}
        @AuraEnabled
        public String link {get;set;}
        @AuraEnabled
        public String description {get;set;}
        @AuraEnabled
        public String language {get;set;}
        @AuraEnabled
        public String category {get;set;}
        @AuraEnabled
        public String copyright {get;set;}
        @AuraEnabled
        public String pubDate {get;set;}
        @AuraEnabled
        public String ttl {get;set;}
        @AuraEnabled
        public list<YahooFeed.item> items {get;set;}
        public Channel() {
            items = new list<YahooFeed.item>();
        }
    }
    public class Item {
        @AuraEnabled
        public String title {get;set;}
        @AuraEnabled
        public String guid {get;set;}
        @AuraEnabled
        public String link {get;set;}
        @AuraEnabled
        public String description {get;set;}
        @AuraEnabled
        public String imageLink {get;set;}
        @AuraEnabled
        public String pubDate {get;set;}
        @AuraEnabled
        public String source {get;set;}

        public Date getPublishedDate() {
            Date result = (pubDate != null) ? Date.valueOf(pubDate.replace('T', ' ').replace('Z','')) : null;
            return result;
        }
        @AuraEnabled
        public DateTime getPublishedDateTime() {
            DateTime result = (pubDate != null) ? DateTime.valueOf(pubDate.replace('T', ' ').replace('Z','')) : null;
            return result;            
        }
    }
    
    @AuraEnabled(cacheable=true)
    public static YahooFeed.channel feedGenerator() {
        HttpRequest req = new HttpRequest();
        req.setEndPoint('https://news.yahoo.com/rss/entertainment');
        req.setMethod('GET');
        req.setHeader('Content-Type', 'application/xml');
        Http http = new Http();
        HTTPResponse res = http.send(req);
        Dom.Document doc = new Dom.Document();
        if(res.getBody() != null){              
            doc.load(res.getBody().replace('&', EncodingUtil.urlEncode('&','UTF-8')).replace('<![CDATA[','').replace(']]>',''));//res.getBody());
        }     
        Dom.XMLNode rss = doc.getRootElement();
        //first child element of rss feed is always channel
        Dom.XMLNode channel = rss.getChildElements()[0];
        YahooFeed.channel result = new YahooFeed.channel();
        List<YahooFeed.item> rssItems = new List<YahooFeed.item>();
        for(Dom.XMLNode elements : channel.getChildElements()) {
            if('title' == elements.getName()) {
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
            if('item' == elements.getName()) {
                YahooFeed.item rssItem = new YahooFeed.item();
                //for each node inside item
                String nameSpace = elements.getNamespaceFor('media');
                 rssItem.imageLink = elements.getChildElement('content',nameSpace).getAttributeValue('url', '');
                for(Dom.XMLNode xmlItem : elements.getChildElements()) {   
                    if('title' == xmlItem.getName()) {
                        rssItem.title = EncodingUtil.urlDecode(xmlItem.getText(), 'UTF-8');
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
        System.debug(result);
        return result;
    }
}