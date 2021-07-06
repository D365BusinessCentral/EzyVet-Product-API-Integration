page 50041 "EzyVet Products"
{

    ApplicationArea = All;
    Caption = 'EzyVet Products';
    PageType = List;
    SourceTable = "EzyVet Products";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {

                field(id; Rec.id)
                {
                    ToolTip = 'Specifies the value of the id field';
                    ApplicationArea = All;
                }
                field(active; Rec.active)
                {
                    ToolTip = 'Specifies the value of the active field';
                    ApplicationArea = All;
                }
                field(created_at; Rec.created_at)
                {
                    ToolTip = 'Specifies the value of the created_at field';
                    ApplicationArea = All;
                }
                field(modified_at; Rec.modified_at)
                {
                    ToolTip = 'Specifies the value of the modified_at field';
                    ApplicationArea = All;
                }
                field(code; Rec.code)
                {
                    ToolTip = 'Specifies the value of the code field';
                    ApplicationArea = All;
                }
                field(name; Rec.name)
                {
                    ToolTip = 'Specifies the value of the name field';
                    ApplicationArea = All;
                }
                field(product_group_id; rec.product_group_id)
                {
                    ToolTip = 'Specifies the value of the product_group_id';
                    ApplicationArea = All;
                }

                field(description; rec.description)
                {
                    ToolTip = 'Specifies the value of the description field';
                    ApplicationArea = All;
                }

                field(warning; rec.warning)
                {
                    ToolTip = 'Specifies the value of the warning field';
                    ApplicationArea = All;
                }
                field(type; rec.type)
                {
                    ToolTip = 'Specifies the value of the type field';
                    ApplicationArea = All;
                }
                field(tracking_level; rec.tracking_level)
                {
                    ToolTip = 'Specifies the value of the tracking_level field';
                    ApplicationArea = All;
                }
                field(is_sold; rec.is_sold)
                {
                    ToolTip = 'Specifies the value of the is_sold field';
                    ApplicationArea = All;
                }
                field(is_purchased; rec.is_purchased)
                {
                    ToolTip = 'Specifies the value of the is_purchased field';
                    ApplicationArea = All;
                }
                field(is_container; rec.is_container)
                {
                    ToolTip = 'Specifies the value of the is_container field';
                    ApplicationArea = All;
                }
                field(is_derived_price; rec.is_derived_price)
                {
                    ToolTip = 'Specifies the value of the is_derived_price field';
                    ApplicationArea = All;
                }
                field(lowest_dispensable_quantity; rec.lowest_dispensable_quantity)
                {
                    ToolTip = 'Specifies the value of the lowest_dispensable_quantity field';
                    ApplicationArea = All;
                }
                field(lowest_dispensable_unit; rec.lowest_dispensable_unit)
                {
                    ToolTip = 'Specifies the value of the lowest_dispensable_unit field';
                    ApplicationArea = All;
                }
                field(concentration; rec.concentration)
                {
                    ToolTip = 'Specifies the value of the concentration field';
                    ApplicationArea = All;
                }
                field(concentration_unit; rec.concentration_unit)
                {
                    ToolTip = 'Specifies the value of the concentration_unit field';
                    ApplicationArea = All;
                }
                field(concentration_volume; rec.concentration_volume)
                {
                    ToolTip = 'Specifies the value of the concentration_volume field';
                    ApplicationArea = All;
                }
                field(concentration_diluted; rec.concentration_diluted)
                {
                    ToolTip = 'Specifies the value of the concentration_diluted field';
                    ApplicationArea = All;
                }
                field(concentration_diluted_unit; rec.concentration_diluted_unit)
                {
                    ToolTip = 'Specifies the value of the concentration_diluted_unit field';
                    ApplicationArea = All;
                }
                field(concentration_diluted_volume; rec.concentration_diluted_volume)
                {
                    ToolTip = 'Specifies the value of the concentration_diluted_volume field';
                    ApplicationArea = All;
                }
                field(default_dosage_calc_method; rec.default_dosage_calc_method)
                {
                    ToolTip = 'Specifies the value of the default_dosage_calc_method field';
                    ApplicationArea = All;
                }
                field(is_constant_rate_infusion; rec.is_constant_rate_infusion)
                {
                    ToolTip = 'Specifies the value of the is_constant_rate_infusion field';
                    ApplicationArea = All;
                }
                field(default_infusion_rate_per; rec.default_infusion_rate_per)
                {
                    ToolTip = 'Specifies the value of the default_infusion_rate_per field';
                    ApplicationArea = All;
                }
                field(default_route_of_admin; rec.default_route_of_admin)
                {
                    ToolTip = 'Specifies the value of the default_route_of_administration field';
                    ApplicationArea = All;
                }
                field(sheet_group; rec.sheet_group)
                {
                    ToolTip = 'Specifies the value of the sheet_group field';
                    ApplicationArea = All;
                }
                field(sheet_group_name; rec.sheet_group_name)
                {
                    ToolTip = 'Specifies the value of the sheet_group_name field';
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(GetNewProducts)
            {
                Caption = 'Get Products';
                Image = GetLines;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    GetNewProducts: Codeunit "EzyVet Get Products";
                    GetProducts: Report EzyVetGetProducts;
                begin
                    //GetNewProducts.Run();
                    Clear(GetProducts);
                    GetProducts.Run();
                end;
            }


            action(CreateItem)
            {
                Caption = 'Create/Update Item';
                Image = Create;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction()
                var
                    UpdateItem: Codeunit "EzyVet Init Items";
                begin
                    Clear(UpdateItem);
                    if Rec.Processed = false then begin
                        UpdateItem.SetParameters(Rec.entry_no);
                        UpdateItem.InitItemRecords();
                    end else
                        Error('Item already created or updated');
                end;
            }


        }
    }


}
