codeunit 50048 EzyVetUpdateItemsJobQueue
{
    trigger OnRun()
    begin
        //Insert/Update Item Records
        Clear(InitItems);
        InitItems.InitItemRecords();
    end;

    var
        InitItems: Codeunit "EzyVet Init Items";


}