page 50042 "EzyVet Products Integ. Logs"
{

    ApplicationArea = All;
    Caption = 'EzyVet Products Integration Log';
    PageType = List;
    SourceTable = EzyvetProductsIntegrationLog;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field';
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                    ApplicationArea = All;
                }
                field(LogDateTime; Rec.LogDateTime)
                {
                    ToolTip = 'Specifies the value of the Log Time field';
                    ApplicationArea = All;
                }
            }
        }
    }

}
