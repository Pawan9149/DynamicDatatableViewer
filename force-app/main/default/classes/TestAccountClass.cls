public class TestAccountClass {
    public static void AccounttaskInsertion(){
        List<Account> AccountRecords = [Select Id, Name, Phone, OwnerId From Account Where Phone = null];
        List<Task> TaskRecords = new List<Task>();
        System.debug('AccountList: ' + AccountRecords);
        if(!AccountRecords.isEmpty()){
            for(Account accObj : AccountRecords){
            	TaskRecords.add(new Task(
                    Subject = 'Phone Number is Missing',
                    Status = 'Not Started',
                    Priority = 'Urgent',
                    Description = 'The phone number for the account ' + accObj.Name + ' is missing. Please collect the information asap',
                    OwnerId = accObj.OwnerId,
                    WhatId = accObj.Id
                ));
        	}
            System.debug('TaskList: ' + TaskRecords);
            Insert TaskRecords;
        }
    }
}