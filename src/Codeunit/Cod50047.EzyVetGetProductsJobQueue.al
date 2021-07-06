codeunit 50047 EzyVetGetProductsJobQueue
{
    trigger OnRun()
    begin
        //Get Product Records
        Clear(GetProducts);
        GetProducts.SetParameters(0, 0, true, true, true);
        GetProducts.Run();
    end;

    var
        GetProducts: Codeunit "EzyVet Get Products";

}