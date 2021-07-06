table 50041 "EzyVet Products"
{
    Caption = 'EzyVet Products';
    DataClassification = CustomerContent;

    fields
    {
        field(1; entry_no; Integer)
        {
            Caption = 'entry_no';
            DataClassification = CustomerContent;
        }
        field(2; id; Text[100])
        {
            Caption = 'id';
            DataClassification = CustomerContent;
        }
        field(3; active; Text[20])
        {
            Caption = 'active';
            DataClassification = CustomerContent;
        }
        field(4; created_at; Text[20])
        {
            Caption = 'created_at';
            DataClassification = CustomerContent;
        }
        field(5; modified_at; Text[20])
        {
            Caption = 'modified_at';
            DataClassification = CustomerContent;
        }
        field(6; code; Text[50])
        {
            Caption = 'code';
            DataClassification = CustomerContent;
        }
        field(7; "name"; Text[300])
        {
            Caption = 'name';
            DataClassification = CustomerContent;
        }
        field(9; product_group_id; Text[50])
        {
            Caption = 'product_group_id';
            DataClassification = CustomerContent;
        }
        field(10; description; Text[300])
        {
            Caption = 'description';
            DataClassification = CustomerContent;
        }
        field(11; warning; Text[300])
        {
            Caption = 'warning';
            DataClassification = CustomerContent;
        }
        field(12; type; Text[30])
        {
            Caption = 'type';
            DataClassification = CustomerContent;
        }
        field(13; tracking_level; Text[30])
        {
            Caption = 'tracking_level';
            DataClassification = CustomerContent;
        }
        field(14; is_sold; Text[20])
        {
            Caption = 'is_sold';
            DataClassification = CustomerContent;
        }
        field(15; is_purchased; Text[20])
        {
            Caption = 'is_purchased';
            DataClassification = CustomerContent;
        }
        field(16; is_container; Text[20])
        {
            Caption = 'is_container';
            DataClassification = CustomerContent;
        }
        field(17; is_derived_price; Text[20])
        {
            Caption = 'is_derived_price';
            DataClassification = CustomerContent;
        }
        field(18; lowest_dispensable_quantity; Text[20])
        {
            Caption = 'lowest_dispensable_quantity';
            DataClassification = CustomerContent;
        }
        field(19; lowest_dispensable_unit; Text[50])
        {
            Caption = 'lowest_dispensable_unit';
            DataClassification = CustomerContent;
        }
        field(20; "concentration"; Text[20])
        {
            Caption = 'concentration';
            DataClassification = CustomerContent;
        }
        field(21; concentration_unit; Text[50])
        {
            Caption = 'concentration_unit';
            DataClassification = CustomerContent;
        }
        field(22; concentration_volume; Text[50])
        {
            Caption = 'concentration_volume';
            DataClassification = CustomerContent;
        }
        field(23; concentration_diluted; Text[20])
        {
            Caption = 'concentration_diluted';
            DataClassification = CustomerContent;
        }
        field(24; concentration_diluted_unit; Text[50])
        {
            Caption = 'concentration_diluted_unit';
            DataClassification = CustomerContent;
        }
        field(25; concentration_diluted_volume; Text[20])
        {
            Caption = 'concentration_diluted_volume';
            DataClassification = CustomerContent;
        }
        field(26; default_dosage_calc_method; Text[50])
        {
            Caption = 'default_dosage_calculation_method';
            DataClassification = CustomerContent;
        }
        field(27; is_constant_rate_infusion; Text[10])
        {
            Caption = 'is_constant_rate_infusion';
            DataClassification = CustomerContent;
        }
        field(28; default_infusion_rate_per; Text[20])
        {
            Caption = 'default_infusion_rate_per';
            DataClassification = CustomerContent;
        }
        field(29; default_route_of_admin; Text[50])
        {
            Caption = 'default_route_of_administration';
            DataClassification = CustomerContent;
        }
        field(30; sheet_group; Text[20])
        {
            Caption = 'sheet_group';
            DataClassification = CustomerContent;
        }
        field(31; sheet_group_name; Text[50])
        {
            Caption = 'sheet_group_name';
            DataClassification = CustomerContent;
        }
        field(32; Processed; Boolean)
        {
            Caption = 'Processed';
            DataClassification = CustomerContent;
        }


    }
    keys
    {
        key(PK; entry_no)
        {
            Clustered = true;
        }
    }

}
