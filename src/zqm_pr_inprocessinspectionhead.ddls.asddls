@Metadata.allowExtensions: true
//@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZQMT_INPROC_1'
}

@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZQM_PR_InprocessInspectionHead
  provider contract transactional_query
  as projection on ZQM_BA_InprocessInspectionHead
  association [1..1] to ZQM_BA_InprocessInspectionHead as _BaseEntity on $projection.Cuuid = _BaseEntity.Cuuid
{
  key Cuuid,
      Inspectionlot,
      Lotcreate,
      Startofinsp,
      Endofinsp,
      Plant,
      Material,
      Customer,
      @Semantics: {
        quantity.unitOfMeasure: 'Baseunit'
      }
      Lotqty,
      @Consumption: {
        valueHelpDefinition: [ {
          entity.element: 'UnitOfMeasure',
          entity.name: 'I_UnitOfMeasureStdVH',
          useForValidation: true
        } ]
      }
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
      Qcstatus,
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
      LocalLastChangedBy,
      _BaseEntity
//////      ,
//////
//////      _Item : redirected to composition child ZQM_PR_InprocessInspectionRecd
}
