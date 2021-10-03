import ballerina/http;
import ballerina/log;
import ballerina/openapi;

// enter the definition to renovate order
type learnerProfile record {

    string username;
    string course;
};

http:Client createLearnerProfileEP = new("http://localhost:9090/createLearnerProfile");

http:Client RenovateLearnerProfileEP = new("http://localhost:9092/updateLearnerProfile");

// endpoint service
listener http:Listener httpListener = new(9091);

@http:ServiceConfig {
    basePath:"/RenovateLearnerProfile"
}
service RenovateLearnerProfile on httpListener {
    // Resource that allow clients to place an order to be pick up
    @http:ResourceConfig {
        path : "/Renovate",
        methods: ["POST"],
    
    }
    resource function RenovateLearnerProfile(http:Caller caller, http:Request request) returns error? {
        http:Response response = new;
        json reqPayload;

        // Try parsing the JSON payload from the request
        var payload = request.getJsonPayload();
        if (payload is json) {
            reqPayload = payload;
        } else {
            response.statusCode = 400;
            response.setJsonPayload({"Message":" Not a valid JSON payload"});
            checkpanic caller->respond(response);
            return;
        }

        json username = reqPayload.username;
        json course = reqPayload.course;


        // If payload parsing fails, send a "Bad Request" message as the response
        if (stNo == null || course == null ) {
            response.statusCode = 400;
            response.setJsonPayload({"Message":"Bad Request - Invalid Remark Request payload"});
            checkpanic caller->respond(response);
            return;
        }

        //Details of learner profile to be updated
        learnerProfile profileForUpdate = {
            username: username.toString(),
            course:course.toString()
        };

        log:printInfo("Calling createLearner service:");

        json responseMessage;
        http:Request createLearnerProfileReq = new;
        json updatejson = check json.convert(profileForUpdate);
        createLearnerProfileReq.setJsonPayload(untaint updatejson);
        http:Response learnerProfileResponse=  check learnerProfileEP->post("/learnerProfile-info", createLearnerProfileReq);
        json learnerProfileResponseResponseJSON = check learnerProfileResponse.getJsonPayload();

        json updateFullDetails ={"Learner Profile Details":learnerProfileResponseJSON,"username and course info":"updateLearnerProfile SERVICE RESPONSE"};
        
        // Send response to the user
        responseMessage = {"Message":"Update information received"};
        response.setJsonPayload(responseMessage);
        checkpanic caller->respond(response);
        return;
    }
}
// Done by Dale Gowaseb 220101124 & Mel Ngairo 217133916
