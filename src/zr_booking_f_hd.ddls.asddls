@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Form Header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define  root view entity ZR_BOOKING_F_HD as select from zsd_book_f_hd
 composition [1..*] of ZR_BOOKING_F_IT as _Item

{
    key cuuid as Cuuid,
    bookingform as Bookingform,
    salesorder       ,
  salesdoctype       ,
  company            ,
    createdon            as Createdon,
    createdby as Createdby,
    changedon as Changedon,
    changedby as Changedby,
    locallastchangedon as Locallastchangedon,
    locallastchangedby as Locallastchangedby,
     filename           ,
  attachments       ,
  mimetype          ,
    _Item
}
