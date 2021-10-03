import ballerina/http;
import ballerina/log;
import ballerina/openapi;

json LearnerProfile = {
    username: "",
    lastname: "",
    firstname: "",
    preferred_formats: ["audio","video","text"],
    past_subjects: [
        {
            course: "Algorithms",
            score: "B+"
        },
        {
            course: "Programming I",
            score: "A+"
        }
    ]     
};

json LearningMaterial  {
        course: "Distributed System Application",
        learning_objects: {
            required: {
                audio: [{
                    name: "Topic 1",
                    description: "",
                    difficulty: ""
                }],
                text: [{}]
            };
            suggested: {
                video: []
                audio: []
            }
        }
};
    
//  final point for client generation.
@openapi:ClientEndpoint
listener http:Listener createLearnerProfileEp = new(9090);

// The service that enable the client to generate code.
@openapi:ClientConfig {
    generate: true
}
@http:ServiceConfig {
    basePath: "/client"
}
service GenerateLearnerProfile on generateLearnerProfileEp {    
    @http:ResourceConfig {
        methods: ["POST"],
        path: "/generateLearnerProfile"
    }
    resource function generateLearnerProfile(http:Caller caller, http:Request req) returns error? {
        http:Response res = new;
        json responseMessage;
        json learnerProfileInfoJSON = check request.getJsonPayload();

        log:printInfo("JSON :::" + learnerProfileInfoJSON.toString());

        string username = learnerProfileInfoJSON.username.toString();
        string course =  lLearnerProfileInfoJSON.course.toString();

        any|error responseOutcome;
        if(LearnerProfile.hasKey(course)){
            json  LearnerProfile = check json.convert(LearnerProfile[course]);
            LearnerProfile reqlearning_material = {
            username: LearnerProfile.username.toString(),
            lastname: LearnerProfile.lastname.toString(),
            fistname: LearnerProfile.firstname.toString(),
            course: LearnerProfile.course.toString(),
            score:  LearnerProfile.score.toString()
            };
            json details =   check (json.convert(req LearnerProfile));
            log:printInfo(" LearnerProfile details:" + details.toString());


            json  LearnerProfilejson = check json.convert(req LearnerProfile);
            responseMessage = {" leanerprofile": LearnerProfilejson};
            io:println(" LearnerProfile details");
            io:println( LearnerProfilejson);
            log:printInfo("All details are included in response:" +  LearnerProfilejson.toString());
            res.setJsonPayload(untaint responseMessage);
            responseOutcome = caller->respond(res);

        }else{
            responseMessage = {"message":"Error:leaner profile provided is not valid"};
            res.setJsonPayload(untaint responseMessage);
            io:println(responseMessage);
            responseOutcome = caller->respond(res);
        }

        return;
    }
}
// Done by Dale Gowaseb 220101124 & Mel Ngairo 217133916