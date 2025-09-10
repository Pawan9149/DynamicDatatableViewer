public class AccountBatchClass implements Database.Batchable<sObject>{
    
    public DataBase.QueryLocator start(DataBase.BatchableContext batchContext){
        System.debug('Start Method Executed');
        return DataBase.getQueryLocator('Select Id, Name From Account Where Phone = null');
    }
    
    public void execute(DataBase.BatchableContext batchContext, List<sObject> Records){
        List<Account> AccountRecords = (List<Account>)Records;
        System.debug('Execute Method Executed');
        System.debug('AccountList: ' + AccountRecords);
    }
    
    public void finish(DataBase.BatchableContext batchContext){
        System.debug('Finish Method Executed');
    }
        
        
}