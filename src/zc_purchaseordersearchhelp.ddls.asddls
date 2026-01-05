@AbapCatalog.sqlViewName: 'ZCPURCHASEOR'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Purchase Order Help CDS View'
@Search.searchable: true
define view ZC_PurchaseOrderSearchHelp
  as select from I_PurchaseOrderAPI01
{
@Search.defaultSearchElement: true

  key  PurchaseOrder,
                    CompanyCode,
                    PurchasingGroup,
                    PurchasingOrganization,
                    Supplier 
}
