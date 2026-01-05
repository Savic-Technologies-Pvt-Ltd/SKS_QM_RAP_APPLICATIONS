@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZQMT_INPR_INSP'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZQM_PR_InprocessInspectionRpt
  provider contract transactional_query
  as projection on ZQM_CM_InprocessInspectionRpt
{
  key Cuuid,
  key ItemCuuid,
      Inspectionlot,
      Lotcreate,
      Startofinsp,
      Endofinsp,
      Plant,
      Material,
      Customer,
      @Semantics.quantity.unitOfMeasure: 'Baseunit'
      Lotqty,
      Baseunit,
      Manufacturingorder,
      Inspectionlotobjecttext,
      Batch,
      Supplier,
      Manufacturer,
      Inspectionoperation,
      Inspection,
      Salesorder,
      Drgno,
      RmSpecification,
      Grade,
      Partno,
      Operationtext,
      Workcentertext,
      Operationconfirmation,
      Shift,
      Operatorname,
      Previousopt,
      Nextopt,
      Filename,
      Attachments,
      Mimetype,
      Dmt,
      Vcd,
      Dial,
      Dpmt,
      Pp,
      Gaugenogo,
      Nogo,
      Other,
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
      Qcstatus,



      @Semantics: {
        systemDateTime.createdAt: true
      }
      CreatedOn,
      @Semantics: {
        user.createdBy: true
      }
      CreatedBy,
      @Semantics: {
        systemDateTime.lastChangedAt: true
      }
      ChangedOn,
      @Semantics: {
        user.lastChangedBy: true
      }
      ChangedBy,
      @Semantics: {
        systemDateTime.localInstanceLastChangedAt: true
      }
      LocalLastChangedOn,
      @Semantics: {
        user.localInstanceLastChangedBy: true
      }
      LocalLastChangedBy
}
