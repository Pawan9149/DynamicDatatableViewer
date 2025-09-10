trigger AccountTrigger on Account(before insert, after insert, before update, after update, before delete, After delete){
	//System.debug('Before Insert Trigger...');
    //for(Account acc : Trigger.new){
    //    acc.Description = 'Test Description';
    //}
    AccountTriggerHandler handler = new AccountTriggerHandler();
    if(Trigger.isInsert){
        if(Trigger.isBefore){
            handler.beforeInsert(Trigger.new);
        }
    }
    else if(Trigger.isUpdate){
        if(Trigger.isBefore){
            AccountTriggerHandler accObj = new AccountTriggerHandler();
            accObj.AccBeforeUpdate(Trigger.new, Trigger.oldMap);
        }
    }
    else if(Trigger.isDelete && Trigger.IsBefore){
        AccountTriggerHandler accObj = new AccountTriggerHandler();
        accObj.AccBeforeDelete(Trigger.old);
    }
    
}