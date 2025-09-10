public with sharing class NewTest {
    public void CasesVal(){
        List<Case> caseList = [Select Id, Priority From Case Where Priority = 'High' and IsClosed = False and CreatedDate < LAST_N_DAYS:3];
        for(Case cs : caseList){
            cs.IsEscalated = true;
            cs.Subject = 'Auto-escalated due to delay';
        }
        update caseList;
    }
}