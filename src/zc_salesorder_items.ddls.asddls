@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'test projection view for salesorder'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_SALESORDER_ITEMS
as projection on ZI_SALESORDER_ITEMS
{
    @EndUserText.label: 'Sales Order'
    key SalesOrder, 
    @EndUserText.label: 'Sales Order Item'
    key SalesOrderItem,    
    @EndUserText.label: 'Product ID'
    Product,
    @EndUserText.label: 'Sales Order Item text'
    SalesOrderItemText,
    @EndUserText.label: 'Product Group'
    ProductGroup,
    @EndUserText.label: 'Plant'
    Plant,
    @EndUserText.label: 'Quantity'
    @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
    OrderQuantity,
    @EndUserText.label: 'Unit'
    OrderQuantityUnit,
    @EndUserText.label: 'Amount'
    @Semantics.amount.currencyCode: 'Currency'
    NetAmount,
    @EndUserText.label: 'Currency'
    TransactionCurrency as Currency,
    
    _header : redirected to parent ZC_SALESORDER_HEADER
    
//    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_VIRTUAL_CALC'
//    @Semantics.largeObject: { 
//        mimeType: 'MimeType', 
//        fileName: 'FileName', 
//        contentDispositionPreference: #INLINE 
//    }
//    @EndUserText.label: 'Download Pdf'
//    virtual fileContent: abap.rawstring(0),
//
//    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_VIRTUAL_CALC'
//    @Semantics.mimeType: true
//    virtual MimeType: abap.char(128),
//
//    @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_VIRTUAL_CALC'
//    virtual FileName: abap.char(128)
}
