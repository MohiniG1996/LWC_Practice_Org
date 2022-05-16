public class Futureapexcallout {
    @future(Callout=true)
    public static void apexcallout(string billingstate,string billingcity,Id AccountId){
        
        // Instantiate a new http object
        Http h = new Http();
        
        // Instantiate a new HTTP request, specify the method (GET) as well as the endpoint
        HttpRequest req = new HttpRequest();
        String requestURL='http://api.wunderground.com/api/551013da52923e43/conditions/q/';
        requestURL=requestURL+billingstate+'/'+billingcity+'.json';
        req.setEndpoint(requestURL);
        req.setMethod('GET');
        
        // Send the request, and return a response
        HttpResponse res = h.send(req);
        string result=res.getBody();
        system.debug('^^^^^^'+result);
        WeatherInfo weatherinformation=new WeatherInfo();
        WeatherInfo.Current_observation currentobserv=new WeatherInfo.Current_observation();
        WeatherInfo.Display_location location=new WeatherInfo.Display_location();
        weatherinformation=(WeatherInfo)JSON.deserialize(result, WeatherInfo.class);
        currentobserv=weatherinformation.Current_observation;
        location=currentobserv.display_location;
        Account accupdate=[Select BillingPostalcode from Account where Id=:AccountId];
        accupdate.BillingPostalcode=location.zip;
        update accupdate;
    }
    
    
}