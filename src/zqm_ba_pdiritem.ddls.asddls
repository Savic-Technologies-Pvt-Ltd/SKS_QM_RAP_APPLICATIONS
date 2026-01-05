@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View for PDIR Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZQM_BA_PDIRItem
  as select from    zqm_t_pdir_2                 as Item

    left outer join zqm_t_pdir_1                 as Header     on Item.cuuid = Header.cuuid

    left outer join I_InspectionLot              as inspe      on Item.inspectionlot = inspe.InspectionLot

    left outer join I_InspPlanOperationVersion_2 as planoper   on  inspe.BillOfOperationsGroup = planoper.InspectionPlanGroup
                                                               and planoper.OperationText      = 'Forging'

    left outer join I_InspPlanOpCharcVersion_2   as planopchar on planoper.BOOOperationInternalID = planopchar.BOOOperationInternalID


  association to parent ZQM_BA_PDIRHeader as _Head on $projection.Cuuid = _Head.Cuuid
{
  key  Item.cuuid                                                                                     as Cuuid,
  key  Header.inspectionlot                                                                           as Inspectionlot,
  key  Item.inspectionlotitem                                                                         as InspectionLotItem,
       planoper.OperationText                                                                         as Operationtext,
       Item.shif_date                                                                                 as ShifDate,
       Item.shift_time                                                                                as ShiftTime,
       planopchar.InspectionSpecificationText                                                         as ParameterName,
       case when  ( planopchar.InspSpecUpperLimit is initial or planopchar.InspSpecUpperLimit is null )
              and ( planopchar.InspSpecLowerLimit is initial or planopchar.InspSpecLowerLimit is null )
       then concat( planopchar.InspectionSpecification,'')
       else
       case
       when planopchar.InspSpecLowerLimit is initial  or planopchar.InspSpecLowerLimit is null
       then concat( concat( cast( cast( planopchar.InspSpecUpperLimit as abap.dec( 16, 3 ) ) as abap.char( 22 ) ),'-'), ' Max')
       when planopchar.InspSpecUpperLimit is initial  or planopchar.InspSpecUpperLimit is null
       then concat( concat( cast( cast( planopchar.InspSpecLowerLimit as abap.dec( 16, 3 ) ) as abap.char( 22 ) ),'-'),  'Min')
       else concat( concat( cast( cast( planopchar.InspSpecLowerLimit as abap.dec( 16, 3 ) ) as abap.char( 22 ) ),'-'),
                            cast( cast( planopchar.InspSpecUpperLimit as abap.dec( 16, 3 ) )   as abap.char( 22 ) ) )

       end

       end                                                                                            as Specification,

       case when planopchar.InspSpecLowerLimit is initial  or planopchar.InspSpecLowerLimit is null
       then '-'
       else cast( cast( planopchar.InspSpecLowerLimit as abap.dec( 16, 3 ) ) as abap.char( 22 ) ) end as MinValue,

       case when planopchar.InspSpecUpperLimit is initial  or planopchar.InspSpecUpperLimit is null
       then '-'
       else
       cast( cast( planopchar.InspSpecUpperLimit as abap.dec( 16, 3 ) ) as abap.char( 22 ) ) end      as MaxValue,

       Item.rec_time1                                                                                 as RecTime1,
       Item.rec_time2                                                                                 as RecTime2,
       Item.rec_time3                                                                                 as RecTime3,
       Item.result_1                                                                                  as Result1,
       Item.result_2                                                                                  as Result2,
       Item.result_3                                                                                  as Result3,
       Item.created_on                                                                                as CreatedOn,
       @Semantics.user.createdBy: true
       Item.created_by                                                                                as CreatedBy,
       @Semantics.systemDateTime.lastChangedAt: true
       Item.changed_on                                                                                as ChangedOn,
       @Semantics.user.lastChangedBy: true
       Item.changed_by                                                                                as ChangedBy,
       @Semantics.systemDateTime.localInstanceLastChangedAt: true
       Item.local_last_changed_on                                                                     as LocalLastChangedOn,
       @Semantics.user.localInstanceLastChangedBy: true
       Item.local_last_changed_by                                                                     as LocalLastChangedBy,
       _Head
}
