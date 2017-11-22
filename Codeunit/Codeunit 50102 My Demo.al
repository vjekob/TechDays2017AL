codeunit 50102 "My Azure Function Demo"
{
    trigger OnRun();
    var
    begin
        Message(InvokeDemoFunction);
    end;

    local procedure InvokeDemoFunction() Result : Text;
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
    begin
        Client.Get('https://navtechdays2017.azurewebsites.net/api/HttpTriggerCSharp1?code=WphJMxOyFHSqgOH5IdD2gPdb0MreryNaqss3RcOgtOVE5YrR4s36lA==', Response);
        Response.Content.ReadAs(Result);
    end;
}