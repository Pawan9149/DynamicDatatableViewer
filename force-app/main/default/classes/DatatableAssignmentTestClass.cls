@isTest
public class DatatableAssignmentTestClass {
	
    @testSetup
    static void setupData(){
        List<Account> accList = new List<Account>();
        for(Integer i = 1; i <= 10; i++){
            Account acc = new Account(Name = 'Test Acc ' + i);
            accList.add(acc);
        }
        
        Insert accList;
    }
    
    @isTest
    static void getObjectTest(){
        User u = [Select Id from User Where UserName = 'pawanlal13570@gmail.com' Limit 1];
        
        System.runAs(u){
            List<Map<String, String>> ObjList = datatableAssignmentController.getObjectList();
            
            System.assert(ObjList.size() > 0 , 'No Objects Fetched');
        }
    }
    
    @isTest
    static void getFieldTest(){
        User u = [Select Id from User Where UserName = 'pawanlal13570@gmail.com' Limit 1];
        
        System.runAs(u){
            List<Map<String, String>> fieldList = datatableAssignmentController.getFieldList('Account');
            
            System.assert(fieldList.size() == 0 , 'List size is not Gt 0');
        }
        
        List<Map<String, String>> fieldList = datatableAssignmentController.getFieldList('Account');
            
        System.assert(fieldList.size() > 0 , 'List size is not Gt 0');
    }
    
    @isTest
    static void getFieldNegativeTest(){
        User u = [Select Id from User Where UserName = 'pawanlal13570@gmail.com' Limit 1];
        Boolean isError = false;
        
        System.runAs(u){
            try{
               List<Map<String, String>> fieldList = datatableAssignmentController.getFieldList('Accp'); 
            }
            catch(Exception e){
                isError = true;
                System.assertEquals('Script-thrown exception', e.getMessage() , 'Error message is not same as expected');
            }
            System.assert(isError , 'Actual Result is not Same as Expected');
        }
    }
    
    @isTest
    static void getRecordsTest(){
        
        List<SObject> recordList1 = datatableAssignmentController.getRecords('Account', 'Id,Name', ''); 
        
        System.assert(recordList1.size() >= 0, 'RecordList is null');
        
        List<SObject> recordList2 = datatableAssignmentController.getRecords('Account', 'Id,Name', '001gK00000CGYqBQAX'); 
        
        System.assert(recordList2.size() >= 0, 'RecordList is null');
        
    }
    
    @isTest
    static void getRecordsNegativeTest(){
        
        List<SObject> recordList1 = datatableAssignmentController.getRecords('Acco123', 'Id,Name', ''); 
        
        System.assert(recordList1 == null, 'RecordList is not null');
        
        List<SObject> recordList2 = datatableAssignmentController.getRecords('Account', 'I12,Name', '001gK00000CGYqBQ536'); 
        
        System.assert(recordList2 == null, 'RecordList is not null');
        
    }
    
    @isTest
    static void updateRecordsTest(){
        List<Account> objList = [Select Id, Name From Account Limit 5];
        
        for(Account obj : objList){
            obj.Name = obj.Name + ' Test';
        }
        
        String result = datatableAssignmentController.updateRecords(objList);
        
        System.assertEquals('Success', result, 'Actual is not same as Expected');
    }
    
    @isTest
    static void updateRecordsNegativeTest(){
        List<Account> accList = new List<Account>();
        for(Integer i = 1; i <= 10; i++){
            Account acc = new Account(Name = 'Test Acc ' + i);
            accList.add(acc);
        }
        
        String result = datatableAssignmentController.updateRecords(accList);
        
        System.assertEquals('error updating records', result, 'Actual is not same as Expected');
    }
	    
}