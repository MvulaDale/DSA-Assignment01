import ballerina/grpc;
import ballerina/io;
import ballerina/lang.'int;

string port = "http://localhost:9191";

function myInterface(){
    io:println("select a number below according to your action today");
    io:println("1. add_new_fn:");
    io:println("2. add_fns:");
    io:println("3. delete_fn:");
    io:println("4. show_fn:");
    io:println("5. show_all_fns:");
    io:println("6. show_all_with_criteria:");
    io:println("7. Exit");
    string choice = io:readln("Enter Choice: ");
    
    if (choice == "1"){
        add_new_fn();
    }
    else if (choice == "2"){
        add_fns();

    }
    else if (choice == "3"){
        delete_fn();
    }
     else if (choice == "4"){
        show_fn();
    }
     else if (choice == "5"){
        show_all_fns:();
    }
     else if (choice == "6"){
        show_all_with_criteria:();
    }
    else if(choice == "7"){
        exit();
    }
    else {
        io:println("Error: Incorrect input");
        myInterface();
    }
    }

function add_new_fn(){

    io:println("  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
        
    map<json> funcRec= {
        fullname: "",
        email: "",
        address: "",
        language: "",
        keyword: ""
    };
    
    string fullName= io:readln("Enter full name: ");
    funcRec["fullname"] = fullName;

    string email=io:readln("Enter email: ");
    funcRec["email"] = email;

    string address= io:readln("Enter address: ");
    funcRec["address"] = address;

    string language=io:readln("Enter language used: ");
    funcRec["language"] = language;

    string keywords = io:readln("Enter keywords related the function functionality: ");
    funcRec["keyword"] = Keywords;
 
    addRequest addNew = {key: inputKeyword,
    };
    
    io:println("Waiting for Server Response........");
    //Sending the add requests 
    repoClient repoFuncEP = new(port);
    
    var addResponse = repoFuncEP->add_new_fn(addNew);
    if (addResponse is grpc:Error) {
        io:println("Error from Connector: " + addResponse.reason() + " - "
                                                + <string>addResponse.detail()["message"] + "\n");
    } else {

            io:println("File Succesfully added: ",addResponse);
       
    }
    io:println("The added FUNCTION is: ", add_new_fn.toJsonString());
    myInterface();
        
}

function add_fns() {

    io:println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
    
     map<json> repoRec= {
        fullname: "",
        email: "",
        address: "",
        language: "",
        keyword: ""
    };

    string devFullname = io:readln("Enter fullname: ");
    repoRec["fullname"] = devFullname;
    
    string emal= io:readln("Enter email: ");
    repoRec["email"] = emal;
    
    string addrss = io:readln("Enter address: ");
    repoRec["address"] = addrss;

    string programLg = io:readln("Enter prog language: ");
    repoRec["language"] = programLg;

    string functionKey = io:readln("Enter keywords: ");
    repoRec["keyword"] = functionKey;
    
    io:println("A function has been added as follows: ", repoRec.toString());

}

function readKeywords() {
    
    string keyInput = io:readln("Enter function Key : ");

    readRequest newRead = {
            functionKey:keyInput
    };  

    io:println("Waiting for Server Response........");

    repoClient repositoryEP = new(port);
    
    var readResponse = repositoryEP->read_Function(newRead);
    if (readResponse is grpc:Error) {
        io:println("Error from Connector: " + readResponse.reason() + " - "
                                                + <string>readResponse.detail()["message"] + "\n");
    } else {

            io:println("File Succesfully added: ",readResponse);
        
    }
    io:println("Add request details sent were: ", newRead.toString());
     
    
}

function show_fn() {
    map<json> showRecord = {
        key: ""
    };
    
    string keyInput = io:readln("Enter Function keywords: ");
    showRecord["key:"] = keyInput;
    
}
    
function show_all_fns() {
    map<json> show_all_Record = {
        key: "",
        language: ""
    };
}

function show_all_with_criteria() {
    map<json> withCriteriaRecord= {
        fullname: "",
        email: "",
        address: "",
        language: "",
        key: ""
    };    
    io:println("Searching a record by criteria or combination of criterion:.....");

    io:println("add the Keywords to the criteria?(Reply Y/N)");
    string choice = io:readln("Enter Choice: ");
    while (choice != "Y" && choice != "N") {
        io:println("Error!! Invalid input!");
        choice = io:readln("Enter Y or N: ");
    }
    if(choice == "Y"){
        string keywords = io:readln("Enter function keywords: ");
        withCriteriaRecord["key"] = keywords;   
    
    }
    else if (choice == "N"){
        io:println("The record keywords will not be included in the search criteria!");
    }
    string programLg = io:readln("Add programming Language: ");
    withCriteriaRecord["language"] = programLg;

    io:println("add the fullname to the criteria?(Reply Y/N)");
    choice = io:readln("Enter Choice: ");
    while (choice != "Y" && choice != "N") {
        io:println("Error!! Invalid input!");
        choice = io:readln("Enter Y or N: ");
    }
    if(choice == "Y"){
        newShow["fullname"] = io:readln("Enter developer fullname: ");
                
    }
    else if (choice == "N"){
        io:println("The developer fullName will not be included in the search criteria!");
    }
    
   //Prompting user for the developer email
    io:println("add the developer email to the criteria?(Reply Y/N)");
    choice = io:readln("Enter Choice: ");
    while (choice != "Y" && choice != "N") {
        io:println("Error!! Invalid input!");
        choice = io:readln("Enter Y or N: ");
    }
    if(choice == "Y"){
        newShow["email"] = io:readln("Enter developer email: ");
                
    }
    else if (choice == "N"){
        io:println("The developer email will not be included in the search criteria!");
    }
    
    //Prompting user for the developer address
    io:println("add the developer address to the criteria?(Reply Y/N)");
    choice = io:readln("Enter Choice: ");
    while (choice != "Y" && choice != "N") {
        io:println("Error!! Invalid input!");
        choice = io:readln("Enter Y or N: ");
    }
    if(choice == "Y"){
        newShow["developer address"] = io:readln("Enter developer address: ");
                
    }
    else if (choice == "N"){
        io:println("The developer address will not be included in the search criteria!");

    } 
 
}
 function read_Function(){
    io:println("How would you like to search a record? choose a nummber Option Below: ");
    io:println("1: Search by Keywords Only: ");
    io:println("2: Search by keywords and language: ");
    io:println("3: Search by Criteria: ");

    string choice = io:readln("Enter Choice: ");
    if(choice == "1"){
        readKeywords();
    }
    else if(choice == "2"){
        readprogrammingLanguage();
    }
    else if(choice == "3"){
        readCriteria();
    }
    else{
        io:println("Error!! Incorrcet input.");
        read_Function();
    }
    myInterface();
}
function exit() {
    io:println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
}
