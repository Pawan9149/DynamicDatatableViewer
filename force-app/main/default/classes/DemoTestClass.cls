@isTest
public class DemoTestClass {
    
    @TestSetup
    static void myTestSetup(){
        Account accountRecord = new Account(Name = 'TestAccount1', Phone = '9989786547', Industry = 'Agriculture');
        
        Insert accountRecord;
    }
	
    @isTest
    static void testMethod1(){
        Account accountRecord = [Select Id From Account Where Name = 'TestAccount1' LIMIT 1];
        
        Contact contactRecord = new Contact(FirstName = 'Naman', LastName = 'Soni', AccountId = accountRecord.Id);
    }
    
    @isTest
    static void testMethod2(){
        Account accountRecord = [Select Id From Account Where Name = 'TestAccount1' LIMIT 1];
        
        Opportunity oppRecord = new Opportunity(Name = 'TestOpp', AccountId = accountRecord.Id);
    }
    
    @isTest
    static void testMethod3(){}
    
    @isTest
    static void testMethod4(){}
    
    @isTest
    static void testMethod5(){}
    
}