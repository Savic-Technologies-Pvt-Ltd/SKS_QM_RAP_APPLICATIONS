@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for PDIR Item'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZQM_PR_PDIRItem
  as projection on ZQM_BA_PDIRItem
{
  key Cuuid,
  key Inspectionlot,
  key InspectionLotItem,
      Operationtext,
      ShifDate,
      ShiftTime,
      ParameterName,
      Specification,
      MinValue,
      MaxValue,
      RecTime1,
      RecTime2,
      RecTime3,
      Result1,
      Result2,
      Result3,
      CreatedOn,
      CreatedBy,
      ChangedOn,
      ChangedBy,
      LocalLastChangedOn,
      LocalLastChangedBy,
      /* Associations */
      _Head : redirected to parent ZQM_PR_PDIRHeader
}
