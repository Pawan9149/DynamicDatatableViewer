public class ContactsQueueable implements Queueable{
    public Integer TotalRelatedContacts;
    public List<Account> accountList;
    public ContactsQueueable(Integer TotalRelatedContacts, List<Account> accountList){
        this.TotalRelatedContacts = TotalRelatedContacts;
        this.accountList = accountList;
    }
    
    public void execute(System.QueueableContext ctx){
        System.debug('Contact Queueable Executed');
        System.debug('TotalRelatedContacts: ' + TotalRelatedContacts);
        System.debug('accountList: ' + accountList);
        FutureMethodDemo.method2();
        FutureMethodDemo.method3();
        /*OpportunityQueueable queueable = new OpportunityQueueable();
        Id jobId = System.enqueuejob(queueable);
        System.debug('Job Id: ' + jobId);*/
    }
    
}