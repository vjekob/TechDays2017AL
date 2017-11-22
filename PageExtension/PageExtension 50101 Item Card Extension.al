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
                    ImageMgt: Codeunit "Image Management";
                begin
                    ImageMgt.UploadImage(Rec);
                    CurrPage.Update(true);
                end;
                
            }
        }
    }
}