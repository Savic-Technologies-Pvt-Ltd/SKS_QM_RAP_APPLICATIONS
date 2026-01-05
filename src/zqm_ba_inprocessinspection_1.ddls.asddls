@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View for Inprocess Inspection'
//@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZQM_BA_InprocessInspection_1
  as select from    zqm_t_inpr_ins_1                                                    as c
    left outer join I_InspectionLot                                                     as a        on a.InspectionLot = c.inspectionlot
  /*  left outer join I_ProductionOrder                                                   as pro_ord  on c.manufacturingorder = pro_ord.ProductionOrder
    left outer join I_MfgOrderOperationComponent                                        as mfg_ord  on  mfg_ord.ManufacturingOrder = pro_ord.ProductionOrder
                                                                                                    and mfg_ord.SalesOrder         = pro_ord.SalesOrder
    left outer join I_SalesDocumentItem                                                 as sales    on  mfg_ord.SalesOrder     = sales.SalesDocument
                                                                                                    and mfg_ord.SalesOrderItem = sales.SalesDocumentItem
                                                                                                    
                                                                                                    */
     //left outer join I_ClfnObjectCharcValForKeyDate ( P_KeyDate : $session.system_date ) as char_val on char_val.ClfnObjectID      = a.Material
       //                                                                                             and(
         //                                                                                             char_val.CharcInternalID    = '0000000816'
           //                                                                                           or char_val.CharcInternalID = '0000000819'
             //                                                                                         or char_val.CharcInternalID = '0000000823'
               //                                                                                       or char_val.CharcInternalID = '0000000812'
                 //                                                                                   )
                 
                   left outer join ZQM_BA_LINSP_CHARVAL         as CHAR   on CHAR.Product = c.material
                                                                                                    /*

    left outer join I_MaterialStock                                                     as _batch   on  a.Material = _batch.Material
                                                                                                    and a.Plant    = _batch.Plant
                                                                                                    and a.Batch    = _batch.Batch
                                                                                                    */
                                                                                                    
                association [0..1] to I_ProductDescription as _Text on  _Text.Product = c.material
      and _Text.Language = $session.system_language
      
      association [0..1] to I_Customer as _CustText
      on  _CustText.Customer = c.customer
      and _CustText.Language = $session.system_language
  composition [0..*] of ZQM_BA_InprocessInspection_2 as _item_operation

{
  key     c.cuuid,
          c.inspectionlot,
          a.InspectionLotCreatedOn             as Lotcreate,
       
       /*   a.Material,
          a.InspectionLotObjectText,
          mfg_ord.Batch, //lot no
          a.Plant,
          a.InspectionLotOrigin                as InspLotOrig,
          c.manufacturingorder,
          a.InspectionLotText,
          a.InspectionLotType,
          @Semantics.quantity.unitOfMeasure: 'Baseunit'
          _batch.MatlWrhsStkQtyInMatlBaseUnit                         as LotQty,
          a.InspectionLotQuantityUnit          as Baseunit,
          a.Equipment,
          a.StatusProfile,
          a.InspectionLotStartDate             as StartOfInsp,
          a.InspectionLotEndDate               as EndOfInsp,
          sales._ShipToParty.CustomerName      as Customer,
          sales.ShipToParty                    as Supplier,
          a.Manufacturer,
          a.PurchasingDocument,
          a.PurchasingDocumentItem,
          a.ScheduleLine,
          pro_ord.SalesOrder,
          pro_ord.SalesOrderItem,
          a.Language,
          a.CompanyCode,*/
          c.material,
          c.inspectionlotobjecttext,
          c.batch,
          c.plant,
          c.insplotorig,
             cast( ltrim( c.manufacturingorder, '0' ) as abap.char(12) ) as manufacturingorder,
        //  c.manufacturingorder,
          c.inspectionlottext,
          c.inspectionlottype,
           @Semantics.quantity.unitOfMeasure: 'Baseunit'
          c.lotqty,
          c.baseunit,
          c.equipment,
          c.statusprofile,
          c.startofinsp,
          c.endofinsp,
            cast( ltrim( c.customer, '0' ) as abap.char(80) ) as customer,
        //  c.customer,
          c.supplier,
          c.manufacturer,
          c.purchasingdocument,
          c.purchasingdocumentitem,
          c.scheduleline,
          c.salesorderitem,
          c.language,
          c.companycode,
         c.ord as SalesOrder,
          //          cast(b.InspectionOperation as abap.char( 4 )) as InspectionOperation, //as Activity,
          cast('' as abap.char( 4 ))           as InspectionOperation, //as Activity,
          c.operationtext,
          //
          c.workcentertext, //machine
          c.operationconfirmation, //operation NO
           CHAR.DRGno,
            CHAR.Grade,
            CHAR.Rmspecification as RM_Specification,
            CHAR.Partnumber as PartNo,
           // case when char_val.CharcInternalID = '0000000816'
          //then char_val.CharcValue else '' end                                 as DRGno,
         // c.drgno as DRGno,
         // c.grade as Grade,
         // c.rm_specification as RM_Specification,
          
           // case when char_val.CharcInternalID = '0000000812'
          //then char_val.CharcValue else '' end                                 as PartNo,
      //    c.partno as  PartNo,
          /*case when char_val.CharcInternalID = '0000000816'
          then char_val.CharcValue else '' end as DRGno,
          case when char_val.CharcInternalID = '0000000819'
          then char_val.CharcValue else '' end as Grade,
          case when char_val.CharcInternalID = '0000000823'
          then char_val.CharcValue else '' end as RM_Specification,
          case when char_val.CharcInternalID = '0000000812'
          then char_val.CharcValue else '' end as PartNo,*/
          c.shift                              as Shift,
          c.washerlotno                        as WasherLotNo,
          c.operatorname                       as OperatorName,
          c.inspector                          as Inspection,
          c.checkbox,
          c.checkbox2,
          //        """

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
          c.qcstatus                           as Qcstatus,
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
          c.attachments                        as Attachments,
          c.mimetype                           as Mimetype,
          c.filename                           as Filename,
           _Text.ProductDescription as MaterialDescription,
      _CustText.CustomerName as CustomerName,
                 @Semantics.quantity.unitOfMeasure: 'Baseunit'
      
      c.lot_quan,
c.formtype,
          /* Association */
          _item_operation
}
