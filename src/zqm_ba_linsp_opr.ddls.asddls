@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Line Inspection Operation Interface View'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZQM_BA_LINSP_OPR
  as select from zqm_t_linsp_hdr              as Header
    inner join   I_InspectionLot              as InspLot on Header.inspectionlot = InspLot.InspectionLot
    inner join   I_InspPlanOperationVersion_2 as Opr     on InspLot.BillOfOperationsGroup = Opr.InspectionPlanGroup
  association to parent ZQM_BA_LINSP_HDR as _HDR on $projection.Cuuid = _HDR.Cuuid
  composition [0..*] of ZQM_BA_LINSP_DT  as _DT
{
  key    Header.cuuid         as Cuuid,
  key    Header.inspectionlot as Inspectionlot,
  key    Opr.InspectionPlanGroup,
  key    Opr.BOOOperationInternalID,
         Opr.OperationText    as Operationtext,
         Header.createdby     as Createdby,
         Header.createdon     as Createdon,
         Header.changedby     as Changedby,
         Header.changedon     as Changedon,
         _HDR, // Make association public
         _DT
}
where
      Opr.BOOOperationInternalID <> '00000003'
  and Opr.BOOOperationInternalID <> '00000005'
