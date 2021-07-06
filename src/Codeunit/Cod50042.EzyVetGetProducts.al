codeunit 50042 "EzyVet Get Products"
{
    trigger OnRun()
    begin
        //Check Setups
        gConnectionThershold := 75;
        ProductIntegrationLog.InsertLogs('Product API Setups check started', 'SUCCESS');
        ProductAPIIntegration.CheckSetup(gErrorMsgonSetups);
        if gErrorMsgonSetups = '' then
            ProductIntegrationLog.InsertLogs('Product  API Setups check finished', 'SUCCESS')
        else begin
            ProductIntegrationLog.InsertLogs(gErrorMsgonSetups, 'ERROR');
            exit;
        end;

        //Get Access Token
        ProductIntegrationLog.InsertLogs('Retrieve API Access Token is initiated', 'SUCCESS');
        ProductAPIIntegration.GetAccessToken(gAccessToken, gErrorMsgonAccessTokenRetrieval);
        if gErrorMsgonAccessTokenRetrieval = '' then
            ProductIntegrationLog.InsertLogs('Retrieve API Access Token is completed', 'SUCCESS')
        else begin
            ProductIntegrationLog.InsertLogs(gErrorMsgonAccessTokenRetrieval, 'ERROR');
            exit;
        end;

        //Assign Filters
        if gIsAuto then begin
            APIConfiguration.Get();
            if APIConfiguration.last_product_retrieval_date = 0 then
                gFromDate := 0
            else
                gFromDate := APIConfiguration.last_product_retrieval_date;

            gToDate := EpochConverter.SystemDateTimeToEpochDateTime(CurrentDateTime);

        end;

        gfilters := StrSubstNo('{">=":%1,"<=":%2}', gFromDate, gToDate);

        //Retrieve New Records
        if gGetNewRecords then begin
            Clear(gRecordsCount);
            ProductIntegrationLog.InsertLogs('Checking for new Product is initiated', 'SUCCESS');
            ProductAPIIntegration.GetProductListPages(gAccessToken, gRecordType::New, gFilters, gTotalPageCount, gErrorMsgonPagesCount);
            if gErrorMsgonPagesCount = '' then
                ProductIntegrationLog.InsertLogs(StrSubstNo('%1 pages retrieved for new Products', gTotalPageCount), 'SUCCESS')
            else begin
                ProductIntegrationLog.InsertLogs(gErrorMsgonPagesCount, 'ERROR');
                exit;
            end;

            if gTotalPageCount >= 1 then begin
                ProductIntegrationLog.InsertLogs('New Products Retrieval started', 'SUCCESS');
                GetNewProductsList(gRecordType::New, gFromDate, gToDate, gErrorMsgonProductInsert);
                if gErrorMsgonProductInsert = '' then
                    ProductIntegrationLog.InsertLogs(StrSubstNo('%1 new Products retrieved', gRecordsCount), 'SUCCESS')
                else begin
                    ProductIntegrationLog.InsertLogs(gErrorMsgonProductInsert, 'ERROR');
                    exit;
                end;
            end;
        end;

        //Retrieve Modified Records
        if gGetModifiedRecords then begin
            Clear(gRecordsCount);
            Clear(gTotalPageCount);
            Clear(gErrorMsgonPagesCount);
            if gFromDate <> 0 then begin
                ProductIntegrationLog.InsertLogs('Checking for modified Products is initiated ', 'SUCCESS');
                ProductAPIIntegration.GetProductListPages(gAccessToken, gRecordType::Modified, gFilters, gTotalPageCount, gErrorMsgonPagesCount);
                if gErrorMsgonPagesCount = '' then
                    ProductIntegrationLog.InsertLogs(StrSubstNo('%1 pages retrieved for modified Products', gTotalPageCount), 'SUCCESS')
                else begin
                    ProductIntegrationLog.InsertLogs(gErrorMsgonPagesCount, 'ERROR');
                    exit;
                end;

                if gTotalPageCount >= 1 then begin
                    ProductIntegrationLog.InsertLogs(StrSubstNo('Modified Products Retrieval started'), 'SUCCESS');
                    GetNewProductsList(gRecordType::Modified, gFromDate, gToDate, gErrorMsgonProductInsert);
                    if gErrorMsgonProductInsert = '' then
                        ProductIntegrationLog.InsertLogs(StrSubstNo('%1 modified Products retrieved', gRecordsCount), 'SUCCESS')
                    else begin
                        ProductIntegrationLog.InsertLogs(gErrorMsgonProductInsert, 'ERROR');
                        exit;
                    end;
                end;
            end;
        end;

        if gIsAuto then begin
            APIConfiguration.last_product_retrieval_date := gToDate;
            APIConfiguration.Modify();
        end;

    end;

    procedure GetNewProductsList(lRecordType: Option New,Modified; lFromDate: Integer; lToDate: integer; var lErrorMsgonProductInsert: Text)
    var
        lhttpClient: HttpClient;
        lhttpContent: HttpContent;
        lhttpHeaders: HttpHeaders;
        lhttpResponseMessage: HttpResponseMessage;
        lresponseText: Text;
        lFilters: Text;
        i: Integer;
        j: Integer;
        lRecordsCount: Integer;

    begin
        APIConfiguration.Get();
        i := 0;
        gPageCount := 0;
        gStopLoop := false;
        if gTotalPageCount > gConnectionThershold then
            gTimesofCalls := Round(gTotalPageCount / gConnectionThershold, 1, '>')
        else
            gTimesofCalls := 1;
        repeat
            j += 1;
            gPageCount += gConnectionThershold;
            repeat
                i += 1;
                if lRecordType = lRecordType::New then
                    lFilters := 'limit=200&' + StrSubstNo('page=%1&', i) + 'created_at=' + gfilters;
                if lRecordType = lRecordType::Modified then
                    lFilters := 'limit=200&' + StrSubstNo('page=%1&', i) + 'modified_at=' + gfilters;

                Clear(lhttpContent);
                Clear(lhttpClient);
                Clear(lhttpResponseMessage);
                Clear(lresponseText);
                lhttpClient.DefaultRequestHeaders.Add('Authorization', 'Bearer ' + FORMAT(gAccessToken));
                if lhttpClient.Get(APIConfiguration.product_endpoint_url + lFilters, lhttpResponseMessage) then begin
                    lhttpResponseMessage.Content.ReadAs(lresponseText);
                    InsertProducts.InsertProducts(lresponseText, lRecordType, lRecordsCount);
                end else
                    Error(FORMAT(lhttpResponseMessage.Content));
                gStopLoop := (i = gPageCount) or (i = gtotalPageCount);
                gRecordsCount += lRecordsCount;
            until gStopLoop = true;

            if not (j = gTimesofCalls) then
                Sleep(60000);
        until j = gTimesofCalls;
    end;

    procedure SetParameters(lFromDate: Integer; lToDate: Integer; lIsAuto: Boolean; lGetNewRecords: Boolean; lGetModifiedRecords: Boolean)
    begin
        gFromDate := lFromDate;
        gToDate := lToDate;
        gIsAuto := lIsAuto;
        gGetNewRecords := lGetNewRecords;
        gGetModifiedRecords := lGetModifiedRecords;

    end;

    var
        APIConfiguration: Record "EzyVet API Configuration";
        ProductIntegrationLog: Codeunit EzyVetProductIntegrationLogs;
        ProductAPIIntegration: Codeunit "EzyVet Product API Integration";
        InsertProducts: Codeunit "EzyVet Insert Products";
        EpochConverter: Codeunit "EzyVet Epoch Convertor";
        gRecordType: Option New,Modified;
        gTotalPageCount: Integer;
        gPageCount: Integer;
        gStopLoop: Boolean;
        gConnectionThershold: Integer;
        gTimesofCalls: Integer;
        gAccessToken: Text;
        gErrorMsgonAccessTokenRetrieval: text;
        gErrorMsgonPagesCount: text;
        gErrorMsgonSetups: Text;
        gFilters: Text;
        gErrorMsgonProductInsert: Text;
        gRecordsCount: Integer;
        gFromDate: Integer;
        gToDate: Integer;
        gIsAuto: Boolean;
        gGetNewRecords: Boolean;
        gGetModifiedRecords: Boolean;


}

