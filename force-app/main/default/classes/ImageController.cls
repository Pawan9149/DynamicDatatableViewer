public with sharing class ImageController {

    @AuraEnabled(cacheable=true)
    public static List<Article> getNewsArticles() {
        // You must replace this with your actual news API URL.
        // Make sure the domain is added to Remote Site Settings.
        String endpoint = 'https://newsapi.org/v2/top-headlines?apiKey=101210cde1ad4d619cce1aef98b2b84f&country=us&category=Sports'; 

        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        request.setTimeout(120000); // 2 minutes timeout

        Http http = new Http();
        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            String jsonResponse = response.getBody();
            NewsApiResponse apiResponse = (NewsApiResponse) JSON.deserialize(jsonResponse, NewsApiResponse.class);
            return apiResponse.articles;
        } else {
            System.debug('Error calling news API: ' + response.getStatusCode() + ' ' + response.getStatus());
            throw new AuraHandledException('Error fetching news articles.');
        }
    }

    // Inner class to handle the JSON structure of the API response
    public class NewsApiResponse {
        public List<Article> articles;
    }

    public class Article {
        public Source source;
        public String author;
        public String title;
        public String description;
        public String url;
        public String urlToImage;
        public Datetime publishedAt;
        public String content;
    }

    public class Source {
        public String id;
        public String name;
    }
}