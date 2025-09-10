public class ExpenseQueueableClass implements System.Queueable{
    
    public void execute(System.QueueableContext ctx){
        //Expense Record list whose status is Submitted
    	List<Expense__c> ExpList = [Select Id, Status__c, Amount__c From Expense__c Where Status__c = 'Submitted'];
        List<Audit_Expense__c> AdtExpList = new List<Audit_Expense__c>();
        String OldStatus;
        
        if(!ExpList.isEmpty()){
            for(Expense__c expObj : ExpList){
                OldStatus = expObj.Status__c;
                if(expObj.Amount__c > 1000){ 
                    expObj.Status__c = 'Approved'; //Expense amount is greater then 1000
                }else{
                    expObj.Status__c = 'Rejected'; //Expense amount is lesser then 1000
                }
                //Add the new Audit Expense when status is changed
                AdtExpList.add(new Audit_Expense__c(ExpenseId__c = expObj.Id, New_Status__c = expObj.Status__c, Old_Status__c = OldStatus));
        	}
            Update ExpList;
            if(!AdtExpList.isEmpty()){
                Insert AdtExpList;
            }
            System.debug(ExpList);
            System.debug(AdtExpList);
        }
        
    }
}