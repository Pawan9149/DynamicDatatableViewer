public with sharing class EventIntegrationQueueable implements Queueable, Database.AllowsCallouts{
	
    private Set<Id> eventIds;
    public EventIntegrationQueueable(Set<Id> eventIds){
        this.eventIds = eventIds;
    }
    
    public void execute(QueueableContext ctx){
       List<Event> events = [Select Subject, Description, IsAllDayEvent, StartDateTime, EndDateTime
                            From Event
                            Where Id In :eventIds ]; 
        
    	EventIntegrationService.syncToGCalender(events);
    }
}