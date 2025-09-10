public with sharing class TestClass {
    public Void testMethod1() {
        List<String> itmLst = new List<String>();
        List<String> itmLst1 = new List<String>();

        itmLst.add('Item 1');
        itmLst.add('Item 2');
        itmLst.add('Item 3');

        itmLst1.add('Item 4');
        itmLst1.add('Item 5');


        itmLst.addAll(itmLst1);

        System.debug('List Values >>>>>>' + itmLst);
        System.debug('List Values >>>>>>' + itmLst1);
        
        // itmLst1.clear();
        itmLst1.add('Item 6'); 
        System.debug('List Values >>>>>>' + itmLst1);
        
        itmLst1 = itmLst.clone();
        System.debug('List Values >>>>>>' + itmLst1);
    }
}