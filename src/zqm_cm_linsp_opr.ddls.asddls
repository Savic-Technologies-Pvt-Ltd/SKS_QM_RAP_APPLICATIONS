@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Line Inspection Operation Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZQM_CM_LINSP_OPR
  as projection on ZQM_BA_LINSP_OPR
{
  key    Cuuid,
  key    Inspectionlot,
  key    InspectionPlanGroup,
  key    BOOOperationInternalID,
         Operationtext,
         Createdby,
         Createdon,
         Changedby,
         Changedon,
         /* Associations */
         _HDR : redirected to parent ZQM_CM_LINSP_HDR,
         _DT  : redirected to composition child ZQM_CM_LINSP_DT
}
