@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MM Gate Item'
@Metadata.ignorePropagatedAnnotations: true
define   view entity  ZR_MMGATE_ITEM as select from zmm_gate_item

association to parent ZR_MMGATE_HEAD as _header
    on $projection.Gatenumber = _header.Gatenumber and
     $projection.plant = _header.plant
     
       composition [*] of  ZR_MMGATE_COIL    as _COIL
     
    
    
    
 
{
    key zmm_gate_item.gatenumber as Gatenumber,
    key zmm_gate_item.item as Item,
        key zmm_gate_item.plant as plant,
     key zmm_gate_item.doc_num ,
        @Semantics.quantity.unitOfMeasure : 'Meins'
    
    zmm_gate_item.qty as Qty,
    zmm_gate_item.meins as Meins,
    zmm_gate_item.coilno as Coilno,
    zmm_gate_item.createdby as Createdby,
    zmm_gate_item.creat_dat as CreatDat,
    zmm_gate_item.chan_by as ChanBy,
    zmm_gate_item.chan_at as ChanAt,
    zmm_gate_item.po as Po,
    zmm_gate_item.matnr,
        zmm_gate_item.maktx,
         @Semantics.quantity.unitOfMeasure : 'Meins'
        zmm_gate_item.receivedqty,
        @Semantics.amount.currencyCode: 'waers'
        zmm_gate_item.netpr,
        zmm_gate_item.waers,
    zmm_gate_item.local_last_changed_at as LocalLastChangedAt,
    //_header // Make association p,
    _header,
    _COIL
}
