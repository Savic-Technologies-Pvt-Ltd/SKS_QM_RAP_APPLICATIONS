@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZQMT_INPROC_1'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZQM_BA_InprocessInspectionHead
  as select from    zqm_t_inproc_1                                                      as Header

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

{
  key Header.cuuid                                                             as Cuuid,
      Header.inspectionlot                                                     as Inspectionlot,
      //      a.InspectionLotCreatedOn                 as Lotcreate,
      a.InspectionLotCreatedOn                                                 as Lotcreate,
      a.InspectionLotStartDate                                                 as Startofinsp,
      a.InspectionLotEndDate                                                   as Endofinsp,
      a.Plant                                                                  as Plant,
      a.Material                                                               as Material,
      sales._ShipToParty.CustomerName                                          as Customer,
      @Semantics.quantity.unitOfMeasure: 'Baseunit'
      a.InspectionLotQuantity                                                  as Lotqty,
      @Consumption.valueHelpDefinition: [ {
        entity.name: 'I_UnitOfMeasureStdVH',
        entity.element: 'UnitOfMeasure',
        useForValidation: true
      } ]
      a.InspectionLotQuantityUnit                                              as Baseunit,
      Header.manufacturingorder                                                as Manufacturingorder,
      a.InspectionLotObjectText                                                as Inspectionlotobjecttext,
      mfg_ord.Batch                                                            as Batch,
      sales.ShipToParty                                                        as Supplier,
      a.Manufacturer                                                           as Manufacturer,
      cast('' as abap.char( 4 ))                                               as Inspectionoperation,
      Header.inspection                                                        as Inspection,
      pro_ord.SalesOrder                                                       as Salesorder,
      case when char_val.CharcInternalID = '0000000816'
          then char_val.CharcValue else '' end                                 as Drgno,
      case when char_val.CharcInternalID = '0000000823'
          then char_val.CharcValue else '' end                                 as RmSpecification,
      case when char_val.CharcInternalID = '0000000819'
          then char_val.CharcValue else '' end                                 as Grade,
      case when char_val.CharcInternalID = '0000000812'
          then char_val.CharcValue else '' end                                 as Partno,

      a._InspectionOperation[1:OperationText = 'Heat Treatment'].OperationText as Operationtext,
      Header.workcentertext                                                    as Workcentertext,
      Header.operationconfirmation                                             as Operationconfirmation,
      Header.shift                                                             as Shift,
      Header.operatorname                                                      as Operatorname,
      Header.previousopt                                                       as Previousopt,
      Header.nextopt                                                           as Nextopt,
      Header.filename                                                          as Filename,
      Header.attachments                                                       as Attachments,
      Header.mimetype                                                          as Mimetype,
      Header.dmt                                                               as Dmt,
      Header.vcd                                                               as Vcd,
      Header.dial                                                              as Dial,
      Header.dpmt                                                              as Dpmt,
      Header.pp                                                                as Pp,
      Header.gaugenogo                                                         as Gaugenogo,
      Header.nogo                                                              as Nogo,
      Header.other                                                             as Other,
      Header.qcstatus                                                          as Qcstatus,
      Header.created_on                                                        as CreatedOn,
      @Semantics.user.createdBy: true
      Header.created_by                                                        as CreatedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      Header.changed_on                                                        as ChangedOn,
      @Semantics.user.lastChangedBy: true
      Header.changed_by                                                        as ChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      Header.local_last_changed_on                                             as LocalLastChangedOn,
      @Semantics.user.localInstanceLastChangedBy: true
      Header.local_last_changed_by                                             as LocalLastChangedBy
      
}
