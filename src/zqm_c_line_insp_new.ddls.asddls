@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Line Inspection Consumption Header'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZQM_C_line_insp_NEW provider contract transactional_query
  as projection on ZQM_I_line_insp_NEW
  
{
    
   key Cuuid,
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
    
      @Semantics.largeObject:{
          mimeType: 'Mimetype',
          fileName: 'Filename',
          contentDispositionPreference: #INLINE
          }
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
    Result1,
    Result2,
    Result3,
    Result4,
    Result5,
    Result6,
    Result7,
    Result8,
    Result9,
    Result10,
    Result11,
    Result12,
    Result13,
    Result14,
    Result15,
    Result16,
    Qcstatus,
    Snapgauge,
    Pokayokecheck,
    Loadverification,
    Machinecleanins,
    Qa5pcsstat,
    Chutecleanop,
    Chutpieces,
    Inspobs,
    Machpcs,
    Rawmaterial,
    Subqa2prd,
    Subprd2qa,
    Obs5pcs1st,
    Obslast,
    Obsfinal,
    Rejqty,
    Materialdescription,
    Customername,
    QtyChkd,
    InvNo,
    InvDate,
                @Semantics.quantity.unitOfMeasure: 'Baseunit'
    
    InvQty,
    CustDraw,
    SksDraw,
    Materiallongtxt,
    FilenameUl,
     @Semantics.largeObject:{
          mimeType: 'MimetypeUl',
          fileName: 'FilenameUl',
          contentDispositionPreference: #INLINE
          }
    AttachmentsUl,
              @Semantics.mimeType: true
    
    MimetypeUl,
    Formtype,
    Remark,
    Lever,
    Basedon,
    PoNo,
    ApprovedBy,
    ReportedBy,
    CheckedVisually,
    CreatedOn,
    CreatedBy,
    ChangedOn,
    ChangedBy,
    LocalLastChangedOn,
    LocalLastChangedBy,
    
     _Item : redirected to composition child ZQM_C_line_insp_item_NEW

    
}
