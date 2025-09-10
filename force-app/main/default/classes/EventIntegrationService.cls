public class EventIntegrationService {
    public static void syncToGCalender(List<Event> newEvents){
        for(Event event : newEvents){
            HttpRequest request = new HttpRequest();
            request.setEndpoint('callout:SalesforceCalenderNamedCredential/calendar/v3/calendars/primary/events');
            request.setMethod('POST');
            request.setHeader('Content-Type','application/json');
            
            String requestBody = serializeEvent(event);
            request.setBody(requestBody);
            new Http().send(request);
        }
    }
    
    public static String serializeEvent(Event e){
        Map<String, Object> jsonMap = new Map<String, Object>();
       	jsonMap.put('summary', e.Subject); 
        jsonMap.put('description', e.Description); 
        
        Map<String, Object> startMap = new Map<String, Object>();
        Map<String, Object> endMap = new Map<String, Object>();
        
        if(e.IsAllDayEvent == True){
            startMap.put('date', e.StartDateTime.date());
            endMap.put('date', e.StartDateTime.date().addDays(1));
        }
        else{
            startMap.put('dateTime', e.StartDateTime);
            startMap.put('timeZone', UserInfo.getTimeZone().getID());
            
            endMap.put('dateTime', e.EndDateTime);
            endMap.put('timeZone', UserInfo.getTimeZone().getID());
        }
        System.debug(startMap);
        jsonMap.put('start', startMap);
        jsonMap.put('end', endMap);
        
        return JSON.serialize(jsonMap);
    }
    
    public static void enqueueEventsForSyncToGCalender(List<Event> newEvents){
        System.enqueueJob(
            new EventIntegrationQueueable(new Map<Id, Event>(newEvents).keySet())
        );
    }
}