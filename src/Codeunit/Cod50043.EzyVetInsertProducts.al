codeunit 50043 "EzyVet Insert Products"
{
    procedure InsertProducts(lJSONText: Text; lRecordType: Option New,Modified; var lCount: Integer)
    var
        lEzyVetProducts: Record "EzyVet Products";
        lJSONObject: JsonObject;
        lJSONToken: JsonToken;
        lJSONArray: JsonArray;
        i: Integer;
        j: Integer;
        lProductEntryNo: Integer;
    begin
        j := 0;
        lCount := 0;
        lEzyVetProducts.Reset();
        if not lEzyVetProducts.findlast() then
            lProductEntryNo := 0
        else
            lProductEntryNo := lEzyVetProducts.entry_no;

        lJSONToken.ReadFrom(lJSONText);
        lJSONObject := lJSONToken.AsObject();
        lJSONToken.SelectToken('items', lJSONToken);
        lJSONArray := lJSONToken.AsArray();
        //Process JSON response
        for i := 0 to lJSONArray.Count - 1 do begin
            j += 1;
            lCount += 1;
            lJSONArray.Get(i, lJSONToken);
            lJSONToken.SelectToken('product', lJSONToken);
            lJSONObject := lJSONToken.AsObject();
            lEzyVetProducts.Init();
            lEzyVetProducts.entry_no := lProductEntryNo + j;
            lEzyVetProducts.Insert();
            lEzyVetProducts.id := GetJSONToken(lJSONObject, 'id').AsValue().AsText();
            lEzyVetProducts.active := GetJSONToken(lJSONObject, 'active').AsValue().AsText();
            lEzyVetProducts.created_at := GetJSONToken(lJSONObject, 'created_at').AsValue().AsText();
            lEzyVetProducts.modified_at := GetJSONToken(lJSONObject, 'modified_at').AsValue().AsText();
            lEzyVetProducts.code := GetJSONToken(lJSONObject, 'code').AsValue().AsText();
            lEzyVetProducts.name := GetJSONToken(lJSONObject, 'name').AsValue().AsText();
            lEzyVetProducts.description := GetJSONToken(lJSONObject, 'description').AsValue().AsText();
            if not GetJSONToken(lJSONObject, 'product_group_id').AsValue().IsNull then
                lEzyVetProducts.product_group_id := FORMAT(GetJSONToken(lJSONObject, 'product_group_id').AsValue().AsDecimal());
            lEzyVetProducts.warning := GetJSONToken(lJSONObject, 'warning').AsValue().AsText();
            lEzyVetProducts.type := GetJSONToken(lJSONObject, 'type').AsValue().AsText();
            lEzyVetProducts.tracking_level := GetJSONToken(lJSONObject, 'tracking_level').AsValue().AsText();
            lEzyVetProducts.is_sold := GetJSONToken(lJSONObject, 'is_sold').AsValue().AsText();
            lEzyVetProducts.is_purchased := GetJSONToken(lJSONObject, 'is_purchased').AsValue().AsText();
            lEzyVetProducts.is_container := GetJSONToken(lJSONObject, 'is_container').AsValue().AsText();
            lEzyVetProducts.is_derived_price := GetJSONToken(lJSONObject, 'is_derived_price').AsValue().AsText();
            if not GetJSONToken(lJSONObject, 'lowest_dispensable_quantity').AsValue().IsNull then
                lEzyVetProducts.lowest_dispensable_quantity := FORMAT(GetJSONToken(lJSONObject, 'lowest_dispensable_quantity').AsValue().AsDecimal());
            if not GetJSONToken(lJSONObject, 'lowest_dispensable_unit').AsValue().IsNull() then
                lEzyVetProducts.lowest_dispensable_unit := GetJSONToken(lJSONObject, 'lowest_dispensable_unit').AsValue().AsText();
            if not GetJSONToken(lJSONObject, 'concentration').AsValue().IsNull then
                lEzyVetProducts.concentration := FORMAT(GetJSONToken(lJSONObject, 'concentration').AsValue().AsDecimal());
            if not GetJSONToken(lJSONObject, 'concentration_unit').AsValue().IsNull then
                lEzyVetProducts.concentration_unit := GetJSONToken(lJSONObject, 'concentration_unit').AsValue().AsText();
            if not GetJSONToken(lJSONObject, 'concentration_volume').AsValue().IsNull then
                lEzyVetProducts.concentration_volume := GetJSONToken(lJSONObject, 'concentration_volume').AsValue().AsText();
            if not GetJSONToken(lJSONObject, 'concentration_diluted').AsValue().IsNull then
                lEzyVetProducts.concentration_diluted := FORMAT(GetJSONToken(lJSONObject, 'concentration_diluted').AsValue().AsDecimal());
            if not GetJSONToken(lJSONObject, 'concentration_diluted_unit').AsValue().IsNull then
                lEzyVetProducts.concentration_diluted_unit := GetJSONToken(lJSONObject, 'concentration_diluted_unit').AsValue().AsText();
            if not GetJSONToken(lJSONObject, 'concentration_diluted_volume').AsValue().IsNull then
                lEzyVetProducts.concentration_diluted_volume := GetJSONToken(lJSONObject, 'concentration_diluted_volume').AsValue().AsText();
            if not GetJSONToken(lJSONObject, 'default_dosage_calculation_method').AsValue().IsNull then
                lEzyVetProducts.default_dosage_calc_method := GetJSONToken(lJSONObject, 'default_dosage_calculation_method').AsValue().AsText();
            if not GetJSONToken(lJSONObject, 'is_constant_rate_infusion').AsValue().IsNull then
                lEzyVetProducts.is_constant_rate_infusion := GetJSONToken(lJSONObject, 'is_constant_rate_infusion').AsValue().AsText();
            if not GetJSONToken(lJSONObject, 'default_infusion_rate_per').AsValue().IsNull then
                lEzyVetProducts.default_infusion_rate_per := GetJSONToken(lJSONObject, 'default_infusion_rate_per').AsValue().AsText();
            if not GetJSONToken(lJSONObject, 'default_route_of_administration').AsValue().IsNull then
                lEzyVetProducts.default_route_of_admin := GetJSONToken(lJSONObject, 'default_route_of_administration').AsValue().AsText();
            if not GetJSONToken(lJSONObject, 'sheet_group').AsValue().IsNull then
                lEzyVetProducts.sheet_group := FORMAT(GetJSONToken(lJSONObject, 'sheet_group').AsValue().AsDecimal());
            if not GetJSONToken(lJSONObject, 'sheet_group_name').AsValue().IsNull then
                lEzyVetProducts.sheet_group_name := GetJSONToken(lJSONObject, 'sheet_group_name').AsValue().AsText();
            lEzyVetProducts.Modify();
        end;
    end;

    local procedure GetJSONToken(JsonObject: JsonObject;
    TokenKey: Text) JsonToken: JsonToken;
    var
    begin
        if not JsonObject.get(TokenKey, JsonToken) then Error('Could not find a token with key %1', TokenKey);
    end;

}
