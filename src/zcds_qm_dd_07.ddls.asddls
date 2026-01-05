@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View Help For Batch'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZCDS_QM_DD_07
  as select distinct from I_ProductionOrder
{
  key YY1_PP_BATCH01_ORD        as Batch,
      YY1_PP_Supp_Heat_Code_ORD as Supplier_Batch
}
