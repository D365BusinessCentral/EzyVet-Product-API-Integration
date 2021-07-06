pageextension 50041 GenProductPostingGrpExt extends "Gen. Product Posting Groups"
{
    actions
    {
        addafter("&Setup")
        {
            action(EzyVetProductGroup)
            {
                Caption = 'Product Group Mapping';
                PromotedIsBig = true;
                Promoted = true;
                Image = MapAccounts;
                ApplicationArea = all;
                RunObject = page EzyVetProductGroupMap;
                RunPageLink = "BC Product Group Code" = field(Code);
            }
        }
    }
}
