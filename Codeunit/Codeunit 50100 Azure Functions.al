codeunit 50100 "Azure Functions"
{
    trigger OnRun();
    begin
        Message(
            InvokeDemoAzureService(
                'https://demod2017-01.azurewebsites.net/api/TestAzure?name=TechDays'));
    end;
    
    local procedure InvokeDemoAzureService(Url: Text) Result : Text;
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
    begin
        Client.Get(Url,Response);
        Response.Content.ReadAs(Result);
    end;
}