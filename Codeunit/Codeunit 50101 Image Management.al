codeunit 50101 "Image Management"
{
    procedure UploadImage(var Item : Record Item);
    var
        TempBlobInput : Record TempBlob;
        TempBlobOutput : Record TempBlob;
        StreamIn : InStream;
        StreamOut : OutStream;
        FileName: Text;
    begin
        UploadIntoStream('Select an image file', '', '', FileName, StreamIn);
        TempBlobInput.Blob.CreateOutStream(StreamOut);
        CopyStream(StreamOut, StreamIn);
        Clear(StreamIn);

        ScaleImage(TempBlobInput, TempBlobOutput);
        TempBlobOutput.Blob.CreateInStream(StreamIn);
        Item.Picture.ImportStream(StreamIn, 'Main image');
    end;

    local procedure ScaleImage(InputBlob : Record TempBlob; var OutputBlob : Record TempBlob);
    var
        Input : InStream;
        Output : OutStream;

        Client: HttpClient;
        Content: HttpContent;
        Headers: HttpHeaders;
        Response: HttpResponseMessage;
        Stream: InStream;
    begin
        InputBlob.Blob.CreateInStream(Input);
        OutputBlob.Blob.CreateOutStream(Output);

        Content.GetHeaders(Headers);
        Headers.Remove('Content-Type');
        Headers.Add('Content-Type', 'application/octet-stream');
        Content.WriteFrom(Input);

        Client.Post('https://navtechdays2017.azurewebsites.net/api/ScaleAndCrop', Content, Response);
        Response.Content.ReadAs(Stream);

        CopyStream(Output, Stream);
    end;
}