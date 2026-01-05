@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Machine Plan Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZC_MACH_PL_IT as projection on  ZR_MACH_PL_IT
{
    key Cuuid,
    key Itemno,
              @Consumption.valueHelpDefinition: [{ entity :{  element: 'WorkCenterInternalID' , name: 'I_WorkCenter' } }]
    
     machine ,
       workorder       ,
  workcenter          ,
  distributionchannel ,
  catalogcode         ,
  description         ,
  toollayout          ,
  sksdrgno            ,
  rmgrade             ,
  ext_ser             ,
  customer_name      ,
  hardness            ,
  speed,
  workcentername,
    /* Associations */
    _HDR: redirected to parent ZC_MACH_PL_HD

}
