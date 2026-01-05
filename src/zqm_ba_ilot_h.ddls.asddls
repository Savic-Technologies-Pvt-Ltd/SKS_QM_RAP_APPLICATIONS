@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '5 Piece Inspection Lot Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #BASIC
define root view entity ZQM_BA_ILOT_H
  as select from     zqm_t_ilot_h
  composition [0..*] of ZQM_BA_ILOT_I as _Item
{
  key uniqueid          as Uniqueid,
      reportnumber      as Reportnumber,
      //        lpad( productionorder, 12, '0' ) as Productionorder,
      productionorder   as Productionorder,
      material          as Material,
      plant             as Plant,
      operatorname      as Operatorname,
      previousoperation as Previousoperation,
      operationtext     as Operationtext,
      nextoperation     as Nextoperation,
      inspectorname     as Inspectorname,
      machine           as Machine,
      operationnumber   as Operationnumber,
      shift             as Shift,
      batch             as Batch,
      washerlotnumber   as Washerlotnumber,
      dmt               as Dmt,
      vcd               as Vcd,
      dial              as Dial,
      dpmt              as Dpmt,
      pp                as Pp,
      gaugenumber       as Gaugenumber,
      nogo              as Nogo,
      other             as Other,
      snapgauge         as Snapgauge,
      pokayokecheck     as Pokayokecheck,
      loadverification  as Loadverification,
      machinecleanins   as Machinecleanins,
      qa5pcsstat        as Qa5pcsstat,
      chutecleanop      as Chutecleanop,
      chutpieces        as Chutpieces,
      inspobs           as Inspobs,
      machpcs           as Machpcs,
      rawmaterial       as Rawmaterial,
      subqa2prd         as Subqa2prd,
      subprd2qa         as Subprd2qa,
      obs5pcs1st        as Obs5pcs1st,
      obslast           as Obslast,
      obsfinal          as Obsfinal,
      rejqty            as Rejqty,
      result1           as Result1,
      result2           as Result2,
      result3           as Result3,
      result4           as Result4,
      result5           as Result5,
      result6           as Result6,
      result7           as Result7,
      result8           as Result8,
      result9           as Result9,
      result10          as Result10,
      result11          as Result11,
      qcstatus          as Qcstatus,
      createdby         as Createdby,
      createdon         as Createdon,
      changedby         as Changedby,
      changedon         as Changedon,

      _Item
}
