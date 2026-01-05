@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Downtime Item Consumption'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZC_DOWNTIME_IT as projection on  ZR_DOWNTIME_IT
{
    key Cuuid,
    @Consumption.valueHelpDefinition: [{ entity :{  element: 'WorkCenterInternalID' , name: 'I_WorkCenter' } }]
    
    key Workcenter,
    Workcentername,
      @Consumption.valueHelpDefinition: [{ entity : { name: 'ZCDS_QM_DD_01' , element: 'Value' } }]
    
        shift          ,
  operator       ,
  supervisor      ,
  machinespace   ,
  nonprd1        ,
  nonprd2         ,
  productionorder ,
  contractor     ,
  reworkqty    ,
  rejectqty     ,
  lotno       ,
  bom           ,
  prodqty       ,
  shiftstarttime  ,
  shiftendtime,
      totalprodmin    ,
  totalnonprodmin ,ztotalnonprodmin,
  
        _HDR: redirected to parent ZC_DOWNTIME_HD,
                 _remark : redirected to composition child ZC_DOWNTIME_RE

        

    
}
