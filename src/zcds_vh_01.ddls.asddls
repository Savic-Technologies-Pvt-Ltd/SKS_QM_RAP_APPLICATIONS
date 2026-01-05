@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help For Operation'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZCDS_VH_01
  as select distinct from I_WorkCenterText
{
       @EndUserText.label: 'Opeartion'
  key  WorkCenterText as Opeartion
}
where
  Language = $session.system_language
