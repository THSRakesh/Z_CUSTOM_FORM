@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'For fetching the xml'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZC_SALESORDER_HEADER_ADS 
as projection on ZI_SALESORDER_HEADER_ADS
{
    key SalesOrder,
//    SalesOrderItem,
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
    OverallSDProcessStatusDesc,
    _itemsAds : redirected to composition child ZC_SALESORDER_ITEMS_ADS
    
//    Product,
//    SalesOrderItemText,
//    ProductGroup,
//    Plant,
//    @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
//    OrderQuantity,
//    OrderQuantityUnit,
//    @Semantics.amount.currencyCode: 'TransactionCurrency'
//    NetAmount
//    Currency
}
