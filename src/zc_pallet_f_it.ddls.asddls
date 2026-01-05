@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Pallet Item'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define  view entity ZC_PALLET_F_IT as projection on ZR_PALLET_F_IT

{
    key Cuuid,
    key Delivery,
    key Itemno,
    Partno,
    Pono,
    Catcode,
    Partdesc,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    Qty,
    Uom,
    Lotno,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    Stock,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    Poqty,
    Pallettype,
    
       qty_box     ,
  pallet       ,
  no_of_boxes  ,
  total        ,
    @Semantics.quantity.unitOfMeasure: 'Uom'
  finish_wt    ,
    @Semantics.quantity.unitOfMeasure: 'Uom'
  net_wt       ,
    @Semantics.quantity.unitOfMeasure: 'Uom'
  box_wt      ,
    @Semantics.quantity.unitOfMeasure: 'Uom'
  pallet_wt    ,
    @Semantics.quantity.unitOfMeasure: 'Uom'
  gross_wt     ,
  vbeln ,
vbelp ,
    /* Associations */
    _HDR: redirected to parent ZC_PALLET_F_HD

}
