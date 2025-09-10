public class AccountClassSedulable implements System.Schedulable{
	
    public void execute(System.SchedulableContext sc){
        System.debug('Schedule Class Executed');
        AccountBatchClass accountBatch = new AccountBatchClass();
        Id JobId = Database.executeBatch(accountBatch,200);
    }
}