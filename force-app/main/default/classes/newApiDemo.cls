public with sharing class newApiDemo {
    @AuraEnabled
    public static List<Map<String, String>> getNewsHeadlines(String category) {
        List<Map<String, String>> newResultList = new List<Map<String, String>>();

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(
            'https://newsapi.org/v2/top-headlines?apiKey=101210cde1ad4d619cce1aef98b2b84f&country=us&category='  + category 
        );
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');

        try {
            HttpResponse response = http.send(request);
            if (response.getStatusCode() == 200) {
                System.debug('Body: ' + response.getBody());
                String jsonResponse = response.getBody();

                Map<String, Object> result = (Map<String, Object>) JSON.deserializeUntyped(jsonResponse);
                List<Object> articles = (List<Object>) result.get('articles');

                for (Object obj : articles) {
                    Map<String, Object> article = (Map<String, Object>) obj;

                    Map<String, String> articleMap = new Map<String, String>();
                    articleMap.put('author', article.get('author') == null ? '' : String.valueOf(article.get('author')));
                    articleMap.put('title', article.get('title') == null ? '' : String.valueOf(article.get('title')));
                    articleMap.put('description', article.get('description') == null ? '' : String.valueOf(article.get('description')));
                    articleMap.put('url', article.get('url') == null ? '' : String.valueOf(article.get('url')));
                    articleMap.put('urlToImage', article.get('urlToImage') == null ? '' : String.valueOf(article.get('urlToImage')));

                    newResultList.add(articleMap);
                }
                System.debug('Body Artical: ' + newResultList);
            } else {
                Map<String, String> articleMap = new Map<String, String>();
                articleMap.put('Error', 'HTTP Status: ' + response.getStatus());
                newResultList.add(articleMap);
            }
        } catch (System.CalloutException e) {
            Map<String, String> articleMap = new Map<String, String>();
            articleMap.put('Callout error', e.getMessage());
            newResultList.add(articleMap);
        }

        return newResultList;
    }
}