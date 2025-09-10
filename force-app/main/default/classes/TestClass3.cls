public with sharing class TestClass3 extends TestClass2{
    public TestClass3(){
        super();
        System.debug('Child Constructor');
    }
    public override void displayMessage(){
        System.debug('Hello this is Test Class 33');
        System.debug('Val : ' + val);
        val = 25;
        System.debug('Val : ' + val);
    }

    // public void displayMessage1(){
    //     System.debug('Hello this is Test Class 33');
    // }
}