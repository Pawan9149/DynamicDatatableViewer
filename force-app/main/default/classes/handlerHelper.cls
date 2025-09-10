public with sharing class handlerHelper {
    public void contactHelperHandler(List<Contact> conList){
        Boolean isDuplicateEmail = false;
        if(!conList.isEmpty()){
            Set<String> ContactEmailSet = new Set<String>();
            Set<Id> ContactIdSet = new Set<Id>();
            for(Contact con : conList){
                if(con.Email != null){
                    ContactEmailSet.add(con.Email);
                    ContactIdSet.add(con.Id);
                }
            }

            if(!ContactEmailSet.isEmpty()){
                List<Contact> DuplicateContList = [Select Id,Name From Contact Where Email != null and Email In :ContactEmailSet and Id Not In :ContactIdSet Limit 1];
                if(!DuplicateContList.isEmpty()){
                    isDuplicateEmail = true;
                }
            }
            
        }
        
        for(Contact con : conList){
            if(con.Phone != null){
                if(con.Phone.length() != 10){
                    con.Phone.addError('Phone Number Length Should be 10 digit');
                }
            }else{
                con.Phone.addError('Enter Phone Number');
            }

            if(con.Email != null){
                if(isDuplicateEmail){
                    con.Email.addError('Duplicate Email, Please enter another email.');
                }
            }else{
                con.Email.addError('Please enter email address.');
            }

        }
    }
}