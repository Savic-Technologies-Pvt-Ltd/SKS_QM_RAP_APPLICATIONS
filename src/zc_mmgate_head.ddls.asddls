@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@EndUserText: {
  label: '###GENERATED Core Data Service Entity'
}
@ObjectModel: {
  sapObjectNodeType.name: 'ZMMGATE_HEAD'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_MMGATE_HEAD
  provider contract transactional_query
  as projection on ZR_MMGATE_HEAD
  association [1..1] to ZR_MMGATE_HEAD as _BaseEntity on $projection.Gatenumber = _BaseEntity.Gatenumber


{
  key Gatenumber,
     
  @Consumption.valueHelpDefinition: [{ entity: { name: 'ZC_PlantSearchHelp', element: 'Plant' } }]
  key plant,
  Truckdata,
  Transportername,
  Vehicleno,
  Drivername,
  @Semantics: {
    user.createdBy: true
  }
  Createdby,
  @Semantics: {
    systemDateTime.createdAt: true
  }
  CreatDat,
  @Semantics: {
    user.lastChangedBy: true
  }
  ChanBy,
  @Semantics: {
    systemDateTime.lastChangedAt: true
  }
  ChanAt,
  @Semantics: {
    systemDateTime.localInstanceLastChangedAt: true
  }
  LocalLastChangedAt,

  _BaseEntity,
  
  
  
    ebeln             ,
        @Consumption.valueHelpDefinition: [{ entity: { name: 'ZC_INWARD_TYPE', element: 'GateType' } }]
    
    inwardtype,
  ekorg                ,
  ekgrp                 ,
  lifnr                 ,
  bukrs                 ,
  vendorname            ,
  einvoicenumber        ,
  einvoicedate          ,
  podate             
  ,
   invoicenumber       ,
  invoicedate          ,
   ewayinvoicenumber     ,
  ewayinvoicedate       ,
  manualgateentry,
   challanno              ,
  challandate         ,
    @Consumption.valueHelpDefinition: [{ entity: { name: 'ZC_GATETYPE', element: 'GateType' } }]
   
  
  gatetype,
  
  
   Filename,
      
       @Semantics.largeObject:{
          mimeType: 'Mimetype',
          fileName: 'Filename',
          contentDispositionPreference: #INLINE
          }
          Attachments,
      Mimetype,
  
   _item : redirected to composition child ZC_MMGATE_ITEM,
   _docHeader : redirected to composition child ZC_MMGATE_DOC_HD
}
