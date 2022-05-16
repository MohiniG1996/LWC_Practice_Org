public class WeatherInfo {
    public class Current_observation {
        public Image image;
        public Display_location display_location;
        public Observation_location observation_location;
        public Estimated estimated{get;set;}
        public String station_id;
        public String observation_time;
        public String observation_time_rfc822;
        public String observation_epoch;
        public String local_time_rfc822;
        public String local_epoch;
        public String local_tz_short;
        public String local_tz_long;
        public String local_tz_offset{get;set;}
        public String weather{get;set;}
        public String temperature_string;
        public Double temp_f{get;set;}
        public Double temp_c{get;set;}
        public String relative_humidity{get;set;}
        public String wind_string{get;set;}
        public String wind_dir{get;set;}
        public Integer wind_degrees{get;set;}
        public Double wind_mph{get;set;}
        public String wind_gust_mph{get;set;}
        public Double wind_kph{get;set;}
        public String wind_gust_kph{get;set;}
        public String pressure_mb{get;set;}
        public String pressure_in{get;set;}
        public String pressure_trend{get;set;}
        public String dewpoint_string{get;set;}
        public Integer dewpoint_f{get;set;}
        public Integer dewpoint_c{get;set;}
        public String heat_index_string{get;set;}
        public String heat_index_f{get;set;}
        public String heat_index_c{get;set;}
        public String windchill_string{get;set;}
        public String windchill_f{get;set;}
        public String windchill_c{get;set;}
        public String feelslike_string{get;set;}
        public String feelslike_f{get;set;}
        public String feelslike_c{get;set;}
        public String visibility_mi{get;set;}
        public String visibility_km{get;set;}
        public String solarradiation{get;set;}
        public String UV{get;set;}
        public String precip_1hr_string{get;set;}
        public String precip_1hr_in{get;set;}
        public String precip_1hr_metric{get;set;}
        public String precip_today_string{get;set;}
        public String precip_today_in{get;set;}
        public String precip_today_metric{get;set;}
        public String icon{get;set;}
        public String icon_url{get;set;}
        public String forecast_url{get;set;}
        public String history_url{get;set;}
        public String ob_url{get;set;}
        public String nowcast{get;set;}
    }
    
    public class Estimated {
    }
    
    public Response response;
    public Current_observation current_observation;
    
    public class Image {
        public String url;
        public String title;
        public String link;
    }
    
    public class Response {
        public String version;
        public String termsofService;
        public Features features;
    }
    
    public class Display_location {
        public String full;
        public String city;
        public String state;
        public String state_name;
        public String country;
        public String country_iso3166;
        public String zip;
        public String magic;
        public String wmo;
        public String latitude;
        public String longitude;
        public String elevation;
    }
    
    public class Observation_location {
        public String full;
        public String city;
        public String state;
        public String country;
        public String country_iso3166;
        public String latitude;
        public String longitude;
        public String elevation;
    }
    
    public class Features {
        public Integer conditions;
    }
    
    
}