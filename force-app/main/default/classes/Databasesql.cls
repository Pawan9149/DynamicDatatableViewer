public class Databasesql {
    public static void DatabaseResult(String FldName){
        List<Account> result = [Select Id, Name From Account Where Name = :FldName];
        
        for(Account obj: result){
            System.debug('Id - ' + obj.Id + ' Name - ' + obj.Name);
        }
    }

}