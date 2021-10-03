import ballerina/http;
import ballerina/log;
import ballerina/openapi;

service RegainLearningMaterial on new http:Listener(9092) {
    
    
    @http:ResourceConfig {
        methods: ["GET"],
        path: "/details/{topic}"
    }
    resource function RegainLearningMaterial(http:Caller caller, http:Request req,string name) {
        json|error payload = req.getJsonPayload();
        http:Response response = new;
        if(payload is json){
            var nam = payload.learningMaterial.name;
            var description = topics[nam.toString()];
            var difficulty = background[nam.toString()];
            json myResult = {"learner Details":description,"background ":strain};
            response.setContentType("application/json ");
            response.setJsonPayload(myResult);
            io:println("DETAILS =>",description,strain);
            var responseRes = caller->respond(response);

            if (responseRes is error){
                log:printError("Error while sending response", err = responseRes);
            }

        }

        var nam = req.getJsonPayload();
    }
}