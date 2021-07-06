table 50043 "EzyVet Product Group Mapping"
{
    Caption = 'EzyVet Product Group Mapping';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "BC Product Group Code"; Code[20])
        {
            Caption = 'BC Product Group Code';
            DataClassification = CustomerContent;
            TableRelation = "Gen. Product Posting Group";
        }
        field(2; "EzyVet Product Group Id"; Integer)
        {
            Caption = 'EzyVet Product Group Id';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(PK; "BC Product Group Code", "EzyVet Product Group Id")
        {
            Clustered = true;
        }
    }

}
