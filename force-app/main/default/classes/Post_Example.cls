public class Post_Example {
    public static HttpResponse SendPostReq(){
        Http http = new Http();
        List<Account> accountList = new List<Account>{
            new Account(Name = 'Test1', Phone = '89976567875'),
            new Account(Name = 'Test2', Phone = '99976567875'),
            new Account(Name = 'Test3', Phone = '79976567875')
        };
        HttpRequest request = new HttpRequest();
        request.setEndPoint('callout:SFDCB/services/data/v58.0/composite/sobjects/');
        request.setMethod('POST');
        request.setHeader('Content-Type', 'application/json');
        
        List<Object> records = new List<Object>();
        for (Account acc : accountList) {
            Map<String, Object> record = new Map<String, Object>();
            record.put('attributes', new Map<String, String>{ 'type' => 'Account' });
            record.put('Name', acc.Name);
            record.put('Phone', acc.Phone);
            records.add(record);
        }

        Map<String, Object> payload = new Map<String, Object>();
        payload.put('allOrNone', true);
        payload.put('records', records);
        
        String accToPass = JSON.serialize(payload);
        System.debug('This is JSON Formatted Account: ' + accToPass);
        request.setBody(accToPass);
        HttpResponse response = http.send(request);
        System.debug('Response Status Code: ' + response.getStatusCode());
        System.debug('Response Body: ' + response.getBody());
        
        return response;
        
    }
    
   /* private static Account generateAccount(){
        Account account = new Account(
            Name = 'Test Account2',
            Phone = '9878986756'
        );
        
        return account;
    }
    
    private static AccountWrapper wrapAccount(List<Account> accountList){
        AccountWrapper wrapper = new AccountWrapper();
        wrapper.accounts = accountList;
        return wrapper;
    }
    
    public class AccountWrapper {
        public List<Account> accounts;
    }*/
}