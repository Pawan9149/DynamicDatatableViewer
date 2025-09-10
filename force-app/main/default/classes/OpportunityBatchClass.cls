public class OpportunityBatchClass implements DataBase.Batchable<sObject>{
    
    public DataBase.QueryLocator start(DataBase.BatchableContext batchContext){
        System.debug('In Start');
        return DataBase.getQueryLocator('Select Id, Name, OwnerId, Owner.isActive From Opportunity Where StageName != null');
    }
    
    public void execute(DataBase.BatchableContext batchContext, List<Opportunity> OpportunityRecords){
        System.debug('In Execute');
        User userRecord = [Select Id From User Where Profile.Name = 'System Administrator' and isActive = true LIMIT 1];
        System.debug('UserId: ' + userRecord);
        System.debug('Opportunity: ' + OpportunityRecords);
        List<Task> TaskRecords = new List<Task>();
        for(Opportunity oppObj : OpportunityRecords){
            TaskRecords.add(new Task(
                Subject = 'Follow Up',
                Description = 'Review Opportunity asap',
                Status = 'Not Started',
                WhatId = oppObj.Id,
                OwnerId = oppObj.Owner.isActive == true ? oppObj.OwnerId : userRecord.Id
            ));
        }
        System.debug('TaskList: ' + TaskRecords);
        if(!TaskRecords.isEmpty()){
            System.debug('Innnnn');
            Insert TaskRecords;
        }
    }
    
    public void finish(DataBase.BatchableContext batchContext){
        System.debug('In Finish');
        
    }
    
}