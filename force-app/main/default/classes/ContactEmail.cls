public class ContactEmail {
    public static void emailRecords(){
        List<Contact> contactResult = [Select Email From Contact Where Email != ''];
        List<String> emailString = new List<String>();
        for(Contact cn: contactResult){
            emailString.add(cn.Email);
        }
        System.debug('Email - ' + emailString);
        //List<Lead> leadResult = Database.query('Select Name From Lead Where Email In' + emailString);
        List<Lead> leadResult = [Select Name From Lead Where Email In :emailString];
        System.debug('Lead - ' + leadResult);
    }
}