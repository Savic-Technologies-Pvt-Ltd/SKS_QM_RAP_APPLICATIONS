@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Line Inspection Date Basic View'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZQM_BA_LINSP_DT
  as select distinct from    ZQM_BA_LINSP_OPR as OPR
  // as select from    zqm_t_linsp_opr as OPR
    left outer join zqm_t_linsp_dt   as DT on  DT.cuuid               = OPR.Cuuid
                                           and DT.inspectionlot       = OPR.Inspectionlot
                                           and DT.inspectionplangroup = OPR.InspectionPlanGroup
                                           and DT.boooperationinternalid = OPR.BOOOperationInternalID    
  association to parent ZQM_BA_LINSP_OPR as _OPR on  $projection.Cuuid                  = _OPR.Cuuid
                                                 and $projection.Inspectionlot          = _OPR.Inspectionlot
                                                 and $projection.InspectionPlanGroup    = _OPR.InspectionPlanGroup
                                                 and $projection.BOOOperationInternalID = _OPR.BOOOperationInternalID
  association to ZQM_BA_LINSP_HDR        as _HDR on  $projection.Cuuid = _HDR.Cuuid

  composition [1..*] of ZQM_BA_LINSP_SPC as _SPC
{
  key          OPR.Cuuid,
  key          DT.cuuiddate,
  key          OPR.Inspectionlot,
  key          OPR.InspectionPlanGroup,
  key          OPR.BOOOperationInternalID,
               DT.operationdate     as Operationdate,
               DT.shift             as Shift,
               DT.previousoperation as PreviousOperation,
               DT.nextoperation     as NextOperation,
               DT.dmt               as Dmt,
               DT.vcd               as Vcd,
               DT.dial              as Dial,
               DT.dpmt              as Dpmt,
               DT.pp                as Pp,
               DT.gaugenumber       as Gaugenumber,
               DT.nogo              as Nogo,
               DT.other             as Other,
               DT.snapgauge         as Snapgauge,
               DT.pokayokecheck     as Pokayokecheck,
               DT.loadverification  as Loadverification,
               DT.machinecleanins   as Machinecleanins,
               DT.qa5pcsstat        as Qa5pcsstat,
               DT.chutecleanop      as Chutecleanop,
               DT.chutpieces        as Chutpieces,
               DT.inspobs           as Inspobs,
               DT.machpcs           as Machpcs,
               DT.rawmaterial       as Rawmaterial,
               DT.subqa2prd         as Subqa2prd,
               DT.subprd2qa         as Subprd2qa,
               DT.obs5pcs1st        as Obs5pcs1st,
               DT.obslast           as Obslast,
               DT.obsfinal          as Obsfinal,
               DT.rejqty            as Rejqty,
               DT.result1           as Result1,
               DT.result2           as Result2,
               DT.result3           as Result3,
               DT.result4           as Result4,
               DT.result5           as Result5,
               DT.result6           as Result6,
               DT.result7           as Result7,
               DT.result8           as Result8,
               DT.result9           as Result9,
               DT.result10          as Result10,
               DT.result11          as Result11,
               DT.qcstatus          as Qcstatus,
               _OPR, // Make association public
               _HDR,
               _SPC
}
