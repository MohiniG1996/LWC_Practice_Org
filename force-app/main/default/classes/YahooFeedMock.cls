@isTest
global class YahooFeedMock implements HttpCalloutMock{
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/xml');
        response.setBody('<rss xmlns:media="http://search.yahoo.com/mrss/" version="2.0"> <channel> <title>Yahoo News - Latest News & Headlines</title> <link>https://www.yahoo.com/news/tagged/entertainment</link> <description>The latest news and headlines from Yahoo! News. Get breaking news stories and in-depth coverage with videos and photos.</description> <language>en-US</language> <copyright>Copyright (c) 2021 Yahoo! Inc. All rights reserved</copyright> <pubDate>Wed, 30 Jun 2021 07:19:48 -0400</pubDate> <ttl>5</ttl> <image> <title>Yahoo News - Latest News & Headlines</title> <link>https://www.yahoo.com/news/tagged/entertainment</link> <url>http://l.yimg.com/rz/d/yahoo_news_en-US_s_f_p_168x21_news.png</url> </image> <item> <title>Oscars diversity rules: Progress or patronizing?</title> <link>https://news.yahoo.com/oscars-diversity-rules-progress-or-patronizing-140825533.html</link> <pubDate>2020-09-10T14:08:25Z</pubDate> <source url="https://www.yahoo.com/news/">Yahoo News 360</source> <guid isPermaLink="false">oscars-diversity-rules-progress-or-patronizing-140825533.html</guid> <media:content height="86" url="https://s.yimg.com/os/creatr-uploaded-images/2020-09/94b20a60-f30a-11ea-9f67-7a3a160c7837" width="130"/> <media:credit role="publishing company"/> </item> <item> <title>Viola Davis’s message to white women: ‘Get to know me’</title> <link>https://news.yahoo.com/viola-daviss-message-to-white-women-get-to-know-me-093000710.html</link> <pubDate>2019-05-28T09:30:00Z</pubDate> <source url="https://news.yahoo.com/">Yahoo News</source> <guid isPermaLink="false">viola-daviss-message-to-white-women-get-to-know-me-093000710.html</guid> </channel> </rss>');
        response.setStatusCode(200);
        return response; 
    }

}