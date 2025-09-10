trigger ContactTrigger on Contact (before insert, after insert, before update) {
    ContactTriggerHandler handler = new ContactTriggerHandler();

    if(Trigger.isInsert || Trigger.isUpdate){
        if(Trigger.isBefore){
            handler.beforeInsertUpdate(Trigger.new);
        }
    }
}