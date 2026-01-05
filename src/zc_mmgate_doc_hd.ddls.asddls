@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Document Header Consumption View'
@Metadata.ignorePropagatedAnnotations: true

define view entity ZC_MMGATE_DOC_HD  as  projection on ZR_MMGATE_DOC_HD
{
    key Gatenumber,
    key Plant,
     @UI.facet: [ {
    label: 'General Information', 
    id: 'GeneralInfo', 
    purpose: #STANDARD, 
    position: 10 , 
    type: #IDENTIFICATION_REFERENCE
  }  
  ]
   @UI.identification: [ {
    position: 10 , 
    label: 'Document Number'
  } ]
  @UI.lineItem: [ {
    position: 10, 
    label: 'Document Number'
  } ]
  @UI.selectionField: [ {
    position:10 
  } ]
    key doc_num,
     @UI.identification: [ {
    position: 20 , 
    label: 'Document Date'
  } ]
  @UI.lineItem: [ {
    position: 20, 
    label: 'Document Date'
  } ]
  @UI.selectionField: [ {
    position:20 
  } ]
    doc_date ,
     @UI.identification: [ {
    position: 30 , 
    label: 'Vendor'
  } ]
  @UI.lineItem: [ {
    position: 30, 
    label: 'Vendor'
  } ]
  @UI.selectionField: [ {
    position:30 
  } ]
    Vendor,
         @UI.identification: [ {
    position: 40 , 
    label: 'Vendor Name'
  } ]
  @UI.lineItem: [ {
    position: 40, 
    label: 'Vendor Name'
  } ]
  @UI.selectionField: [ {
    position:40 
  } ]
    Vendorname,
    
    inwardtype,
    /* Associations */
    _header : redirected to parent ZC_MMGATE_HEAD
}
