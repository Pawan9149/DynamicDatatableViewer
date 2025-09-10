public class Spoonacular {
	
    private static final String SPOONACULAR_API = 'https://api.spoonacular.com';
    private static final String API_KEY = 'e85a11d612a94810a9d302be27aa752a';
    
    public static void getRandomReceipe(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(SPOONACULAR_API + '/recipes/random?apiKey=' + API_KEY);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        System.debug('Response Code: ' + response.getStatusCode());
        if(response.getStatusCode() == 200){
            System.debug('Response: ' + response.getBody());
        }
    }
    
    public static void getReceipe(String receipeId){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(SPOONACULAR_API + '/recipes/' + receipeId + '/information?apiKey=' + API_KEY);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        System.debug('Response Code: ' + response.getStatusCode());
        if(response.getStatusCode() == 200){
            System.debug('Response: ' + response.getBody());
        }
    }
    
    public static void getReceipeByIngredient(String ingredients){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(SPOONACULAR_API + '/recipes/findByIngredients?apiKey=' + API_KEY + '&ingredients=' + ingredients);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        System.debug('Response Code: ' + response.getStatusCode());
        if(response.getStatusCode() == 200){
            System.debug('Response: ' + response.getBody());
        }
    }
    
}