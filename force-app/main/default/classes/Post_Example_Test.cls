@isTest
public class Post_Example_Test {
	
    @isTest
    static void SendPostReqTest(){
        Test.setMock(HttpCalloutMock.class, new Post_Example_Mock_Generated());
        Test.startTest();
        HttpResponse res = Post_Example.SendPostReq();
        Test.stopTest();
        System.assertEquals(200, res.getStatusCode(),'Expected not equal to actual');
        
    }
    
}