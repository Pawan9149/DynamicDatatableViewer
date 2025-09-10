trigger AObjTrigger on AObj__c (before update) {
    AObjectClassHandler.beforeInsertAobj(Trigger.new, Trigger.old);
}