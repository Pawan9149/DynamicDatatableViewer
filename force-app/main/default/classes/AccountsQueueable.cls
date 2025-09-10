public class AccountsQueueable implements System.Queueable{
    /*public Set<Id> AccountIds;
    public AccountsQueueable(Set<Id> AccountIds){
        this.AccountIds = AccountIds;
    }*/
    
   /* public void execute(QueueableContext ctx){
        System.debug('Account Queueable Executed');
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
    }*/
    
    public List<Account> AccountRecords;
    public AccountsQueueable(List<Account> AccountRecords){
        this.AccountRecords = AccountRecords;
    }
    
    public void execute(QueueableContext ctx){
        System.debug('Queueable Executed!!');
        System.debug('AccountList: ' + AccountRecords);
        
        ContactsQueueable queueable = new ContactsQueueable(10, AccountRecords);
        Id jobId = System.enqueuejob(queueable);
        System.debug('JobId: ' + jobId);
        
        /*ContactsQueueable queueable1 = new ContactsQueueable(10, AccountRecords);
        Id jobId1 = System.enqueuejob(queueable1);
        System.debug('JobId: ' + jobId1);*/
        
        OpportunityQueueable queueable2 = new OpportunityQueueable();
        Id jobId2 = System.enqueuejob(queueable2);
        System.debug('Job Id: ' + jobId2);
        
        FutureMethodDemo.method2();
        FutureMethodDemo.method3();
    }
    
}