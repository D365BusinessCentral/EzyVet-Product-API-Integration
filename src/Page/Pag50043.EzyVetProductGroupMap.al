page 50043 EzyVetProductGroupMap
{
    ApplicationArea = All;
    Caption = 'EzyVet Product Group Mapping';
    PageType = List;
    SourceTable = "EzyVet Product Group Mapping";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("BC Product Group Code"; Rec."BC Product Group Code")
                {
                    ToolTip = 'Specifies the value of the BC Product Group Code field';
                    ApplicationArea = All;
                }
                field("EzyVet Product Group Id"; Rec."EzyVet Product Group Id")
                {
                    ToolTip = 'Specifies the value of the EzyVet Product Group Id field';
                    ApplicationArea = All;
                }
            }
        }
    }

}
