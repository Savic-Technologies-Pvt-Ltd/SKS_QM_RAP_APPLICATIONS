@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption VIew for Coil'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZC_MMGATE_COIL  as projection on  ZR_MMGATE_COIL
{
    key Gatenumber,
    key Item,
    key Plant,
    
    @UI.facet: [ {
    label: 'Coil Information', 
    id: 'Coil Information', 
    purpose: #STANDARD, 
    position: 10 , 
    type: #IDENTIFICATION_REFERENCE
  }
  ]
   @UI.identification: [ {
    position: 10 , 
    label: 'Coilno'
  } ]
  @UI.lineItem: [ {
    position: 10 , 
    label: 'Coilno'
  } ]
  @UI.selectionField: [ {
    position: 10 
  } ]
    key Coilno,
    key doc_num,
        @UI.identification: [ {
    position: 20 , 
    label: 'Quantity'
  } ]
  @UI.lineItem: [ {
    position: 20 , 
    label: 'Quantity'
  } ]
  @UI.selectionField: [ {
    position: 20 
  } ]
       
       @Semantics.quantity.unitOfMeasure : 'meins'
       
       
       qty,
       meins,
         @UI.identification: [ {
    position: 20 , 
    label: 'Accept/Reject'
  } ]
  @UI.lineItem: [ {
    position: 20 , 
    label: 'Accept/Reject'
  } ]
  @UI.selectionField: [ {
    position: 20 
  } ]
  
    @Consumption.valueHelpDefinition: [{ entity: { name: 'ZC_ACCEPTANCE', element: 'VALUE' } }]
  
       acceptance,
    
    
    /* Associations */
          _ITEM   : redirected to parent ZC_MMGATE_ITEM,
                _Header           : redirected to ZC_MMGATE_HEAD
          
    
    
    
}
