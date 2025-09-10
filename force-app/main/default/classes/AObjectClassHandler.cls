public class AObjectClassHandler {
   public static void beforeInsertAobj(List<AObj__c> listAobj, List<AObj__c> listAobj1){
    System.debug('New: ' + listAobj);
    System.debug('Old: ' + listAobj1);
   }
}