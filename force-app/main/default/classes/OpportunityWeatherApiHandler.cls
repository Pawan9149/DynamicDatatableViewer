public class OpportunityWeatherApiHandler {
    public static List<Opportunity> OppoList = new List<Opportunity>();
    public static void OpportunityActivity(List<Opportunity> oppRecords, Map<Id, Opportunity> oppOldMap){
        List<Id> OppIds = new List<Id>();
         
        for(Opportunity oppObj : oppRecords){
            if(oppObj.StageName == 'Closed Won' && oppObj.StageName != oppOldMap.get(oppObj.Id).StageName){
                OppIds.add(oppObj.Id);
            }
        }
        if(!OppIds.isEmpty()){
            System.debug('Opp Id: ' + OppIds);
            OpportunityWeatherQueueable OppQueueableObj = new OpportunityWeatherQueueable(OppIds);
            Id jobId = System.enqueueJob(OppQueueableObj);
           /* OppoList = [Select Id, Name, Description, AccountId, Account.BillingCity, Account.BillingCountry 
                        From Opportunity 
                        Where Id In :OppIds AND Account.BillingCity != Null AND Account.BillingCountry != Null];
                
            if(!OppoList.isEmpty()){
                System.debug('Opp List: ' + OppoList);
               //OpportunityWeatherQueueable OppQueueableObj = new OpportunityWeatherQueueable(OppoList);
               //Id jobId = System.enqueueJob(OppQueueableObj);
            }*/
            
        }
        
        
    }
}