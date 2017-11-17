// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50100 "Order Processor RC Extension" extends "Order Processor Role Center"
{
    actions
    {
        addlast(Tasks)
        {
            action(InvokeAzure)
            {
                CaptionML=ENU='Invoke Azure';
                Image="Action";
                RunObject=Codeunit "Azure Functions";
            }
        }
    }
}