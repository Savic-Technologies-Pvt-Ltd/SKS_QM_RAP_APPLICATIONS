@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Feasibility Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZR_FEASI_RS as select from zsd_feasi_rs
 association to parent ZR_FEASI_HD
 as _HDR on $projection.Cuuid = _HDR.Cuuid
 
{
   key cuuid as Cuuid,
    key itemno as Itemno,
    area as Area,
    high as High,
    medium as Medium,
    low as Low,
     high_value  ,
  medium_value ,
  low_value  ,
    _HDR
}
