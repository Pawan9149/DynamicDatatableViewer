public class CaseTriggerHandler {
    public void caseBeforeInsert(List<Case> caseList){
        for(Case cs : caseList){
            if(cs.Origin == 'Phone'){
                cs.Priority = 'High';
            }else{
                cs.Priority = 'Low';
            }
        }
    }
}