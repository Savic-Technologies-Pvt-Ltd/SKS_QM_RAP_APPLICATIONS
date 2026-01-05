@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Form Item Consumption'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZC_BOOKING_F_IT as projection on  ZR_BOOKING_F_IT
{
    key Cuuid,
    key Itemno,
    key salesorder_k,
    Material
    ,
    salesdoctype      ,
  company            ,
      partnum        ,
  partdesc        ,
  poqty,
  varqty,
  palletlen       ,
  palletwid       ,
  pallethgt       ,
  qtypercarton    ,
  shipqty         ,
  grosswt         ,
  loadport        ,
  finishwt        ,
  netwt           ,
  totbox          ,
  boxwt           ,
  boxnetwt        ,
  pallettype      ,
  totpallet       ,
  palletwt        ,
  fnlcode         ,
  ponum           ,
    /* Associations */
    _HDR: redirected to parent ZC_BOOKING_F_HD

    
}
