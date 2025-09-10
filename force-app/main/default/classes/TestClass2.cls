public virtual with sharing class TestClass2 {
    public TestClass2(){
        System.debug('Parent Constructor');
    }
    public static Integer val = 10;
    public virtual void displayMessage(){
        System.debug('Hello World of Apex2');
        System.debug('Val -- ' + val);
    }
}