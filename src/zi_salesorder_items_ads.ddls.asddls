@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'For fetching the xml'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_SALESORDER_ITEMS_ADS 
as select from ZI_SALESORDER_ITEMS

  association to parent ZI_SALESORDER_HEADER_ADS as _headerAds
  on $projection.SalesOrder = _headerAds.SalesOrder
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
    _headerAds
}
