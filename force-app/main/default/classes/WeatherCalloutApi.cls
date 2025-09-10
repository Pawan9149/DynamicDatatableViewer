public class WeatherCalloutApi {
    public static Decimal WeatherApi(String City){
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pro.openweathermap.org/data/2.5/weather?q='+City+'&units=metric&APPID=529a4fb190b2510f622dde5c08717d32');
		request.setMethod('GET');
        HttpResponse response = new Http().send(request);
        System.debug('Status Code: ' + response.getStatusCode());
        System.debug('Body: ' + response.getBody());
        Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        Map<String, Object> mainResult = (Map<String, Object>) result.get('main');
        Decimal temp = (Decimal)mainResult.get('temp');
        System.debug('Temp: ' + temp); 
        return temp;
    }
}