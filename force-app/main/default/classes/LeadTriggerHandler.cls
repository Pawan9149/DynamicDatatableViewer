public class LeadTriggerHandler {
    public void leadBeforeUpdate(List<Lead> leadList){
        for(Lead ld : leadList){
            if(ld.Industry == 'Healthcare'){
                ld.LeadSource = 'Purchased List';
                ld.SICCode__c = '1100';
                ld.Primary__c = 'Yes';
            }
        }
    }
    
    public void leadAfterInsert(List<Lead> leadList){
        List<Task> taskList = new List<Task>();
        for(Lead ld : leadList){
            taskList.add(new Task(Subject = 'Email', OwnerId = ld.OwnerId, Priority = 'Low', whoId = ld.Id));
        }
        
        if(!taskList.isEmpty()){
            insert taskList;
        }
    }

    public void leadBeforeInsertUpdate(List<Lead> leadRcords){
        Set<String> leadEmailSet = new Set<String>();
        if(!leadRcords.isEmpty()){
            for(Lead ldObj : leadRcords){
                if(ldObj.Email != null){
                    leadEmailSet.add(ldObj.Email);
                }
            }
        }

        List<Contact> DuplicateContactList = [Select Id, Email From Contact Where Email In :leadEmailSet];
        List<String> DuplicateEmailList = new List<String>();
        if(!DuplicateContactList.isEmpty()){
            for(Contact conObj : DuplicateContactList){
                DuplicateEmailList.add(conObj.Email);
            }
        }

        for(Lead ldObj : leadRcords){
            if(!String.isBlank(ldObj.Email)){
                if(DuplicateEmailList.contains(ldObj.Email)){
                    ldObj.addError('Duplicate Email to contact');
                }
            }else{
                ldObj.Email.addError('Enter Email Address');
            }
        }
    }
}