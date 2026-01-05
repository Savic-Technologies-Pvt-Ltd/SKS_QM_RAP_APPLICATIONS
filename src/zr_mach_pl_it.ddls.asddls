@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Machine Plan Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZR_MACH_PL_IT as select from zqm_mach_pl_it
  
  
 
 association to parent ZR_MACH_PL_HD

 as _HDR on $projection.Cuuid = _HDR.Cuuid
{
    key cuuid as Cuuid,
    key itemno as Itemno,
    machine ,
     workorder       ,
  workcenter          ,
  distributionchannel ,
  catalogcode         ,
  description         ,
  toollayout          ,
  sksdrgno            ,
  rmgrade             ,
  ext_ser             ,
  customer_name      ,
  hardness            ,
  speed,
  workcentername,
    _HDR
}
