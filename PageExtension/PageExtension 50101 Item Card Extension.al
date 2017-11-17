pageextension 50101 "Item Card Extension" extends "Item Card" 
{
    actions 
    {
        addfirst(Item)
        {
            action(UploadImageAL)
            {
                CaptionML = ENU='Invoke Azure';
                Image = Action;

                trigger OnAction();
                var
                    Invoker: Codeunit "Image Management";
                begin
                    Invoker.UploadImage(Rec);
                    CurrPage.Update(true);
                end;
                
            }
        }
    }
}