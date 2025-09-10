public class SalesforceConnect {
    public static void getCasesFromOtherSalesforceOrg(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('callout:SFDCB/services/apexrest/Cases');
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);
        
        
        System.debug('Response Code: ' + response.getStatusCode()); 
        if(response.getStatusCode() == 200){
            System.debug(response.getBody());
            List<Object> results = (List<Object>)JSON.deserializeUntyped(response.getBody());
            for(Object result : results){
                Map<String, Object> caseMap = (Map<String, Object>) result;
                System.debug('Case No. :- ' + caseMap.get('CaseNumber') + ' - Subject: ' + caseMap.get('Subject'));
            }
        }
    }
}