@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Feasibility Header Consumption'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZC_FEASI_HD provider contract transactional_query as projection on ZR_FEASI_HD
{
    key Cuuid,
    Feasibilityno,
    CreatedOn,
    CreatedBy,
    ChangedOn,
    ChangedBy,
    LocalLastChangedOn,
    LocalLastChangedBy ,    clarificationfield,
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
             @Consumption.valueHelpDefinition: [{ entity :{  element: 'SalesInquiry' , name: 'I_SalesInquiry' } 
             
             ,
      additionalBinding: [{
          localElement: 'enquiryitem',
          element: 'SalesInquiryType'
      }]
      }]
   
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
        @Semantics.largeObject:{
          mimeType: 'mimetype',
          fileName: 'filename',
          contentDispositionPreference: #INLINE
          }
  attachments        ,
  mimetype            ,
  enquiryitem,
            @Consumption.valueHelpDefinition: [{ entity: { name: 'ZD_CONCLUSION', element: 'operatorNameText' } }]
  
  conclusion,
         _Item : redirected to composition child ZC_FEASI_IT,
         _Opr : redirected to composition child ZC_FEASI_OP,
         _Risk : redirected to composition child ZC_FEASI_RS

         

}
