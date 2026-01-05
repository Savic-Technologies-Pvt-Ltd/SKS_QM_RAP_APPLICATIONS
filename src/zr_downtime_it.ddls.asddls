@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Downtime Item Interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZR_DOWNTIME_IT as select from zqm_downtime_it
left outer join ZC_DOWNTIME_RE_SUM as _ZC_DOWNTIME_RE_SUM on _ZC_DOWNTIME_RE_SUM.Cuuid = zqm_downtime_it.cuuid
and _ZC_DOWNTIME_RE_SUM.Workcenter = zqm_downtime_it.workcenter


association to parent ZR_DOWNTIME_HD 
 as _HDR on $projection.Cuuid = _HDR.Cuuid
 
   composition [0..*] of ZR_DOWNTIME_RE as _remark
   
//////   association [0..*] to I_WorkCenterText as _I_WorkCenterText on $projection.Workcenter = _I_WorkCenterText.WorkCenterInternalID
//////   and 
//////   _I_WorkCenterText.WorkCenterTypeCode = 'A'
 
{
    key zqm_downtime_it.cuuid as Cuuid,
    key zqm_downtime_it.workcenter as Workcenter,
    zqm_downtime_it.workcentername as Workcentername,
    
      zqm_downtime_it.shift          ,
 zqm_downtime_it.operator       ,
  zqm_downtime_it.supervisor      ,
  zqm_downtime_it.machinespace   ,
  zqm_downtime_it.nonprd1        ,
  zqm_downtime_it.nonprd2         ,
  zqm_downtime_it.productionorder ,
  zqm_downtime_it.contractor     ,
  zqm_downtime_it.reworkqty    ,
  zqm_downtime_it.rejectqty     ,
  zqm_downtime_it.lotno       ,
  zqm_downtime_it.bom           ,
  zqm_downtime_it.prodqty       ,
   zqm_downtime_it.shiftstarttime  ,
  zqm_downtime_it.shiftendtime,
    zqm_downtime_it.totalprodmin    ,
    zqm_downtime_it.totalnonprodmin    ,
 cast( _ZC_DOWNTIME_RE_SUM.totalmin as   abap.int4 ) as  ztotalnonprodmin ,
    _HDR,
    _remark
}
