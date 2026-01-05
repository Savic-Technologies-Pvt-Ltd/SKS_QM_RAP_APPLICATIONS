@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking Form Header Consumption'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root  view entity ZC_BOOKING_F_HD provider contract transactional_query as projection on ZR_BOOKING_F_HD
{
    key Cuuid,
    Bookingform,
     @Semantics: {
    systemDateTime.createdAt: true
  }
    Createdon,
    @Semantics: {
    user.createdBy: true
  }
    Createdby,
     @Semantics: {
    systemDateTime.lastChangedAt: true
  }
    Changedon,
      @Semantics: {
    user.lastChangedBy: true
  }
    Changedby,
              @Consumption.valueHelpDefinition: [{ entity :{  element: 'SalesOrder' , name: 'I_SalesOrderStdVH' } }]
    
     salesorder       ,
  salesdoctype       ,
  company            ,
    Locallastchangedon,
    Locallastchangedby   , 
    
    filename           ,
      @Semantics.largeObject:{
          mimeType: 'mimetype',
          fileName: 'filename',
          contentDispositionPreference: #INLINE
          }
  attachments       ,
  mimetype          ,
    
    
         _Item : redirected to composition child ZC_BOOKING_F_IT

}
