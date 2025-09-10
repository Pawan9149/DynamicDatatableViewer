public class GithubIssuesApiRequest {
    public static void CreateGithubIssue(){
        List<Object> caseList = new List<Object>();
        for(Integer i=0; i < 3; i++){
            Map<String, Object> issue = new Map<String, Object>{
				'title' => '100123:Follow Up ' + i,
				'body' => 'No description provided.' + i
     		};
            
            caseList.add(issue);
        }
        Map<String, Object> issue1 = new Map<String, Object>{
				'title' => '100123:Follow Up 1',
				'body' => 'No description provided. 1'
     		};
        
        HttpRequest request = new HttpRequest();
        //request.setEndpoint('callout:GithubNamedCredential/repos/Pawan9149/Atm-Machine-Project/issues');
        request.setEndpoint('https://api.openweathermap.org/data/2.5/weather?q=Jaipur&appid=529a4fb190b2510f622dde5c08717d32');
        //https://api.openweathermap.org/data/2.5/weather?q=Jaipur&appid=529a4fb190b2510f622dde5c08717d32
		request.setMethod('POST');
        System.debug('Json Body: ' + JSON.serialize(caseList));
        request.setBody(JSON.serialize(caseList));
        HttpResponse response = new Http().send(request);
        System.debug('Status Code: ' + response.getStatusCode());
        System.debug('Body: ' + response.getBody());
    }
}