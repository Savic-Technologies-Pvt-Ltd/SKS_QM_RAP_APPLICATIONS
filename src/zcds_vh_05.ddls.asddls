@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help For Production Order'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCDS_VH_05
  as select distinct from I_MfgOrderOperationVH
{
      //  key ManufacturingOrder,
  key lpad( ManufacturingOrder, 12, '0' ) as ManufacturingOrder
}
