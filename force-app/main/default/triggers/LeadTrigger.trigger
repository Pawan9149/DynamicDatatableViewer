trigger LeadTrigger on Lead (after Insert, before update, before insert) {
	if(trigger.isBefore &&( trigger.isUpdate && trigger.isInsert)){
        LeadTriggerHandler leadObj = new LeadTriggerHandler();
        //leadObj.leadBeforeUpdate(Trigger.new);   
        leadObj.leadBeforeInsertUpdate(Trigger.new);
    }else if(Trigger.isInsert && Trigger.isAfter){
        LeadTriggerHandler leadObj1 = new LeadTriggerHandler();
        leadObj1.leadAfterInsert(Trigger.new);
    }
}