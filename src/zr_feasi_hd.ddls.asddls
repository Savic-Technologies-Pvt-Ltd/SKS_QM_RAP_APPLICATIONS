@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Feasibility Header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZR_FEASI_HD as select from zsd_feasi_hd
 composition [1..*] of ZR_FEASI_IT as _Item
 composition [1..*] of ZR_FEASI_OP as _Opr
 composition [1..*] of ZR_FEASI_RS as _Risk

{
    key cuuid as Cuuid,
    feasibilityno as Feasibilityno,
    created_on as CreatedOn,
    created_by as CreatedBy,
    changed_on as ChangedOn,
    changed_by as ChangedBy,
    local_last_changed_on as LocalLastChangedOn,
    local_last_changed_by as LocalLastChangedBy,
    clarificationfield,
    
     req_of_new_guage   ,
  raw_material         ,
  wire_dia             ,
  surface_area         ,
  @Semantics.quantity.unitOfMeasure : 'uom'
  input_weight       ,
  @Semantics.quantity.unitOfMeasure : 'uom'
  finish_weight      ,
  uom,
  
     engg_name    ,
  sales_mem_name   ,
    enquiry_no         ,  
  customer             ,
  part_description      ,
  part_no               ,
  grade                ,
  surface_finish        ,
  volume             ,
  provided_by          ,
  application           ,
  other                 ,
  sales_coord_name    ,
  filename           ,
  attachments        ,
  mimetype            ,
  enquiryitem,
  conclusion,
    _Item,
    _Opr,
    _Risk
}
