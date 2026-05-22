@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'test cds for salesorder'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_SALESORDER_ITEMS
  as select from I_SalesOrderItem

  association to parent ZI_SALESORDER_HEADER as _header
  on $projection.SalesOrder = _header.SalesOrder
  
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
      
      _header
}
