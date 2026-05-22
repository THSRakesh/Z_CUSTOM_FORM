@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'test cds for salesorder'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_SALESORDER_HEADER 
as select from I_SalesOrder

composition [0..*] of ZI_SALESORDER_ITEMS as _item

association [0..1] to I_OverallSDProcessStatusText as _statusText
    on $projection.OverallSDProcessStatus = _statusText.OverallSDProcessStatus
    and _statusText.Language = 'E'
{
    key SalesOrder,
    SalesOrderType,
    SoldToParty,
    SalesOrganization,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    TotalNetAmount,
    TransactionCurrency,
    CreationDate,
    CreationTime,
    SalesOrderDate,
    RequestedDeliveryDate,
    OverallSDProcessStatus,
    _statusText.OverallSDProcessStatusDesc,
    
    cast(
        concat(
            concat(
                '/sap/opu/odata4/sap/zui_salesorder_header_v4/srvd/sap/zui_salesorder_header/0001/ZC_SALESORDER_HEADER(SalesOrder=''',
                SalesOrder
            ),
            ''')/fileContent'
        )
    as abap.char(1024)
    ) as DownloadUrl,
    cast( 'Download PDF' as abap.char( 20 ) ) as DownloadLabel,
    
    _item
    
    // These fields must exist (even if empty in DB) to satisfy the Media Resource OData contract
//    cast( 'application/pdf' as abap.char(50) ) as MimeType,
//    cast( 'SalesOrder.pdf' as abap.char(255) )      as FileName,
//    cast( '' as abap.char(1) ) as fileContent
}
