@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for Inprocess Inspection Lot Operation'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZQM_PR_InprocessInspection_2
  as projection on ZQM_BA_InprocessInspection_2
{
  key Cuuid,
  key Inspectionlot,
  key InspectionPlanGroup,
  key BOOOperationInternalID,
      OperationText,
      Shift,
      Shift_Date,
      Recoding_Result1,
      Recoding_Result2,
      Recoding_Result3,
      Recoding_Result4,
      Recoding_Result5,
      Recoding_Result6,
      Recoding_Result7,
      Recoding_Result8,
      Recoding_Result9,
      Recoding_Result10,
      Recoding_Result11,
      /* Associations */
      _Header : redirected to parent ZQM_PR_InprocessInspection_1,
      _item   : redirected to composition child ZQM_PR_InprocessInspection_3
}
