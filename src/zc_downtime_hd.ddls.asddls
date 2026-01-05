@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Downtime Header Consumption'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define root view entity ZC_DOWNTIME_HD provider contract transactional_query as projection on ZR_DOWNTIME_HD
{
    key Cuuid,
    Downtimeno,
      @Consumption.valueHelpDefinition: [{ entity :{  element: 'Plant' , name: 'I_PlantStdVH' } }]
    
    Plant,
    Filename,
     @Semantics.largeObject:{
          mimeType: 'Mimetype',
          fileName: 'Filename',
          contentDispositionPreference: #INLINE
          }
    Attachments,
    Mimetype,
    @Semantics.systemDateTime.createdAt: true
    CreatedOn,
    @Semantics.user.createdBy: true
    CreatedBy,
    @Semantics.systemDateTime.lastChangedAt: true
    ChangedOn,
    
    @Semantics.user.lastChangedBy: true
    
    ChangedBy,
    LocalLastChangedOn,
    LocalLastChangedBy,
         _Item : redirected to composition child ZC_DOWNTIME_IT
,
        _GrandChild: redirected to ZC_DOWNTIME_RE

}
