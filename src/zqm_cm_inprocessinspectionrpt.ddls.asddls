@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZQMT_INPR_INSP'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZQM_CM_InprocessInspectionRpt
  as select from    zqm_t_inpr_insp                                                     as Header

    left outer join I_InspectionLot                                                     as a          on a.InspectionLot = Header.inspectionlot
    left outer join I_ProductionOrder                                                   as pro_ord    on Header.manufacturingorder = pro_ord.ProductionOrder
    left outer join I_MfgOrderOperationComponent                                        as mfg_ord    on  mfg_ord.ManufacturingOrder = pro_ord.ProductionOrder
                                                                                                      and mfg_ord.SalesOrder         = pro_ord.SalesOrder
    left outer join I_SalesDocumentItem                                                 as sales      on  mfg_ord.SalesOrder     = sales.SalesDocument
                                                                                                      and mfg_ord.SalesOrderItem = sales.SalesDocumentItem
    left outer join I_ClfnObjectCharcValForKeyDate ( P_KeyDate : $session.system_date ) as char_val   on char_val.ClfnObjectID      = a.Material
                                                                                                      and(
                                                                                                        char_val.CharcInternalID    = '0000000816'
                                                                                                        or char_val.CharcInternalID = '0000000819'
                                                                                                        or char_val.CharcInternalID = '0000000823'
                                                                                                        or char_val.CharcInternalID = '0000000812'
                                                                                                      )

    left outer join I_InspPlanOperationVersion_2                                        as planoper   on  a.BillOfOperationsGroup = planoper.InspectionPlanGroup
                                                                                                      and planoper.OperationText  = 'Heat Treatment'

    left outer join I_InspPlanOpCharcVersion_2                                          as planopchar on planoper.BOOOperationInternalID = planopchar.BOOOperationInternalID


  //  association [1..*]    to I_InspectionLot                as _Inspection on  _Inspection.InspectionLot = Header.inspectionlot
  //  association [1..*]    to I_ProductionOrder              as _pro_ord    on  _pro_ord.ProductionOrder = $projection.Manufacturingorder
  //  association [1..*] to I_MfgOrderOperationComponent   as _mfg_ord    on  _mfg_ord.ManufacturingOrder = $projection.Manufacturingorder
  //                                                                      and _mfg_ord.SalesOrder         = $projection.Salesorder
  //  association [1..*] to I_ClfnObjectCharcValForKeyDate as _char_val   on  _char_val.ClfnObjectID      = $projection.Material
  //                                                                      and (
  //                                                                         _char_val.CharcInternalID    = '0000000816'
  //                                                                         or _char_val.CharcInternalID = '0000000819'
  //                                                                         or _char_val.CharcInternalID = '0000000823'
  //                                                                         or _char_val.CharcInternalID = '0000000812'
  //                                                                       )
  //
  //  association [1]    to zqm_t_inpr_insp                as _Qty        on  _Qty.cuuid      = $projection.Cuuid
  //                                                                      and _Qty.item_cuuid = $projection.ItemCuuid
  //
  //      left outer join I_InspPlanOperationVersion_2                                        as planoper   on  a.BillOfOperationsGroup = planoper.InspectionPlanGroup
  //                                                                                                        and planoper.OperationText  = 'Heat Treatment'
  //
  //      left outer join I_InspPlanOpCharcVersion_2                                          as planopchar on planoper.BOOOperationInternalID = planopchar.BOOOperationInternalID


{
  key Header.cuuid                                                                                                 as Cuuid,
  key Header.item_cuuid                                                                                            as ItemCuuid,
      Header.inspectionlot                                                                                         as Inspectionlot,
      Header.lotcreate                                                                                             as Lotcreate,
      Header.startofinsp                                                                                           as Startofinsp,
      Header.endofinsp                                                                                             as Endofinsp,
      a.Plant                                                                                                      as Plant,
      a.Material                                                                                                   as Material,
      a._Customer.CustomerName                                                                                     as Customer,
      @Semantics.quantity.unitOfMeasure: 'Baseunit'
      Header.lotqty                                                                                                as Lotqty,
      @Consumption.valueHelpDefinition: [ {
        entity.name: 'I_UnitOfMeasureStdVH',
        entity.element: 'UnitOfMeasure',
        useForValidation: true
      } ]
      mfg_ord.BaseUnit                                                                                             as Baseunit,
      mfg_ord.ManufacturingOrder                                                                                   as Manufacturingorder,
      a.InspectionLotObjectText                                                                                    as Inspectionlotobjecttext,
      Header.batch                                                                                                 as Batch,
      a.Supplier                                                                                                   as Supplier,
      a.Manufacturer                                                                                               as Manufacturer,
      cast( a._InspectionOperation[1:OperationText      = 'Heat Treatment'].InspectionOperation  as abap.char(4) ) as Inspectionoperation,
      Header.inspection                                                                                            as Inspection,
      a.SalesOrder                                                                                                 as Salesorder,
      Header.drgno                                                                                                 as Drgno,
      Header.rm_specification                                                                                      as RmSpecification,
      Header.grade                                                                                                 as Grade,
      Header.partno                                                                                                as Partno,
      a._InspectionOperation[1:OperationText      = 'Heat Treatment'].OperationText                                as Operationtext,
      a._InspectionOperation[1:OperationText      = 'Heat Treatment']._WorkCenter._Text[1:inner].WorkCenterText    as Workcentertext,
      a._InspectionOperation[1:OperationText      = 'Heat Treatment'].OperationConfirmation                        as Operationconfirmation,
      Header.shift                                                                                                 as Shift,
      Header.operatorname                                                                                          as Operatorname,
      Header.previousopt                                                                                           as Previousopt,
      Header.nextopt                                                                                               as Nextopt,
      Header.filename                                                                                              as Filename,
      Header.attachments                                                                                           as Attachments,
      Header.mimetype                                                                                              as Mimetype,
      Header.dmt                                                                                                   as Dmt,
      Header.vcd                                                                                                   as Vcd,
      Header.dial                                                                                                  as Dial,
      Header.dpmt                                                                                                  as Dpmt,
      Header.pp                                                                                                    as Pp,
      Header.gaugenogo                                                                                             as Gaugenogo,
      Header.nogo                                                                                                  as Nogo,
      Header.other                                                                                                 as Other,
      Header.shif_date                                                                                             as ShifDate,
      Header.shift_time                                                                                            as ShiftTime,
      Header.parameter_name                                                                                        as ParameterName,
      case when  ( a._InspectionOperation[1:OperationText      = 'Heat Treatment']._InspectionCharacteristic[1:inner].InspSpecUpperLimit is initial or
                   a._InspectionOperation[1:OperationText      = 'Heat Treatment']._InspectionCharacteristic[1:inner].InspSpecUpperLimit is null )
             and ( a._InspectionOperation[1:OperationText      = 'Heat Treatment']._InspectionCharacteristic[1:inner].InspSpecLowerLimit is initial or
                   a._InspectionOperation[1:OperationText      = 'Heat Treatment']._InspectionCharacteristic[1:inner].InspSpecLowerLimit is null )
       then concat(
                   a._InspectionOperation[1:OperationText      = 'Heat Treatment']._InspectionCharacteristic[1:inner].InspectionSpecification,'')
       else
       case
       when        a._InspectionOperation[1:OperationText      = 'Heat Treatment']._InspectionCharacteristic[1:inner].InspSpecLowerLimit is initial  or
                   a._InspectionOperation[1:OperationText      = 'Heat Treatment']._InspectionCharacteristic[1:inner].InspSpecLowerLimit is null
       then concat( concat( cast( cast(
                   a._InspectionOperation[1:OperationText      = 'Heat Treatment']._InspectionCharacteristic[1:inner].InspSpecUpperLimit as abap.dec( 16, 3 ) ) as abap.char( 22 ) ),'-'), ' Max')
       when        a._InspectionOperation[1:OperationText      = 'Heat Treatment']._InspectionCharacteristic[1:inner].InspSpecUpperLimit is initial  or
                   a._InspectionOperation[1:OperationText      = 'Heat Treatment']._InspectionCharacteristic[1:inner].InspSpecUpperLimit is null
       then concat( concat( cast( cast(
                   a._InspectionOperation[1:OperationText      = 'Heat Treatment']._InspectionCharacteristic[1:inner].InspSpecLowerLimit as abap.dec( 16, 3 ) ) as abap.char( 22 ) ),'-'),  'Min')
       else concat( concat( cast( cast(
                   a._InspectionOperation[1:OperationText      = 'Heat Treatment']._InspectionCharacteristic[1:inner].InspSpecLowerLimit as abap.dec( 16, 3 ) ) as abap.char( 22 ) ),'-'),
                            cast( cast(
                   a._InspectionOperation[1:OperationText      = 'Heat Treatment']._InspectionCharacteristic[1:inner].InspSpecUpperLimit as abap.dec( 16, 3 ) )   as abap.char( 22 ) ) )

       end

       end                                                                                                         as Specification,

      case when
      a._InspectionOperation[1:OperationText      = 'Heat Treatment']._InspectionCharacteristic[1:inner].InspSpecLowerLimit is initial
      or a._InspectionOperation[1:OperationText   = 'Heat Treatment']._InspectionCharacteristic[1:inner].InspSpecLowerLimit is null
      then '-'
      else cast( cast(
      a._InspectionOperation[1:OperationText      = 'Heat Treatment']._InspectionCharacteristic[1:inner].InspSpecLowerLimit as abap.dec( 16, 3 ) ) as abap.char( 22 ) )
      end                                                                                                          as MinValue,

      case when
      a._InspectionOperation[1:OperationText      = 'Heat Treatment']._InspectionCharacteristic[1:inner].InspSpecUpperLimit is initial
      or a._InspectionOperation[1:OperationText      = 'Heat Treatment']._InspectionCharacteristic[1:inner].InspSpecUpperLimit is null
      then '-'
      else
      cast( cast(
      a._InspectionOperation[1:OperationText      = 'Heat Treatment']._InspectionCharacteristic[1:inner].InspSpecUpperLimit as abap.dec( 16, 3 ) ) as abap.char( 22 ) )
       end                                                                                                         as MaxValue,

      Header.rec_time1                                                                                             as RecTime1,
      Header.rec_time2                                                                                             as RecTime2,
      Header.rec_time3                                                                                             as RecTime3,
      Header.result_1                                                                                              as Result1,
      Header.result_2                                                                                              as Result2,
      Header.result_3                                                                                              as Result3,
      Header.qcstatus                                                                                              as Qcstatus,
      @Semantics.systemDateTime.createdAt: true
      Header.created_on                                                                                            as CreatedOn,
      @Semantics.user.createdBy: true
      Header.created_by                                                                                            as CreatedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      Header.changed_on                                                                                            as ChangedOn,
      @Semantics.user.lastChangedBy: true
      Header.changed_by                                                                                            as ChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      Header.local_last_changed_on                                                                                 as LocalLastChangedOn,
      @Semantics.user.localInstanceLastChangedBy: true
      Header.local_last_changed_by                                                                                 as LocalLastChangedBy
}
