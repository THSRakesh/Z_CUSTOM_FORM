@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'For fetching the xml'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_SALESORDER_HEADER_ADS
as select from ZI_SALESORDER_HEADER as header

  composition [0..*] of ZI_SALESORDER_ITEMS_ADS as _itemsAds
//left outer join I_SalesOrderItem as item
//    on header.SalesOrder = item.SalesOrder

{
    // Header
    key header.SalesOrder as SalesOrder,
        
        header.SalesOrderType as SalesOrderType,
        header.SoldToParty as SoldToParty,
        header.SalesOrganization as SalesOrganization,

        @Semantics.amount.currencyCode: 'TransactionCurrency'
        header.TotalNetAmount as TotalNetAmount ,
        header.TransactionCurrency as TransactionCurrency,
        header.CreationDate as CreationDate,
        header.CreationTime as CreationTime,
        header.SalesOrderDate as SalesOrderDate,
        header.RequestedDeliveryDate as RequestedDeliveryDate,
        header.OverallSDProcessStatus as OverallSDProcessStatus,
        header.OverallSDProcessStatusDesc as OverallSDProcessStatusDesc,
        
        _itemsAds

    // Item
//        item.SalesOrderItem as SalesOrderItem,
//        item.Product as Product,
//        item.SalesOrderItemText as SalesOrderItemText,
//        item.ProductGroup as ProductGroup,
//        item.Plant as Plant,
//
//        @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
//        item.OrderQuantity as OrderQuantity,
//        item.OrderQuantityUnit as OrderQuantityUnit,
//        @Semantics.amount.currencyCode: 'TransactionCurrency'
//        item.NetAmount as NetAmount
//        item.TransactionCurrency as Currency
}
