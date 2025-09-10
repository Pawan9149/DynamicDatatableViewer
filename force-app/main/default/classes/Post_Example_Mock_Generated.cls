global class Post_Example_Mock_Generated implements HttpCalloutMock{
	
    global HttpResponse respond(HttpRequest request){
        HttpResponse response = new HttpResponse();
        response.setBody('[{"id":"001gK00000GNO4aQAH","success":true,"errors":[]},{"id":"001gK00000GNO4bQAH","success":true,"errors":[]},{"id":"001gK00000GNO4cQAH","success":true,"errors":[]}]');
        response.setStatusCode(200);
        return response;
    }
    
}