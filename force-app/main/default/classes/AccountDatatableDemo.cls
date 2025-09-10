public with sharing class AccountDatatableDemo {
    @AuraEnabled
    public static List<Account> getAccounts(){
        return [Select Id, Name, Site, Phone, Type From Account Limit 10];
    }
}