public class NewAbstractClass extends AbstractClasss{
    public NewAbstractClass(){
        System.debug('Child Constructor');   
    }
    public NewAbstractClass(String Name){
        super(Name); 
        System.debug('Child Name:' + Name);  
    }
    public override void displayName(){
        System.debug('Hello Name');
    }
    public void displayChild(){
        System.debug('Hello Child');
    }
    public override void printHello(){
        System.debug('Hello ChildHlo');
        super.printHello();
        super.printMe();
    } 
}