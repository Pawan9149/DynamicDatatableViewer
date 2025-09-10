public with sharing class contactDatatableDemo {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(){
        return [Select Id, FirstName, LastName, Account.Name, Title, Phone, Email From Contact];
    }

    @AuraEnabled
    public static String updateContacts(List<Contact> contactRecords){
        System.debug('Contact List: ' + contactRecords);
        Database.SaveResult[] result = Database.update(contactRecords, false); 
        List<String> errList = new List<String>();
        for(Database.SaveResult sr : result){
            if(!sr.isSuccess()){
                errList.add(sr.getId() + ' ' + sr.getErrors());
            }
        }

        if(!errList.isEmpty()){
            System.debug('ErrList: ' + errList);
            return errList.toString();
        }
        else{
            return 'Success';
        }
    }

    @AuraEnabled
    public static void createContact(Contact contact){
        //Database.SaveResult[] results = Database.insert(accList, false);
        insert contact;
    }

    @AuraEnabled
    public static String deleteRecords(List<Contact> contactDeletedRecords){
        Database.DeleteResult[] results = Database.delete(contactDeletedRecords, false);
        List<String> errorList = new List<String>();
        for(Database.DeleteResult dr : results){
            if(!dr.isSuccess()){
                errorList.add(dr.getId() + ' ' + dr.getErrors());
            }
        }
        if(!errorList.isEmpty()){
            return errorList.toString();
        }
        else{
            return 'Success';
        }
    }
}