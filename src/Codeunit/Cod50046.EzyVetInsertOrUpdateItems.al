codeunit 50046 "EzyVet Update Items"
{
    procedure CreateItem(lEzyVetProducts: Record "EzyVet Products")
    var
        lItem: Record Item;
    begin
        lItem.Reset;
        lItem.SetRange(lItem."No.", lEzyVetProducts.id);
        if not lItem.FindFirst() then begin
            lItem.Init();
            lItem."No." := lEzyVetProducts.id;
            lItem.Insert();
        end;
        CopyFromEzyVetProducts(lEzyVetProducts, lItem);
        lItem.Modify();
        if GuiAllowed then
            Message('Item %1 created/modified for EzyVet Product', lItem."No.");
    end;

    local procedure CopyFromEzyVetProducts(lEzyVetProducts: Record "EzyVet Products"; var lItem: Record Item)
    var
        EzyVetProductGroupMap: Record "EzyVet Product Group Mapping";
        lProductGrpId: Integer;
        lCubexItems: Record "Cubex Items";
        lUnitOfMeasure: Record "Unit of Measure";
    begin
        lItem."No. 2" := lEzyVetProducts.code;
        lItem.Description := CopyStr(lEzyVetProducts.description, 1, 100);
        //Update UOM from Cubex products 
        lCubexItems.Reset();
        lCubexItems.SetRange(Code, lEzyVetProducts.id);
        if lCubexItems.FindFirst() then begin
            if lCubexItems.orderunit <> '' then begin
                lUnitOfMeasure.Reset();
                lUnitOfMeasure.SetRange(Code, lCubexItems.OrderUnit);
                lItem.Validate("Base Unit of Measure", lUnitOfMeasure.Code);
            end;
        end;

        lItem.Type := lItem.Type::Inventory;
        Evaluate(lProductGrpId, lEzyVetProducts.product_group_id);
        EzyVetProductGroupMap.Reset();
        EzyVetProductGroupMap.SetRange("EzyVet Product Group Id", lProductGrpId);
        if EzyVetProductGroupMap.FindFirst() then
            lItem.validate("Gen. Prod. Posting Group", EzyVetProductGroupMap."BC Product Group Code");



    end;

    var
        ItemTemplate: Record "Item Templ.";
}
