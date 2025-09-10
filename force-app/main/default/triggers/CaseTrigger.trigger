trigger CaseTrigger on Case (before insert) {
    if(Trigger.isInsert){
        if(Trigger.isBefore){
            CaseTriggerHandler caseObj = new CaseTriggerHandler();
            caseObj.caseBeforeInsert(Trigger.new);
        }
    }
}