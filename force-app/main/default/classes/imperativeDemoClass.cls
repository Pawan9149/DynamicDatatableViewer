public with sharing class imperativeDemoClass {

    @AuraEnabled
    public static List<Account> getAccounts(){
        return [Select Id, Name from Account];
    }
}