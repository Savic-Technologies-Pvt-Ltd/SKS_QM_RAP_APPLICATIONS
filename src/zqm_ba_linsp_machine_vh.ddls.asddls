@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Line Inspection Machine Basic View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZQM_BA_LINSP_MACHINE_VH
  as select distinct from I_WorkCenterText
{
       @EndUserText.label: 'Opeartion'
  key  WorkCenterText as Opeartion
}
where
  Language = $session.system_language
