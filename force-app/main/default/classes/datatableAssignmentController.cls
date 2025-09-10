public with sharing class datatableAssignmentController {
    
    @AuraEnabled(cacheable=true)
    public static List<Map<String, String>> getObjectList(){
        //New comment

        List<Map<String, String>> SObjectList = new List<Map<String, String>>();

        for(Schema.SObjectType objType : Schema.getGlobalDescribe().Values()){
            Schema.DescribeSObjectResult describeObj = objType.getDescribe();

            if (!objType.getDescribe().isCustomSetting() && objType.getDescribe().isQueryable() && !objType.getDescribe().isDeprecatedAndHidden()) {
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

        Schema.SObjectType sObjectType = Schema.getGlobalDescribe().get(objectApiName);

        if (sObjectType != null) {
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
        }


        return fieldList;

    }

    @AuraEnabled
    public static List<SObject> getRecords(String objectApiName, String Fields){

        List<SObject> objRecords = new List<SObject>();

        String Query = 'Select ' + Fields + ' From ' +  objectApiName;

        objRecords = Database.query(Query);
        System.debug('Result: ' + objRecords);

        return objRecords;

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
