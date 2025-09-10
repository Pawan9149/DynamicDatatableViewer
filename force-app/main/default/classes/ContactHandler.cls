public with sharing class ContactHandler {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String accId){
        try {
            return[
                Select AccountId, Id, FirstName 
                From Contact
                Where AccountId = :accId
                With SECURITY_ENFORCED
            ];//Here With SECURITY_ENFORCED means to apply the object & field level security
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

}