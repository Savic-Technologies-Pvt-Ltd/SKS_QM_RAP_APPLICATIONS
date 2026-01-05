@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Downtime Remarks'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZR_DOWNTIME_RE as select from zqm_downtime_re as a

association[1] to  ZC_REMARKS_DOWNTIME on ZC_REMARKS_DOWNTIME.KEYVALUE = a.remarksid


association to parent ZR_DOWNTIME_IT as _workcenter on $projection.Cuuid = _workcenter.Cuuid and
                                                       $projection.Workcenter = _workcenter.Workcenter                     
                                                       
association to ZR_DOWNTIME_HD as _HDR on $projection.Cuuid = _HDR.Cuuid
                                                       

{
    key a.cuuid as Cuuid,
    key a.workcenter as Workcenter,
    key a.remarks as Remarks,
    key a.grandcuuid,
    a.remarksid,
    cast( ZC_REMARKS_DOWNTIME.VALUE as  abap.char(120) ) as Remarksdesc,
    a.starttime      ,
  a.endtime        ,
  cast(
      (
        (
          cast(substring( a.endtime, 1, 2 ) as abap.int4) * 3600 +
          cast(substring( a.endtime, 3, 2 ) as abap.int4) * 60 +
          cast(substring( a.endtime, 5, 2 ) as abap.int4)
        )
        -
        (
          cast(substring( a.starttime, 1, 2 ) as abap.int4) * 3600 +
          cast(substring( a.starttime, 3, 2 ) as abap.int4) * 60 +
          cast(substring( a.starttime, 5, 2 ) as abap.int4)
        )
      ) / 60
    as abap.int4
  ) as totalmin,
//a.totalmin,
  a.totaltime,
    a.settingpart ,
a.supervisor ,
a.operator ,
   
    _workcenter,
    _HDR
}
