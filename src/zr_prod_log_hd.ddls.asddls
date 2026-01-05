@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Machine Plan Header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZR_PROD_LOG_HD as select from zqm_prod_ord_log
{
    key zdate as Zdate,
    key ztime as Ztime,
    key zuser as Zuser,
    msg as Msg,
    msgdesc as Msgdesc,
    productionorder as Productionorder,
    orderinternalid,
    orderoperationinternalid,
    changedby,
    changedon,
    changedat,
    ref_productionorder,
    operationtext,
      material                 ,
  material_desc,
  salesorder,
  cat_code,
  customername            
    
    
}
