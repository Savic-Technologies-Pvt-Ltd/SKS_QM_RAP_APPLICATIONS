@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZQMT_INPROC_2'
}

define view entity ZQM_PR_InprocessInspectionRecd
  as projection on ZQM_BA_InprocessInspectionRecd
//  association [1..1] to ZQM_BA_InprocessInspectionRecd as _BaseEntity on  $projection.Cuuid         = _BaseEntity.Cuuid
//                                                                      and $projection.Inspectionlot = _BaseEntity.Inspectionlot
{

  key ZQM_BA_InprocessInspectionRecd.Cuuid,
  key ZQM_BA_InprocessInspectionRecd.Inspectionlot,
      ZQM_BA_InprocessInspectionRecd.Operationtext,
      ZQM_BA_InprocessInspectionRecd.ShifDate,
      ZQM_BA_InprocessInspectionRecd.ShiftTime,
      ZQM_BA_InprocessInspectionRecd.ParameterName,
      ZQM_BA_InprocessInspectionRecd.Specification,
      ZQM_BA_InprocessInspectionRecd.MinValue,
      ZQM_BA_InprocessInspectionRecd.MaxValue,
      ZQM_BA_InprocessInspectionRecd.RecTime1,
      ZQM_BA_InprocessInspectionRecd.RecTime2,
      ZQM_BA_InprocessInspectionRecd.RecTime3,
      ZQM_BA_InprocessInspectionRecd.Result1,
      ZQM_BA_InprocessInspectionRecd.Result2,
      ZQM_BA_InprocessInspectionRecd.Result3,
      ZQM_BA_InprocessInspectionRecd.CreatedOn,
      @Semantics: { user.createdBy: true }
      ZQM_BA_InprocessInspectionRecd.CreatedBy,
      ZQM_BA_InprocessInspectionRecd.ChangedOn,
      @Semantics: { user.lastChangedBy: true }
      ZQM_BA_InprocessInspectionRecd.ChangedBy,
      @Semantics: { systemDateTime.localInstanceLastChangedAt: true }
      ZQM_BA_InprocessInspectionRecd.LocalLastChangedOn,
      @Semantics: { user.localInstanceLastChangedBy: true }
      ZQM_BA_InprocessInspectionRecd.LocalLastChangedBy,
      /* Associations */
      ZQM_BA_InprocessInspectionRecd._Head : redirected to parent ZQM_PR_InprocessInspectionHead,
      ZQM_BA_InprocessInspectionRecd._Item

}
