@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Line Inspection Date Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZQM_CM_LINSP_DT
  as projection on ZQM_BA_LINSP_DT
{

  key    Cuuid,
  key    cuuiddate,
  key    Inspectionlot,
  key    InspectionPlanGroup,
  key    BOOOperationInternalID,
         Operationdate,
         Shift,
         PreviousOperation,
         NextOperation,
         Dmt,
         Vcd,
         Dial,
         Dpmt,
         Pp,
         Gaugenumber,
         Nogo,
         Other,
         Snapgauge,
         Pokayokecheck,
         Loadverification,
         Machinecleanins,
         Qa5pcsstat,
         Chutecleanop,
         Chutpieces,
         Inspobs,
         Machpcs,
         Rawmaterial,
         Subqa2prd,
         Subprd2qa,
         Obs5pcs1st,
         Obslast,
         Obsfinal,
         Rejqty,
         Result1,
         Result2,
         Result3,
         Result4,
         Result5,
         Result6,
         Result7,
         Result8,
         Result9,
         Result10,
         Result11,
         Qcstatus,
         /* Associations */
         _OPR : redirected to parent ZQM_CM_LINSP_OPR,
         _HDR : redirected to ZQM_CM_LINSP_HDR,
         _SPC : redirected to composition child ZQM_CM_LINSP_SPC

}
