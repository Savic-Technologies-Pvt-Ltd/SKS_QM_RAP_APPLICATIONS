@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Downtime Remarks'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

@Metadata.allowExtensions: true
define view entity ZC_DOWNTIME_RE  as projection on ZR_DOWNTIME_RE
{
    key Cuuid,
    key Workcenter,
    
//   @Consumption.valueHelpDefinition: [{ entity :{  element: 'KEYVALUE' , name: 'ZC_REMARKS_DOWNTIME' } }]
    
    key Remarks,
        key grandcuuid,
           @Consumption.valueHelpDefinition: [{ entity :{  element: 'KEYVALUE' , name: 'ZC_REMARKS_DOWNTIME' } }]
        
    remarksid,
    Remarksdesc,
      starttime      ,
  endtime        ,
  totaltime      ,
  totalmin,
      settingpart ,
supervisor ,
operator ,
   
    _workcenter  : redirected to parent ZC_DOWNTIME_IT,
      _HDR : redirected to ZC_DOWNTIME_HD
      
}
