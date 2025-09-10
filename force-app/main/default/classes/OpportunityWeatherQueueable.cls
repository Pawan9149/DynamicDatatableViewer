public class OpportunityWeatherQueueable implements Queueable, Database.Stateful{
    
    private static List<Id> oppIds;
    
    public OpportunityWeatherQueueable(List<Id> oppId){
        System.debug('Above loop: ' + oppId);
        OpportunityWeatherQueueable.oppIds = oppId;
        System.debug('Main List: ' + oppIds);
        
    }
    
    public void execute(System.QueueableContext cxt){
        List<Opportunity> oppList = new List<Opportunity>();
        System.debug('In Queue: ' + oppIds);
        for(Id id : oppIds){
            Opportunity opp = [Select Id, Name, Description, AccountId
                        From Opportunity 
                        Where Id = :id AND Account.BillingCity != Null AND Account.BillingCountry != Null];
            Account account = [Select Id, Name, BillingCity, BillingCountry From Account Where Id = :opp.AccountId];
            Decimal currentTemp = WeatherCalloutApi.WeatherApi(account.BillingCity + ',' + account.BillingCountry);
            opp.Description = 'Weather at time of close: ' + currentTemp + '°C';
            oppList.add(opp);
        }
        /*for(Opportunity oppObj : oppRecords){
            Decimal currentTemp = WeatherCalloutApi.WeatherApi(oppObj.Account.BillingCity + ',' + oppObj.Account.BillingCountry);
            oppObj.Description = 'Weather at time of close: ' + currentTemp + '°C';
        }*/
        
        Update oppList;
    }

}