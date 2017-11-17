codeunit 50100 "Azure Functions"
{
    trigger OnRun();
    begin
        MeasurePerformance();
        //InvokeDemo();
    end;

    local procedure InvokeDemoAzureService(Url: Text) Result : Text;
    var
        Client: HttpClient;
        Response: HttpResponseMessage;
    begin
        Client.Get(Url, Response);
        Response.Content.ReadAs(Result);
    end;

    procedure InvokeDemo();
    begin
        Message(InvokeDemoAzureService('https://demod2017-01.azurewebsites.net/api/TestAzure?name=TechDays'));
    end;

    local procedure GetPerformance(Url: Text) : Duration;
    var 
        Start: DateTime;
        i: Integer;
    begin
        Start := CurrentDateTime();
        for i := 1 to 10 do
            InvokeDemoAzureService(Url);
        exit(CurrentDateTime() - Start);
    end;

    procedure MeasurePerformance();
    var
        ResultsNL: Text;
        ResultsNL2: Text;
        ResultsIE: Text;
        ResultsUS: Text;
        ResultsSG: Text;
        ResultsAU: Text;

    begin
        ResultsNL := StrSubstNo('Netherlands: %1', GetPerformance('https://testtechdaysnl.azurewebsites.net/api/HttpTriggerCSharp1?code=mpdE9BonP62A0Tx70LgSiV8s9v6scLPUKdzbVxA/umx16AdS9EhgJw=='));
        ResultsNL2 := StrSubstNo('Netherlands (same storage): %1', GetPerformance('https://testtechdaysnl.azurewebsites.net/api/HttpTriggerCSharp1?code=mpdE9BonP62A0Tx70LgSiV8s9v6scLPUKdzbVxA/umx16AdS9EhgJw=='));
        ResultsIE := StrSubstNo('Ireland: %1', GetPerformance('https://testtechdaysie.azurewebsites.net/api/HttpTriggerCSharp1?code=SMgUp66yuNyuzcpOdNs2LfaVG/K7xPjp3c7Yf/V6BgBsWYuoNhzkOw=='));
        ResultsUS := StrSubstNo('Central US: %1', GetPerformance('https://testtechdaysus.azurewebsites.net/api/HttpTriggerCSharp1?code=hreuIPCp1shCpEnYNF3pNQo5A9vcaBDCrMTbvV3tmEafC8UuCNPuew=='));
        ResultsSG := StrSubstNo('Singapore: %1', GetPerformance('https://testtechdayssg.azurewebsites.net/api/HttpTriggerCSharp1?code=2ehKvo/BjREhyWHZsR48lGVdzDNmeGeIeShAwr9/eJb0qU3zsB2hYA=='));
        ResultsAU := StrSubstNo('Australia: %1', GetPerformance('https://testtechdaysau.azurewebsites.net/api/HttpTriggerCSharp1?code=RNyieBaEwoG0MjTNeLkLQy0imoCEu9ZbEef5t8pZpEi1hgeHh9otUA=='));

        Message('Performance measurement results:\\%1\%2\%3\%4\%5\%6',
            ResultsNL,
            ResultsNL2,
            ResultsIE,
            ResultsUS,
            ResultsSG,
            ResultsAU);
    end;
}