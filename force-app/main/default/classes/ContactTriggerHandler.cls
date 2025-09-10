public with sharing class ContactTriggerHandler {

    public void beforeInsertUpdate(List<Contact> contactRecords){
        System.debug('contactRecords: ' + contactRecords);
        Set<String> contactEmails = new Set<String>();
        Set<String> contactIds = new Set<String>();
        for(Contact conObj : contactRecords){
            if(conObj.Email != null){
                contactEmails.add(conObj.Email);
            }
        } 
        if(Trigger.isUpdate){
            for(Contact conObj : contactRecords){
                contactIds.add(conObj.Id);
            }
        }

        System.debug('contactEmails: ' + contactEmails);
        System.debug('contactIds: ' + contactIds);
        
        List<Contact> DuplicateContactList = [Select Id, Email From Contact Where Email In :contactEmails AND Id Not In :contactIds];
        List<String> DuplicateEmailList = new List<String>();
        if(!DuplicateContactList.isEmpty()){
            for(Contact conObj : DuplicateContactList){
                DuplicateEmailList.add(conObj.Email);
            }   
        }
        System.debug('DuplicateContactList: ' + DuplicateContactList);
        System.debug('DuplicateEmailList: ' + DuplicateEmailList);

        for(Contact conObj : contactRecords){
            if(!String.isBlank(conObj.Email)){
                if(DuplicateEmailList.contains(conObj.Email)){
                    conObj.Email.addError('Duplicate Email, Please enter another email.');
                }else{
                    DuplicateEmailList.add(conObj.Email);
                }
            }else{
                conObj.Email.addError('Please enter email address.');
            }
        }
        System.debug('DuplicateEmailList: ' + DuplicateEmailList);
    }
    
    public void ContactBeforeInsert(List<Contact> ContactRecords){
        Set<String> contactLastName = new Set<String>();
        Set<String> contactEmail = new Set<String>();
        Set<String> contactPhone = new Set<String>();
        
        for(Contact conObj : ContactRecords){
            contactLastName.add(conObj.LastName);
            contactEmail.add(conObj.Email);
            contactPhone.add(conObj.Phone);
        }
        List<Contact> DuplicateContacts = [Select Id, LastName, Email, Phone From Contact Where LastName In :contactLastName 
                                           AND Email In :contactEmail AND Phone In :contactPhone];
        
        List<String> DupContactLastName = new List<String>();
        List<String> DupContactEmail = new List<String>();
        List<String> DupContactPhone = new List<String>();
        for(Contact conObj : DuplicateContacts){
            DupContactLastName.add(conObj.LastName);
            DupContactEmail.add(conObj.Email);
            DupContactPhone.add(conObj.Phone);
            
        }
        
        for(Contact conObj : ContactRecords){
            if(DupContactLastName.Contains(conObj.LastName) && DupContactEmail.contains(conObj.Email) && DupContactPhone.contains(conObj.Phone)){
                conObj.AddError('Duplicate Contact Exists');
            }
            else{
                DupContactLastName.add(conObj.LastName);
            	DupContactEmail.add(conObj.Email);
            	DupContactPhone.add(conObj.Phone);
            }
        }
        
    }
    
    
}