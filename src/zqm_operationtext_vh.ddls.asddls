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
define view entity ZQM_OperationText_VH
  as select distinct from I_WorkCenterText
{
       @EndUserText.label: 'Opeartion'
  key  WorkCenterText as Opeartion
}
where
      I_WorkCenterText.WorkCenterInternalID = '10000004'
  and Language             = $session.system_language
