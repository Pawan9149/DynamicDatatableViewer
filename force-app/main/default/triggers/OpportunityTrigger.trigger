trigger OpportunityTrigger on Opportunity (before insert, After update, before Update) {
    if(Trigger.isUpdate && Trigger.isAfter){
        OpportunityTriggerHandler oppObj = new OpportunityTriggerHandler();
        oppObj.OpportunityAfterUpdate(Trigger.new);
    }
    else if(Trigger.isUpdate && Trigger.isBefore){
        OpportunityTriggerHandler oppObj1 = new OpportunityTriggerHandler();
        oppObj1.OpportunityBeforeUpdate(Trigger.new, Trigger.oldMap);
    }
}