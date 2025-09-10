public class OpportunityTriggerHandler {
    public void OpportunityAfterUpdate(List<Opportunity> oppList, Map<Id, Opportunity> oldMap){
        List<Task> taskList = new List<Task>();
        for(Opportunity op : oppList){
            if(op.StageName == 'Closed Won'){
                taskList.add(new Task(Subject = 'Call',OwnerId = op.OwnerId, Priority = 'High', WhatId = op.Id));
            }
        }
        if(!taskList.isEmpty()){
            Insert taskList;
        }
        List<Opportunity> OpportunityRecords = [Select ID, AccountId, Name, Account.BillingCity, City__c From Opportunity Where Id In :oppList];
        List<Account> AccountRecords = new List<Account>();
        for(Opportunity opObj : OpportunityRecords){
           if(opObj.City__c != oldMap.get(opObj.Id).City__c){
                opObj.Account.BillingCity = opObj.City__c;
                AccountRecords.add(opObj.Account);
            }
        }
        Update AccountRecords;

        
    }
    
    public static void OpportunityAfterDelete(List<Opportunity> OpportunityRecords){
        Map<Id, Id> OppAccIds = new Map<Id, Id>();
        Map<Id, Id> AccOwnerIds = new Map<Id, Id>();
        Set<Id> AccountIds = new Set<Id>();
        List<Task> TaskList = new List<Task>();
        
        for(Opportunity oppObj : OpportunityRecords){
            OppAccIds.put(oppObj.Id, oppObj.AccountId);
            AccountIds.add(oppObj.AccountId);
        }
        List<Account> AccountRecords = [Select Id, OwnerId From Account Where Id In :AccountIds];
        for(Account accObj : AccountRecords){
            AccOwnerIds.put(accObj.Id, accObj.OwnerId);
        }
        
        for(Opportunity oppObj : OpportunityRecords){
            TaskList.add(new Task(
				Description = 'Please investigate why the opportunity is deleted',
                Priority = 'High',
                OwnerId = AccOwnerIds.get(OppAccIds.get(oppObj.Id)),
                Status = 'Not Started',
                Subject = 'Follow Up',
                WhatId = OppAccIds.get(oppObj.Id)
            ));
        }
        
        if(!TaskList.isEmpty()){
            Insert TaskList;
        }
        
    }
    
    public static void oppContactAccountAfterUpdate(List<Opportunity> OpportunityRecords, Map<Id, Opportunity> oldOppMap){
        Set<Id> AccountIds = new Set<Id>();
        List<Account> AccountRecords = new List<Account>();
        List<Contact> ContactRecords = new List<Contact>();
        List<Opportunity> OpportunityRecordList = [Select Id, Name, TestPhoneOpportunity__c, AccountId, Account.TestPhoneAccount__c From Opportunity Where Id In :OpportunityRecords];
        
        for(Opportunity opObj : OpportunityRecordList){
            AccountIds.add(opObj.AccountId);
            if(opObj.TestPhoneOpportunity__c != oldOppMap.get(opObj.Id).TestPhoneOpportunity__c){
                opObj.Account.TestPhoneAccount__c = opObj.TestPhoneOpportunity__c;
                AccountRecords.add(opObj.Account);
            }
        }
        System.debug('AccountRecords: ' + AccountRecords);
        Update AccountRecords;
        ContactRecords = [Select Id, TestPhoneContact__c, AccountId, Account.TestPhoneAccount__c From Contact Where AccountId In :AccountIds];
        for(Contact conObj : ContactRecords){
            conObj.TestPhoneContact__c = conObj.Account.TestPhoneAccount__c;
        }
        Update ContactRecords;
        
        
    }
    
    public void OpportunityBeforeUpdate(List<Opportunity> newOppList, Map<Id, Opportunity> oldMap){
        for(Opportunity newOpp : newOppList){
            if(oldMap.get(newOpp.Id).StageName != newOpp.StageName){
                newOpp.Amount = newOpp.Probability  * newOpp.ExpectedRevenue ;
            }
        }
        
        
    }
}