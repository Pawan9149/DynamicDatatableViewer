public class AccountTriggerHandler {
    public void beforeInsert(List<Account> accList){
        for(Account acc : accList){
            acc.Description = 'Test Trigger Description';
        }
    }
    
    // public static void beforeUpdate(List<Account> accList, Map<Id, Account> AccOldMap){
    //     for(Account acc : accList){
    //         if(acc.Industry == 'Agriculture' && acc.Type == 'Prospect'){
    //             if(AccOldMap.get(acc.Id).Ownership != acc.Ownership){
    //                 acc.Ownership.addError('Cannot Modify the Ownership');
    //             }
    //         }
    //     }
    // }
    
    public static void AccountAfterUpdate( Map<Id, Account> newAccountMap, Map<Id, Account> oldAccountMap){
        List<Contact> contactList = [Select Id,OtherPhone, HomePhone, AccountId From Contact Where AccountId In :newAccountMap.keySet()];
        for(Contact conObj : contactList){
            if(newAccountMap.get(conObj.AccountId).Phone != oldAccountMap.get(conObj.AccountId).Phone){
                conObj.OtherPhone = oldAccountMap.get(conObj.AccountId).Phone;
                conObj.HomePhone = newAccountMap.get(conObj.AccountId).Phone;
            }
        }
        Update contactList;
        
       	List<AggregateResult> Results = [Select AccountId, Count(Id) Cid From Contact Where AccountId In :newAccountMap.keySet() Group By AccountId];
        Map<Id, Integer> AccConMap = new Map<Id, Integer>();
        for(AggregateResult ar : Results){
            AccConMap.put((Id)ar.get('AccountId'), (Integer)ar.get('Cid'));
        }
        List<Contact> ContactRecords = [Select Id, Balance__c, Name , AccountId, Account.Total_Balance__c From Contact Where AccountId In :newAccountMap.keySet()];
        for(Contact conObj : ContactRecords){
            if(newAccountMap.get(conObj.AccountId).Total_Balance__c > 0 && newAccountMap.get(conObj.AccountId).Total_Balance__c != oldAccountMap.get(conObj.AccountId).Total_Balance__c){
                conObj.Balance__c = (conObj.Account.Total_Balance__c / AccConMap.get(conObj.AccountId));
            }
            else if(newAccountMap.get(conObj.AccountId).Total_Balance__c <= 0 || newAccountMap.get(conObj.AccountId).Total_Balance__c == null){
               conObj.Balance__c = 0; 
            }
        }
        Update ContactRecords;
        
    }
    
    public static void AccConAfterUpdate(Map<Id, Account> newAccountMap, Map<Id, Account> oldAccountMap){
        List<Contact> ContactRecords = [Select Id, Name, Website__c , AccountId, Account.Website From Contact Where AccountId In :newAccountMap.keySet()];
        for(Contact conObj : ContactRecords){
            If(newAccountMap.get(conObj.AccountId).Website != null && newAccountMap.get(conObj.AccountId).Website != oldAccountMap.get(conObj.AccountId).Website){
                conObj.Website__c = conObj.Account.Website;
            }
            else if(newAccountMap.get(conObj.AccountId).Website == null){
                conObj.Website__c = null;
            }
        }
        Update ContactRecords;
    }
    


    public void AccBeforeUpdate(List<Account> accountRecords, Map<Id, Account> AccOldMap){
        if(!accountRecords.isEmpty()){
            for(Account accObj : accountRecords){
                if(accObj.Phone != null && accObj.Phone.length() == 10){
                    if(AccOldMap.get(accObj.Id).Phone != accObj.Phone){
                        if(accObj.Name.indexOf('-') > 0){
                            accObj.Name = accObj.Name.substring(0, accObj.Name.indexOf('-'));
                        }
                        accObj.Name = accObj.Name + '-' + accObj.Phone;
                    }
                }else if(accObj.Phone != null && accObj.Phone.length() != 10){
                    accObj.addError('Please Enter 10 digit Phone Number');
                }
            }
        }
    }

    public void AccBeforeDelete(List<Account> oldAccountRecords){
        if(!oldAccountRecords.isEmpty()){
            List<AggregateResult> results = [Select AccountId From Contact Where AccountId In :oldAccountRecords Group By AccountId Having Count(Id) >= 2];
            Set<Id> accountIds = new Set<Id>();
            for(AggregateResult ar : results){
                accountIds.add((Id)ar.get('AccountId'));
            }
            for(Account accObj : oldAccountRecords){
                if(accountIds.contains(accObj.Id)){
                    accObj.addError('Contains 2 or more related contacts');
                }
            }
        }
    }
}