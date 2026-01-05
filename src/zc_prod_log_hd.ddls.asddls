@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Machine Plan Header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZC_PROD_LOG_HD provider contract transactional_query as projection on   ZR_PROD_LOG_HD
{
    key Zdate,
    key Ztime,
    key Zuser,
    Msg,
    Msgdesc,
    Productionorder,
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
  customername,
   cat_code           
}
