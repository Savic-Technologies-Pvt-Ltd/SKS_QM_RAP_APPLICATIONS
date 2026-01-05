@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Pallet Item'
@Metadata.ignorePropagatedAnnotations: true
define  view entity ZR_PALLET_F_IT as select from zsd_pallet_it
association to parent ZR_PALLET_F_HD



 as _HDR on $projection.Cuuid = _HDR.Cuuid
{
    key cuuid as Cuuid,
    key delivery as Delivery,
    key itemno as Itemno,
    partno as Partno,
    pono as Pono,
    catcode as Catcode,
    partdesc as Partdesc,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    qty as Qty,
    uom as Uom,
    lotno as Lotno,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    stock as Stock,
    @Semantics.quantity.unitOfMeasure: 'Uom'
    poqty as Poqty,
    pallettype as Pallettype,
    
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
    _HDR // Make association public
}
