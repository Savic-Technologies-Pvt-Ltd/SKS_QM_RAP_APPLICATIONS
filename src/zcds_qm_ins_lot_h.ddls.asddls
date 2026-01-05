@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View For Inspection Lot'
@Metadata.ignorePropagatedAnnotations: true

define root view entity ZCDS_QM_INS_LOT_H
  as select from    zta_qm_ins_lot                                                      as c
    left outer join I_InspectionLot                                                     as a        on a.InspectionLot = c.inspectionlot
    left outer join I_ProductionOrder                                                   as pro_ord  on c.manufacturingorder = pro_ord.ProductionOrder
    left outer join I_MfgOrderOperationComponent                                        as mfg_ord  on  mfg_ord.ManufacturingOrder = pro_ord.ProductionOrder
                                                                                                    and mfg_ord.SalesOrder         = pro_ord.SalesOrder
    left outer join I_SalesDocumentItem                                                 as sales    on  mfg_ord.SalesOrder     = sales.SalesDocument
                                                                                                    and mfg_ord.SalesOrderItem = sales.SalesDocumentItem
    left outer join I_ClfnObjectCharcValForKeyDate ( P_KeyDate : $session.system_date ) as char_val on char_val.ClfnObjectID      = a.Material
                                                                                                    and(
                                                                                                      char_val.CharcInternalID    = '0000000816'
                                                                                                      or char_val.CharcInternalID = '0000000819'
                                                                                                      or char_val.CharcInternalID = '0000000823'
                                                                                                      or char_val.CharcInternalID = '0000000812'
                                                                                                    )
  composition [0..*] of ZCDS_QM_INS_LOT_I as _Item
{
  key   c.cuuid,
        c.inspectionlot,
        a.InspectionLotCreatedOn             as Lotcreate,
        a.InspectionLotCreatedOnTime,
        a.Material,
        c.productlongtext                    as ProductLongText,
        a.InspectionLotObjectText,
        c.batch, //lot no
        a.Plant,
        a.InspectionLotOrigin                as InspLotOrig,
        c.manufacturingorder,
        a.InspectionLotText,
        a.InspectionLotType,
        @Semantics.quantity.unitOfMeasure: 'Baseunit'
        a.InspectionLotQuantity              as LotQty,
        a.InspectionLotQuantityUnit          as Baseunit,
        a.Equipment,
        a.StatusProfile,
        a.InspectionLotStartDate             as StartOfInsp,
        a.InspectionLotEndDate               as EndOfInsp,
        sales._ShipToParty.CustomerName      as Customer,
        //        a.Customer,
        c.supplier,
        //        sales.ShipToParty                             as Supplier,
        a.Manufacturer,
        a.PurchasingDocument,
        a.PurchasingDocumentItem,
        a.ScheduleLine,
        pro_ord.SalesOrder                   as Ord,
        pro_ord.SalesOrderItem,
        a.Language,
        a.CompanyCode,
        cast('' as abap.char( 4 ))           as InspectionOperation, //as Activity,
        c.operationtext,
        c.workcentertext, //machine
        c.operationconfirmation, //operation NO
        case when char_val.CharcInternalID = '0000000816'
        then char_val.CharcValue else '' end as DRGno,
        case when char_val.CharcInternalID = '0000000819'
        then char_val.CharcValue else '' end as Grade,
        case when char_val.CharcInternalID = '0000000823'
        then char_val.CharcValue else '' end as RM_Specification,
        case when char_val.CharcInternalID = '0000000812'
        then char_val.CharcValue else '' end as PartNo,
        c.shift                              as Shift,
        c.washerlotno                        as WasherLotNo,
        c.operatorname                       as OperatorName,
        c.inspector                          as Inspection,


        ''                                   as Monito, //Check box
        ''                                   as A, //Check box
        ''                                   as Systemstatus,
        c.checkbox,
        c.checkbox2,
        c.approved,
        c.snapgaugeavl,
        c.notapproved,
        c.pokayokechecked,
        c.obseropera,
        c.cleaned,
        c.loadverf,
        c.nopiecchute,
        c.obseinspector,
        c.nopiecesaroundmachine,
        c.dmt,
        c.vcd,
        c.dial,
        c.dpmt,
        c.pp,
        c.gaugenogo,
        c.nogo,
        c.other,
        c.ar1,
        c.ar2,
        c.ar3,
        c.ar4,
        c.ar5,
        c.ar6,
        c.ar7,
        c.ar8,
        c.ar9,
        c.ar10,
        c.ar11,
        c.prodtime,
        c.qatime,
        c.previousopt,
        c.nextopt,
        c.rawmaterial,
        //For Form
        c.attachments                        as Attachments,
        c.mimetype                           as Mimetype,
        c.filename                           as Filename,
        //For Upload
        c.attachments_ul                     as Attachments_ul,
        c.mimetype_ul                        as Mimetype_ul,
        c.filename_ul                        as Filename_ul,
        c.firstfivepieceobservation          as FirstFivePieceObse,
        c.lastpieceobservation               as LastPieceObservation,
        c.finalobservation                   as FinalObservation,
        c.qc_status                          as QC_Status,
        case
         when  c.qc_status = 'Accepted' then 3
         when  c.qc_status = 'Accept under Deviation (AUD)' then 2
         when  c.qc_status = 'Rejected' then 1
         else 0
         end                                 as qc_criticality,
        c.rejectionquantity                  as Rejection_Quantity,
        _Item
}
where
  a.InspectionLotType = '89'
