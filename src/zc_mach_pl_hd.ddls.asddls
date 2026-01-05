@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Machine Plan Header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZC_MACH_PL_HD provider contract transactional_query as projection on ZR_MACH_PL_HD
{
    key Cuuid,
    Machineplanno,
     @Semantics: {
    systemDateTime.createdAt: true
  }
    CreatedOn,
     @Semantics: {
    user.createdBy: true
  }
    CreatedBy,
     @Semantics: {
    systemDateTime.lastChangedAt: true
  }
    ChangedOn,
     @Semantics: {
    user.lastChangedBy: true
  }
    ChangedBy,
    LocalLastChangedOn,
    LocalLastChangedBy,
     
        filename           ,
         @Semantics.largeObject:{
          mimeType: 'mimetype',
          fileName: 'filename',
          contentDispositionPreference: #INLINE
          }
  attachments       ,
  mimetype          ,
    workcenter        ,
          @Consumption.valueHelpDefinition: [{ entity :{  element: 'WorkCenterInternalID' , name: 'I_WorkCenter' } }]
    
  workcenterid       ,
         _Item : redirected to composition child ZC_MACH_PL_IT

    
}
