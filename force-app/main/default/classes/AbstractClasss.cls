public abstract class AbstractClasss {
    public AbstractClasss(){
        System.debug('Parent Constructor');
    }
    public AbstractClasss(String Name){
        System.debug('Parent Name: ' + Name);
    }
    public abstract void displayName();
    public virtual void printHello(){
        System.debug('Hello PGM');
    } 
    public void printMe(){
        System.debug('Hello Me');
    } 
}