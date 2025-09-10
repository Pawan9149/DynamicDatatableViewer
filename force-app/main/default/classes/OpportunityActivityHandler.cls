public class OpportunityActivityHandler {
    
    public static void OpportunityVsAccount(List<Opportunity> opportunityRecords){
      	Set<Id> AccountIds = new Set<Id>();
        for(Opportunity oppObj : opportunityRecords){
            AccountIds.add(oppObj.AccountId);
        }
        List<AggregateResult> arList = [Select 
                                    AccountId, Count(Id) cid 
                                    from 
                                    Opportunity 
                                    Where AccountId In :AccountIds AND StageName = 'Closed Won' 
                                    Group By AccountId 
                                    Having Count(Id) > 5];
        
        AccountIds.clear();
        for(AggregateResult ar : arList){
            AccountIds.add((Id)ar.get('AccountId'));
        }
        
        
        List<Account> AccountRecords = [Select Id, Name, Type From Account Where Id In :AccountIds];
        if(!AccountRecords.isEmpty()){
            for(Account accObj : AccountRecords){
            	accObj.Type = 'Vip Customer';
        	}
            
            Update AccountRecords;
        }
    }
    
}