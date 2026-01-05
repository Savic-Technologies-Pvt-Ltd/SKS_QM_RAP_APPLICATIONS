@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View for PDIR Header'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZQM_BA_PDIRHeader
  as select from    zqm_t_pdir_1                                                        as Header
  //left outer join I_ClfnObjectCharcValForKeyDate ( P_KeyDate : $session.system_date ) as char_val on char_val.ClfnObjectID      = Header.material
    //                                                                                                and(
      //                                                                                               char_val.CharcInternalID    = '0000000816'
        //                                                                                              or char_val.CharcInternalID = '0000000819'
          //                                                                                            or char_val.CharcInternalID = '0000000823'
            //                                                                                          or char_val.CharcInternalID = '0000000812'
              //                                                                                      )

  
  association [0..1] to I_ProductDescription as _Text on  _Text.Product = Header.material
      and _Text.Language = $session.system_language
      
      association [0..1] to I_Customer as _CustText
      on  _CustText.Customer = Header.customer
      and _CustText.Language = $session.system_language

  //  left outer join I_InspectionLot                                                     as a        on a.InspectionLot = Header.inspectionlot
  //  left outer join I_ProductionOrder                                                   as pro_ord  on Header.manufacturingorder = pro_ord.ProductionOrder
  //  left outer join I_MfgOrderOperationComponent                                        as mfg_ord  on  mfg_ord.ManufacturingOrder = pro_ord.ProductionOrder
  //                                                                                                  and mfg_ord.SalesOrder         = pro_ord.SalesOrder
  //  left outer join I_SalesDocumentItem                                                 as sales    on  mfg_ord.SalesOrder     = sales.SalesDocument
   //                                                                                                 and mfg_ord.SalesOrderItem = sales.SalesDocumentItem
   
  composition [1..*] of ZQM_BA_PDIRItem as _Item
  
   composition [1..*] of ZQM_PDIR_OPERTION_LIST as _OperationItem
  
   
{
  key Header.cuuid                             as Cuuid,
      Header.inspectionlot                     as Inspectionlot,
      
      // from custom table
 
      Header.lotcreate,
      Header.startofinsp,
       Header.endofinsp,
         Header.plant,
         
          Header.material,
             // concat( concat( _Text.ProductDescription, ' (' ), concat( Header.material, ')' ) ) as  
          
                             cast( ltrim( Header.customer, '0' ) as abap.char(80) ) as customer,
          
    //       Header.customer,
            @Semantics.quantity.unitOfMeasure: 'Baseunit'
             Header.lotqty,
             Header.baseunit,
                   cast( ltrim( Header.manufacturingorder, '0' ) as abap.char(12) ) as manufacturingorder,
             
            //  Header.manufacturingorder,
               Header.inspectionlotobjecttext,
                Header.batch,
                 Header.supplier,
                 
                  Header.manufacturer,
                   Header.inspectionoperation,
                    Header.inspection,
                     Header.salesorder,
                     
//                     case when char_val.CharcInternalID = '0000000816'
//          then char_val.CharcValue else '' end                                 as drgno,
                      Header.drgno,
                        Header.rm_specification as RmSpecification,
                          Header.grade,
//                             case when char_val.CharcInternalID = '0000000812'
//          then char_val.CharcValue else '' end                                 as partno,
                            Header.partno,
                            Header.operationtext,
                 
      //      a.InspectionLotCreatedOn                 as Lotcreate,
   /*   a.InspectionLotCreatedOn                 as Lotcreate,
      a.InspectionLotStartDate                 as Startofinsp,
      a.InspectionLotEndDate                   as Endofinsp,
      a.Plant                                  as Plant,
      a.Material                               as Material,
      sales._ShipToParty.CustomerName          as Customer,
      @Semantics.quantity.unitOfMeasure: 'Baseunit'
      a.InspectionLotQuantity                  as Lotqty,
      @Consumption.valueHelpDefinition: [ {
        entity.name: 'I_UnitOfMeasureStdVH',
        entity.element: 'UnitOfMeasure',
        useForValidation: true
      } ]
      a.InspectionLotQuantityUnit              as Baseunit,
      Header.manufacturingorder                as Manufacturingorder,
      a.InspectionLotObjectText                as Inspectionlotobjecttext,
      mfg_ord.Batch                            as Batch,
      sales.ShipToParty                        as Supplier,
      a.Manufacturer                           as Manufacturer,
      cast('' as abap.char( 4 ))               as Inspectionoperation,
      Header.inspection                        as Inspection,
      pro_ord.SalesOrder                       as Salesorder,
      case when char_val.CharcInternalID = '0000000816'
          then char_val.CharcValue else '' end as Drgno,
      case when char_val.CharcInternalID = '0000000823'
          then char_val.CharcValue else '' end as RmSpecification,
      case when char_val.CharcInternalID = '0000000819'
          then char_val.CharcValue else '' end as Grade,
      case when char_val.CharcInternalID = '0000000812'
          then char_val.CharcValue else '' end as Partno,

      a._InspectionOperation.OperationText     as Operationtext,*/
      Header.workcentertext                    as Workcentertext,
      Header.operationconfirmation             as Operationconfirmation,
      Header.shift                             as Shift,
      Header.operatorname                      as Operatorname,
      Header.previousopt                       as Previousopt,
      Header.nextopt                           as Nextopt,
      Header.filename                          as Filename,
      Header.attachments                       as Attachments,
      Header.mimetype                          as Mimetype,
      Header.dmt                               as Dmt,
      Header.vcd                               as Vcd,
      Header.dial                              as Dial,
      Header.dpmt                              as Dpmt,
      Header.pp                                as Pp,
      Header.gaugenogo                         as Gaugenogo,
      Header.nogo                              as Nogo,
      Header.other                             as Other,
      Header.qcstatus                          as Qcstatus,
            @Semantics.systemDateTime.createdAt: true
      
      Header.created_on                        as CreatedOn,
      @Semantics.user.createdBy: true
      Header.created_by                        as CreatedBy,
      @Semantics.systemDateTime.lastChangedAt: true
      Header.changed_on                        as ChangedOn,
      @Semantics.user.lastChangedBy: true
      Header.changed_by                        as ChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      Header.local_last_changed_on             as LocalLastChangedOn,
      @Semantics.user.localInstanceLastChangedBy: true
      Header.local_last_changed_by             as LocalLastChangedBy,
      Header.qty_chkd,
       Header.inv_no,
       Header.inv_date,
                   @Semantics.quantity.unitOfMeasure: 'Baseunit'
       
       Header.inv_qty,
       Header.cust_draw,
       Header.sks_draw,
       Header.materiallongtxt,
       
        Header.attachments_ul                     as Attachments_ul,
        Header.mimetype_ul                        as Mimetype_ul,
        Header.filename_ul                        as Filename_ul,
        Header.formtype      ,
        Header.remark,
                Header.lever,
                        Header.basedon,
                        
                        Header.po_no             ,
  Header.approved_by             ,
  Header.reported_by            ,
  Header.checked_visually,
        
//  cast(
//  concat_with_space(
//    coalesce( cast( Header.material as abap.char(40) ), 'NO_MAT' ),
//    coalesce( cast( _Text.ProductDescription as abap.char(200) ), 'NO_DESC' ),
//    1
//  )
//  as abap.char(256)
//) as MaterialDescription,

cast(  _Text.ProductDescription as abap.char(256)   ) as MaterialDescription,
      Header.customername as CustomerName,
      _Item,
      _OperationItem
}
