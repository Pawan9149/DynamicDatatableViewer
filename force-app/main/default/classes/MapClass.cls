public class MapClass {
    public void mapVsObject(){
        List<Contact> conList = [Select Id, FirstName, LastName, AccountId, Account.Name, Account.Industry From Contact Where Email Like '%gmail%' And AccountId != Null];
        
        Map<Id, Account> accmap = new Map<Id, Account>();
        Map<Account, List<Contact>> ResultAccountVsContactMap = new Map<Account, List<Contact>>();
        
        for(Contact con : conList){
            Id accId = con.AccountId;
            Account acc = con.Account;
            
            if(!accMap.containskey(accId)){
                accMap.put(accId, acc);
                ResultAccountVsContactMap.put(acc, new List<Contact>());
            }
            ResultAccountVsContactMap.get(accMap.get(accId)).add(con);
        }
        
        for(Account acc : ResultAccountVsContactMap.KeySet()){
            
            System.debug('Account Id: ' + acc.Id + ' Name: ' + acc.Name + ' Industry: ' + acc.Industry);
            
            for(Contact con : ResultAccountVsContactMap.get(acc)){
                System.debug('Contact Id: ' + con.Id + ' FirstName: ' + con.FirstName + ' LastName: ' + con.LastName);
            }
        }
    }
}