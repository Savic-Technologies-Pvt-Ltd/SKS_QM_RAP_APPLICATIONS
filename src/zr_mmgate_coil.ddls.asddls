@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Coil Interface View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZR_MMGATE_COIL as select from zmm_gate_coil

 association to parent ZR_MMGATE_ITEM as _ITEM on  $projection.Gatenumber                  = _ITEM.Gatenumber
                                                             and $projection.Item          = _ITEM.Item
                                                            and $projection.Plant    = _ITEM.plant
                                                            and $projection.doc_num  = _ITEM.doc_num
                                                            
  association to ZR_MMGATE_HEAD        as _Header         on  $projection.Gatenumber = _Header.Gatenumber 
  and $projection.Plant = _Header.plant


     
{
    key gatenumber as Gatenumber,
    key item as Item,
    key plant as Plant,
    key coilno as Coilno,
    key doc_num as doc_num,
      @Semantics.quantity.unitOfMeasure : 'meins'
    
    qty,
    meins,
    acceptance,
    _ITEM,
    _Header
}
