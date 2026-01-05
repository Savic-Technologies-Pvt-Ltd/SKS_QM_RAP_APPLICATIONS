@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Form Item Interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZR_BOOKING_F_IT as select from zsd_book_f_it as a

//left outer join I_SalesOrderItem as b on b.SalesOrder = a.salesorder_k
association to parent ZR_BOOKING_F_HD


 as _HDR on $projection.Cuuid = _HDR.Cuuid
{
    key a.cuuid as Cuuid,
    key a.itemno as Itemno,
    key a.salesorder_k ,
   cast ( a.material as  abap.char(30) ) as Material,
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
    _HDR
}
