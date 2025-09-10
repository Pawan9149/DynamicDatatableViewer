public class Demo1 {
	public String helloWorldString;
    public static final String DEFAULT_STRING;
    
    static{
        DEFAULT_STRING = 'Hello World';
    }
    
    public Demo1(){
        this(DEFAULT_STRING);
    }
    
    public Demo1(String stringToDisplay){
        helloWorldString = stringToDisplay;
    }
    
    public void printOutput(){
        System.debug('String is : ' + helloWorldString);
    }
}