public class OpportunityQueueable implements System.Queueable{
    public void execute(QueueableContext ctx){
        System.debug('Opportunity Queueable Executed');
    }
}