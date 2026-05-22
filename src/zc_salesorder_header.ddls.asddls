@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'test projection view for salesorder'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.supportedCapabilities: [ #OUTPUT_FORM_DATA_PROVIDER ]
define root view entity ZC_SALESORDER_HEADER 
as projection on ZI_SALESORDER_HEADER
{
    @EndUserText.label: 'Sales Order'
    key SalesOrder,
    @EndUserText.label: 'Sales Order Type'
    SalesOrderType,
    @EndUserText.label: 'Customer ID'
    SoldToParty,
    @EndUserText.label: 'Sales Organization'
    SalesOrganization,
    @EndUserText.label: 'Total Net Amount'
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    TotalNetAmount,
    @EndUserText.label: 'Currency'
    TransactionCurrency,
    @EndUserText.label: 'Creation Date'
    CreationDate,
    @EndUserText.label: 'Creation Time'
    CreationTime,
    @EndUserText.label: 'Sales Order Date'
    SalesOrderDate,
    @EndUserText.label: 'Requested Delivery Date'
    RequestedDeliveryDate,
    OverallSDProcessStatus,
    @EndUserText.label: 'Overall Status'
    OverallSDProcessStatusDesc,
    DownloadUrl,
    DownloadLabel,
    
    _item : redirected to composition child ZC_SALESORDER_ITEMS,
    
    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_SALESORDER_HEADER'
    @Semantics.largeObject: { 
        mimeType: 'MimeType', 
        fileName: 'FileName', 
        contentDispositionPreference: #INLINE 
    }
    @EndUserText.label: 'Download Pdf'
    virtual fileContent: abap.rawstring(0),

    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_SALESORDER_HEADER'
    @Semantics.mimeType: true
    virtual MimeType: abap.char(128),

    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_SALESORDER_HEADER'
    virtual FileName: abap.char(128)
}
