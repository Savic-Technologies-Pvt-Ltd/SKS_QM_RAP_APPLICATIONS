@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Line Inspection Header Interface View'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZQM_BA_LINSP_HDR
  as select from    zqm_t_linsp_hdr              as HDR
    left outer join I_InspectionLot              as INSLOT on INSLOT.InspectionLot = HDR.inspectionlot

    left outer join I_ProductionOrder            as PRDORD on PRDORD.ProductionOrder = HDR.productionorder

    left outer join I_MfgOrderOperationComponent as MFGORD on  MFGORD.ManufacturingOrder = PRDORD.ProductionOrder
                                                           and MFGORD.SalesOrder         = PRDORD.SalesOrder

    left outer join I_SalesDocumentItem          as SO     on  SO.SalesDocument     = MFGORD.SalesOrder
                                                           and SO.SalesDocumentItem = MFGORD.SalesOrderItem


    left outer join ZQM_BA_LINSP_CHARVAL         as CHAR   on CHAR.Product = HDR.material

    left outer join I_MaterialStock_2            as BATCH  on  BATCH.Material = HDR.material
                                                           and BATCH.Plant    = HDR.plant
                                                           and BATCH.Batch    = HDR.batch

  composition [1..*] of ZQM_BA_LINSP_OPR as _OPR
{
  key       HDR.cuuid                          as Cuuid,
            HDR.inspectionlot                  as Inspectionlot,
            HDR.material                       as Material,
            INSLOT.Plant                       as Plant,
            HDR.productionorder                as Productionorder,
            HDR.operationtext                  as Operationtext,
            HDR.machine                        as Machine,
            HDR.operationnumber                as Operationnumber,
            HDR.shift                          as Shift,
            HDR.washerlotnumber                as Washerlotnumber,
            HDR.operatorname                   as Operatorname,
            INSLOT.InspectionLotCreatedOn      as Lotcreated,
            INSLOT.InspectionLotCreatedOnTime  as LotCreatedTime,
            INSLOT.InspectionLotStartDate      as Startofinspection,
            INSLOT.InspectionLotEndDate        as Endofinspection,
            SO._ShipToParty.CustomerName       as Customer,
            HDR.batch                          as Batch,
            @Semantics.quantity.unitOfMeasure: 'Lotquantityunit'
            BATCH.MatlWrhsStkQtyInMatlBaseUnit as Lotquantity,
            BATCH.MaterialBaseUnit             as Lotquantityunit,
            CHAR.DRGno,
            CHAR.Grade,
            CHAR.Rmspecification,
            CHAR.Partnumber,
            HDR.dmt                            as Dmt,
            HDR.vcd                            as Vcd,
            HDR.dial                           as Dial,
            HDR.dpmt                           as Dpmt,
            HDR.pp                             as Pp,
            HDR.gaugenumber                    as Gaugenumber,
            HDR.nogo                           as Nogo,
            HDR.other                          as Other,
            HDR.snapgauge                      as Snapgauge,
            HDR.pokayokecheck                  as Pokayokecheck,
            HDR.loadverification               as Loadverification,
            HDR.machinecleanins                as Machinecleanins,
            HDR.qa5pcsstat                     as Qa5pcsstat,
            HDR.chutecleanop                   as Chutecleanop,
            HDR.chutpieces                     as Chutpieces,
            HDR.inspobs                        as Inspobs,
            HDR.machpcs                        as Machpcs,
            HDR.rawmaterial                    as Rawmaterial,
            HDR.subqa2prd                      as Subqa2prd,
            HDR.subprd2qa                      as Subprd2qa,
            HDR.obs5pcs1st                     as Obs5pcs1st,
            HDR.obslast                        as Obslast,
            HDR.obsfinal                       as Obsfinal,
            HDR.rejqty                         as Rejqty,
            HDR.result1                        as Result1,
            HDR.result2                        as Result2,
            HDR.result3                        as Result3,
            HDR.result4                        as Result4,
            HDR.result5                        as Result5,
            HDR.result6                        as Result6,
            HDR.result7                        as Result7,
            HDR.result8                        as Result8,
            HDR.result9                        as Result9,
            HDR.result10                       as Result10,
            HDR.result11                       as Result11,
            HDR.qcstatus                       as Qcstatus,
            HDR.createdby                      as Createdby,
            HDR.createdon                      as Createdon,
            HDR.changedby                      as Changedby,
            HDR.changedon                      as Changedon,
             
     HDR.filename           ,
   HDR.attachments       ,
   HDR.mimetype          ,
            _OPR // Make association public
}
