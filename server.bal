import ballerina/grpc;
import ballerina/io;
import ballerina/lang.'string;


listener grpc:Listener ep = new (9191);
map<addRequest> myMap = {};
service ProblmTwo on ep {

    resource function add_new_fn(grpc:Caller caller, addRequest value) {
     
        string full_name = recordReq.full_name;
        myMap[recordReq.full_name] = <@untained>recordReq;
        string payload = " Status : Record created; full_name :" + full_name;

        error? result = caller->send(payload);
        result = caller->complete();
        if (result is error) {
            log:printError("Error from Connector: " + result.reason() + "-" + <tring>result.detail()["message"] + "\n");
        }
        myMap[string.convert(full_name)] = value;
        json jObject = checkpanic json.convert(myMap[string.convert(full_name)]);
        string newValue = "Record value "+jObject.toString();
    }
     
    resource function add_fns(grpc:Caller caller, updateRequest value) {
    string payload;
        error? result = ();
        
        string full_name = add_fns.full_name;
        if (myMap.hasKey(full_name)) {
            // Update the existing Function to new version.
            myMap[full_name] = <@untained>add_fns;
            payload = "Record : '" + full_name + "' updated.";
            // Send response to the caller.
            result = caller->send(payload);
            result = caller->complete();
        } else {
            // Send entity not found error.
            payload = "Record : '" + full_name + "' Record does not exist";
            result = caller->sendError(grpc:NOT_FOUND, payload);
        }

        if (result is error) {
            log:printError("Error from Connector: " + result.reason() + " - "
                    + <string>result.detail()["message"] + "\n");
        }
        
    }
    resource function read_Function(grpc:Caller caller, readRequest value) {
    string payload = "";
        error? result = ();
        // read the requested record from the map.
        if (myMap.hasKey(full_name)) {
            var jsonValue = typedesc<json>.constructFrom(myMap[full_name]);
            if (jsonValue is error) {
                // Send casting error as internal error.
                result = caller->sendError(grpc:INTERNAL, <string>jsonValue.detail()["message"]);
            } else {
                json recordDetails = jsonValue;
                payload = recordDetails.toString();
                // Send response to the caller.
                result = caller->send(payload);
                result = caller->complete();
            }
        } else {
            // Send entity not found error.
            payload = "Record : '" + full_name + "' Record does not exist";
            result = caller->sendError(grpc:NOT_FOUND, payload);
        }

        if (result is error) {
            log:printError("Error from Connector: " + result.reason() + " - "
                    + <string>result.detail()["message"] + "\n");
        }
        
}

public type addRequest record {|
    record {| string full_name; string value; |}[] repositoryOfFunction = [];
|};

public type updateRequest record {|
    record {| string full_name; string value; |}[] repositoryOfFunction = [];
|};

public type readRequest record {|
    record {| string full_name; string value; |}[] repositoryOfFunction = [];
|};

public type addResponse record {|
    record {| string full_name; string value; |}[] repositoryOfFunction = [];
|};

public type updateResponse record {|
    record {| string full_name; string value; |}[] repositoryOfFunction = [];
|};

public type readResponse record {|
    record {| string full_name; string value; |}[] repositoryOfFunction = [];
|};



const string ROOT_DESCRIPTOR = "0A0F70726F746F46696C652E70726F746F2288010A0A61646452657175657374123B0A0A736F6E675265636F726418012003280B321B2E616464526571756573742E536F6E675265636F7264456E747279520A736F6E675265636F72641A3D0A0F536F6E675265636F7264456E74727912100A036B657918012001280952036B657912140A0576616C7565180220012809520576616C75653A023801228E010A0D75706461746552657175657374123E0A0A736F6E675265636F726418012003280B321E2E757064617465526571756573742E536F6E675265636F7264456E747279520A736F6E675265636F72641A3D0A0F536F6E675265636F7264456E74727912100A036B657918012001280952036B657912140A0576616C7565180220012809520576616C75653A023801228A010A0B7265616452657175657374123C0A0A736F6E675265636F726418012003280B321C2E72656164526571756573742E536F6E675265636F7264456E747279520A736F6E675265636F72641A3D0A0F536F6E675265636F7264456E74727912100A036B657918012001280952036B657912140A0576616C7565180220012809520576616C75653A023801228A010A0B616464526573706F6E7365123C0A0A736F6E675265636F726418012003280B321C2E616464526573706F6E73652E536F6E675265636F7264456E747279520A736F6E675265636F72641A3D0A0F536F6E675265636F7264456E74727912100A036B657918012001280952036B657912140A0576616C7565180220012809520576616C75653A0238012290010A0E757064617465526573706F6E7365123F0A0A736F6E675265636F726418012003280B321F2E757064617465526573706F6E73652E536F6E675265636F7264456E747279520A736F6E675265636F72641A3D0A0F536F6E675265636F7264456E74727912100A036B657918012001280952036B657912140A0576616C7565180220012809520576616C75653A023801228C010A0C72656164526573706F6E7365123D0A0A736F6E675265636F726418012003280B321D2E72656164526573706F6E73652E536F6E675265636F7264456E747279520A736F6E675265636F72641A3D0A0F536F6E675265636F7264456E74727912100A036B657918012001280952036B657912140A0576616C7565180220012809520576616C75653A023801328A010A0463616C6912260A096164645265636F7264120B2E616464526571756573741A0C2E616464526573706F6E7365122F0A0C7570646174655265636F7264120E2E757064617465526571756573741A0F2E757064617465526573706F6E736512290A0A726561645265636F7264120C2E72656164526571756573741A0D2E72656164526573706F6E7365620670726F746F33";
function getDescriptorMap() returns map<string> {
    return {
        "protoFile.proto":"0A0F70726F746F46696C652E70726F746F2288010A0A61646452657175657374123B0A0A736F6E675265636F726418012003280B321B2E616464526571756573742E536F6E675265636F7264456E747279520A736F6E675265636F72641A3D0A0F536F6E675265636F7264456E74727912100A036B657918012001280952036B657912140A0576616C7565180220012809520576616C75653A023801228E010A0D75706461746552657175657374123E0A0A736F6E675265636F726418012003280B321E2E757064617465526571756573742E536F6E675265636F7264456E747279520A736F6E675265636F72641A3D0A0F536F6E675265636F7264456E74727912100A036B657918012001280952036B657912140A0576616C7565180220012809520576616C75653A023801228A010A0B7265616452657175657374123C0A0A736F6E675265636F726418012003280B321C2E72656164526571756573742E536F6E675265636F7264456E747279520A736F6E675265636F72641A3D0A0F536F6E675265636F7264456E74727912100A036B657918012001280952036B657912140A0576616C7565180220012809520576616C75653A023801228A010A0B616464526573706F6E7365123C0A0A736F6E675265636F726418012003280B321C2E616464526573706F6E73652E536F6E675265636F7264456E747279520A736F6E675265636F72641A3D0A0F536F6E675265636F7264456E74727912100A036B657918012001280952036B657912140A0576616C7565180220012809520576616C75653A0238012290010A0E757064617465526573706F6E7365123F0A0A736F6E675265636F726418012003280B321F2E757064617465526573706F6E73652E536F6E675265636F7264456E747279520A736F6E675265636F72641A3D0A0F536F6E675265636F7264456E74727912100A036B657918012001280952036B657912140A0576616C7565180220012809520576616C75653A023801228C010A0C72656164526573706F6E7365123D0A0A736F6E675265636F726418012003280B321D2E72656164526573706F6E73652E536F6E675265636F7264456E747279520A736F6E675265636F72641A3D0A0F536F6E675265636F7264456E74727912100A036B657918012001280952036B657912140A0576616C7565180220012809520576616C75653A023801328A010A0463616C6912260A096164645265636F7264120B2E616464526571756573741A0C2E616464526573706F6E7365122F0A0C7570646174655265636F7264120E2E757064617465526571756573741A0F2E757064617465526573706F6E736512290A0A726561645265636F7264120C2E72656164526571756573741A0D2E72656164526573706F6E7365620670726F746F33"
        
    };
}