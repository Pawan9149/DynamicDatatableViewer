public with sharing class datatableAssignmentController {
    
    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> getObjectList(){
        //New comment
        // One more

        List<Map<String, String>> SObjectList = new List<Map<String, String>>();

        for(Schema.SObjectType objType : Schema.getGlobalDescribe().Values()){
            Schema.DescribeSObjectResult describeObj = objType.getDescribe();

            if (!describeObj.isCustomSetting() && describeObj.isQueryable() && describeObj.isAccessible() && !describeObj.isDeprecatedAndHidden()) {
                Map<String, String> objInfo = new Map<String, String>();
                objInfo.put('label', describeObj.getLabel());  
                objInfo.put('value', describeObj.getName());    
                SObjectList.add(objInfo);
            }

        }

        return SObjectList;

    }

    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> getFieldList(String objectApiName){

        List<Map<String, String>> fieldList = new List<Map<String, String>>();

        try{
            Schema.SObjectType sObjectType = Schema.getGlobalDescribe().get(objectApiName);

            // if (sObjectType != null) {
                Map<String, Schema.SObjectField> fieldMap = sObjectType.getDescribe().fields.getMap();
    
                for (String fieldName : fieldMap.keySet()) {
                    Map<String, String> fields = new Map<String, String>();
                    Schema.DescribeFieldResult describeField = fieldMap.get(fieldName).getDescribe();
                    if(describeField.isAccessible()){
                        Boolean editable = describeField.isUpdateable();
                        String permission = editable ? 'true' : 'false';
                        fields.put('label', describeField.getLabel());
                        fields.put('value', describeField.getName());
                        fields.put('updateable', permission);
                        fieldList.add(fields);
                    }
                }
            // }
            return fieldList;
        }
        catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }

    }

    @AuraEnabled
    public static List<SObject> getRecords(String objectApiName, String Fields, String CurrentId){

        List<SObject> objRecords = new List<SObject>();

        String Query = '';

        if(CurrentId == ''){
            Query = 'Select ' + Fields + ' From ' +  objectApiName + ' ORDER BY Id LIMIT 50';
            System.debug('Query: ' + Query);
        }
        else{
            Query = 'Select ' + Fields + ' From ' +  objectApiName + ' WHERE Id > \'' + CurrentId + '\'' + ' ORDER BY Id LIMIT 50';
            System.debug('Query: ' + Query);
        }

        try{
            objRecords = Database.query(Query);
            System.debug('Result: ' + objRecords);
    
            // This enforces the FLS and restricts the records of the field that are not accessible to the current user
            SObjectAccessDecision securityDecision = Security.stripInaccessible(AccessType.READABLE, objRecords);
    
            return securityDecision.getRecords();
        }
        catch(Exception e){
            return null;
        }

    }

    @AuraEnabled
    public static String updateRecords(List<SObject> RecordList){
        Database.SaveResult[] result = Database.update(RecordList, false); 
        List<String> errList = new List<String>();
        for(Database.SaveResult sr : result){
            if(!sr.isSuccess()){
                errList.add(sr.getId() + ' ' + sr.getErrors());
            }
        }

        if(!errList.isEmpty()){
            System.debug('ErrList: ' + errList);
            return errList.toString();
        }
        else{
            return 'Success';
        }
    }

}