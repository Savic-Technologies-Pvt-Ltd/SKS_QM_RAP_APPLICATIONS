@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MM Gate Item Consumption'
@Metadata.ignorePropagatedAnnotations: true
define  view entity ZC_MMGATE_ITEM as  projection on ZR_MMGATE_ITEM

{

key Gatenumber,
 @UI.facet: [ {
    label: 'General Information', 
    id: 'GeneralInfo', 
    purpose: #STANDARD, 
    position: 10 , 
    type: #IDENTIFICATION_REFERENCE
  }  ,{
  
                  purpose:         #STANDARD,
                  type:           #LINEITEM_REFERENCE,
                    label:           'Coil number',
                  position:        20 ,
                  targetElement: '_COIL'}
  ]
   @UI.identification: [ {
    position: 10 , 
    label: 'Item'
  } ]
  @UI.lineItem: [ {
    position: 10 , 
    label: 'Item'
  } ]
  @UI.selectionField: [ {
    position: 10 
  } ]
key Item,

key plant,
  @UI.identification: [ {
    position: 15 , 
    label: 'Document Number'
  } ]
  @UI.lineItem: [ {
    position: 15 , 
    label: 'Document Number'
  } ]
  @UI.selectionField: [ {
    position: 15 
  } ]
 key doc_num ,
    @Semantics.quantity.unitOfMeasure : 'Meins'
  @UI.identification: [ {
    position: 20 , 
    label: 'Actual Qty'
  } ]
  @UI.lineItem: [ {
    position: 20 , 
    label: 'Actual Qty'
  } ]
  @UI.selectionField: [ {
    position: 20 
  } ]
Qty,

    

Meins,
  @UI.identification: [ {
    position: 75 , 
    label: 'Coil Count'
  } ]
  @UI.lineItem: [ {
    position: 75, 
    label: 'Coil Count'
  } ]
  @UI.selectionField: [ {
    position:75 
  } ]
Coilno,

 @UI.identification: [ {
    position: 60 , 
    label: 'Material'
  } ]
  @UI.lineItem: [ {
    position: 60 , 
    label: 'Material'
  } ]
  @UI.selectionField: [ {
    position: 60 
  } ]

matnr,
 @UI.identification: [ {
    position: 70 , 
    label: 'Material Description'
  } ]
  @UI.lineItem: [ {
    position: 70 , 
    label: 'Material Description'
  } ]
  @UI.selectionField: [ {
    position: 70 
  } ]

maktx,
 @UI.identification: [ {
    position: 80 , 
    label: 'Rcvd/Tran. Qty'
  } ]
  @UI.lineItem: [ {
    position: 80 , 
    label: 'Rcvd/Tran. Qty'
  } ]
  @UI.selectionField: [ {
    position: 80 
  } ]
    @Semantics.quantity.unitOfMeasure : 'Meins'
receivedqty,
 @Semantics.amount.currencyCode: 'waers'
@UI.identification: [ {
    position: 90 , 
    label: 'Price'
  } ]
  @UI.lineItem: [ {
    position: 90 , 
    label: 'Price'
  } ]
  
netpr,
waers,
Createdby,
CreatDat,
ChanBy,
ChanAt,
LocalLastChangedAt,
 _header : redirected to parent ZC_MMGATE_HEAD,
       _COIL   : redirected to composition child ZC_MMGATE_COIL
 
}
