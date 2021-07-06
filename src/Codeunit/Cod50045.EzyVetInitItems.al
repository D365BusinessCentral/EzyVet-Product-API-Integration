codeunit 50045 "EzyVet Init Items"
{
    procedure InitItemRecords()
    begin
        EzyVetProducts.Reset();
        if gProductEntryNo <> 0 then
            EzyVetProducts.SetRange(entry_no, gProductEntryNo);
        EzyVetProducts.SetRange(Processed, false);
        if EzyVetProducts.FindFirst() then
            repeat
                EzyVetInsertItems.CreateItem(EzyVetProducts);
                EzyVetProducts.Processed := true;
                EzyVetProducts.Modify();
            until EzyVetProducts.Next() = 0;

    end;

    procedure SetParameters(lProductEntryNo: Integer)
    begin
        gProductEntryNo := lProductEntryNo;
    end;

    procedure ValidateItems()
    begin

    end;


    var
        EzyVetProducts: Record "EzyVet Products";
        EzyVetInsertItems: Codeunit "EzyVet Update Items";
        gProductEntryNo: Integer;

}
