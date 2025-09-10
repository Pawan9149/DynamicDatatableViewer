public class CustomObj {
    public static void objValue(String objName){
        List<sObject> result = Database.query('Select Id, Name From ' + objName);
        
        for(sObject obj: result){
            System.debug('Obj - ' + obj);
        }
    }
}