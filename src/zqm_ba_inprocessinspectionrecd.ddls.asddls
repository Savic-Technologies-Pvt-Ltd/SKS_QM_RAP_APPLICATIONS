@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZQMT_INPROC_2'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define view entity ZQM_BA_InprocessInspectionRecd
  as select from zqm_t_inproc_1 as Header

  association        to parent ZQM_BA_InprocessInspectionHead as _Head on $projection.Cuuid = _Head.Cuuid

  association [1..*] to ZQM_BA_InprocessInspectionItm         as _Item on $projection.Cuuid = _Item.Cuuid

{

  key Header.cuuid         as Cuuid,
  key Header.inspectionlot as Inspectionlot,
      //  key Item.inspectionlotitem as Inspectionlotitem,
      _Item[1:inner].Operationtext,
      _Item[1:inner].ShifDate,
      _Item[1:inner].ShiftTime,
      _Item[1:inner].ParameterName,
      _Item[1:inner].Specification,
      _Item[1:inner].MinValue,
      _Item[1:inner].MaxValue,
      _Item[1:inner].RecTime1,
      _Item[1:inner].RecTime2,
      _Item[1:inner].RecTime3,
      _Item[1:inner].Result1,
      _Item[1:inner].Result2,
      _Item[1:inner].Result3,
      _Item[1:inner].CreatedOn,
      _Item[1:inner].CreatedBy,
      _Item[1:inner].ChangedOn,
      _Item[1:inner].ChangedBy,
      _Item[1:inner].LocalLastChangedOn,
      _Item[1:inner].LocalLastChangedBy,
      _Head,
      _Item
}
