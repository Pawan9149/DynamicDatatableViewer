public with sharing class FutureMethodDemo {
    public static void run(){
        Integer randomInt = Integer.valueOf(math.round(math.random() * 1000000));
        Account accObj = new Account(
            Name = 'Salesforce.org' + randomInt,
            Rating = 'Hot'
        );

        Insert accObj;

        createUser();

        //Integer val = 100/0;
    }
    
    @future 
    public static void method2(){
        System.debug('future method 2');
    }
    
    @future 
    public static void method3(){
        System.debug('future method 3');
    }

    @future
    public static void createUser(){     
        UserRole role = [Select Id From UserRole Where Name = 'COO' Limit 1];
        Profile profile = [Select Id From Profile Where Name = 'Minimum Access - Salesforce' Limit 1];
        String orgId = UserInfo.getOrganizationId();
        String dateString = 
            String.valueOf(DateTime.now()).replace(' ','').replace(':','').replace('-','');
        Integer randomInt = Integer.valueOf(math.round(math.random() * 1000000));
        String uniqueName = orgId + dateString + randomInt;
        User tempUser = new User(
            FirstName = 'Test',
            LastName = 'User',
            email = uniqueName + '@sfdc' + orgId + '.org',
            UserName = uniqueName + '@sfdc' + orgId + '.org',
            EmailEncodingKey = 'ISO-8859-1',
            Alias = uniqueName.substring(18, 23),
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            LanguageLocaleKey = 'en_US',
            ProfileId = profile.Id,
            UserRoleId = role.Id
        );

        Insert tempUser;
    }
}