public class ContactActivityHandler {
    public void ContactBeforeInsert(List<Contact> ContactRecords){
			//Integer count = 1;
       // if(!ContactRecords.isEmpty()){
           //	for(Contact conObj : ContactRecords){
               // System.Debug(DateTime.now().format('EEEE'));
           //     System.Debug(DateTime.now());
           		System.debug('List: ' + ContactRecords);
        		//System.debug(ContactRecords.size());
        	//	System.debug('Count: '+ count++);
                if(DateTime.now().format('EEEE') == 'Saturday' || DateTime.now().format('EEEE') == 'Sunday'){
                    System.debug('Records : ' + ContactRecords.get(0));
                    ContactRecords.get(0).AddError('Cannot Insert Records on Saturdays and Sundays');
                }
          // 	} 
        //}
        
    }
}