public with sharing class DmlOperations {
   public void Dml_Operation(){
//     Account acc = new Account();
//     acc.Name = 'Naman Soni';

//     insert acc;

    // Opportunity op = new Opportunity(Name = 'Naman Opp', StageName = 'Prospects', CloseDate = Date.newInstance(2025, 8, 15));
    // insert op;
    
    // Opportunity op = [Select Id, Name From Opportunity Where Name = 'Naman Opp'];
    // op.Name = 'Sameer';
    // update op;

    // List<Account> accList = new List<Account>{
    //     new Account(Name = 'Pawan', Industry = 'BMW'),
    //     new Account(Name = 'Sunil', Industry = 'BMW'),
    //     new Account(Name = 'Sagar', Industry = 'BMW')
    // };

    // insert accList;
    // List<Account> accList = new List<Account>{ new Account(Name = 'Lucky', Industry = 'BMW')};

    // List<Account> accList = [Select Id, Name, Industry From Account Where Industry = 'BMW' LIMIT 3];

    // for(Account acc : accList){
    //     acc.Industry = 'Mercedes';
    // }

    // update accList;

    // Account acc = [Select Id, Name From Account Where Name = 'Sagar' Limit 1];
    // delete acc;

    // List<Account> accList = [Select Id, Name From Account Where Industry = 'Mercedes'];
    // delete accList;

    // Account acc = new Account();
    // acc.Id = '001gK00000EhFi6QAF';
    // acc.Name = 'Lucky Sharma';


    // upsert acc;

    // Account acc = [Select Id From Account Where Industry = 'BMW' LIMIT 1];
    // acc.Name = 'Pawann';
    // update acc;

    // List<Account> delIdList = [Select Id From Account Where Name In ('Pawan', 'Sagar') and IsDeleted = True All Rows];
    // System.debug(delIdList);

    // undelete delIdList;


    // List<Contact> conList = [Select Id, Name, AccountId, Account.Industry From Contact Where AccountId != null];
    // System.debug(conList);
    // List<Account> accList = new List<Account>();
    // for(Contact con: conList){
    //     if(!accList.contains(con.Account)){
    //         accList.add(con.account);
    //     }
    // }
    // for(Account acc: accList){
    //     acc.Industry = 'Finance';
    // }
    // Update accList;
    // System.debug(accList);


    Integer TotalAccount = 5;
    Integer ContactCount = 1;
    List<Account> accList = new List<Account>();
    List<Contact> conList = new List<Contact>();
    for(Integer i = 0; i< TotalAccount; i++){
        Account acc = new Account(Name = 'Account' + i);
        accList.add(acc);
    }
    System.debug(accList);
    insert accList;
    for(Account acc : accList){
        conList.add(new Contact(FirstName = 'Contact' + ContactCount, LastName = 'Contact', AccountId = acc.Id));
        conList.add(new Contact(FirstName = 'Contact' + ContactCount, LastName = 'Contact', AccountId = acc.Id));
        ContactCount++;
    }
    System.debug(conList);
    insert conList;
    

   }
}