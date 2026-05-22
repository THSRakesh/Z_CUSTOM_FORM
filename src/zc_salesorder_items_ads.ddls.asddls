@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'For fetching the xml'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZC_SALESORDER_ITEMS_ADS
 as projection on ZI_SALESORDER_ITEMS_ADS
{
    key SalesOrder,
    key SalesOrderItem,
    Product,
    SalesOrderItemText,
    ProductGroup,
    Plant,
    @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
    OrderQuantity,
    OrderQuantityUnit,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    NetAmount,
    TransactionCurrency,
    /* Associations */
    _headerAds : redirected to parent ZC_SALESORDER_HEADER_ADS
}
