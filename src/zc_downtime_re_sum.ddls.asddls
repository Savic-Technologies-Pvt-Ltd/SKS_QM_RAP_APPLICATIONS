@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Calculate total Non prod Hrs'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZC_DOWNTIME_RE_SUM as select from ZR_DOWNTIME_RE
{
    key Cuuid,
    key Workcenter,
   
  cast( sum( totalmin )  as abap.int4 ) as totalmin
   
}group by Cuuid , Workcenter
