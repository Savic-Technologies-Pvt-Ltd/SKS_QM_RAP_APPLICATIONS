

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gate Type Domain Values'

@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.representativeKey: 'operatorName'
define view entity ZQM_APPR_FURTHER
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( 
       p_domain_name:  'ZQM_APPR_FURTHER' ) as dd07t
{
  @EndUserText.label: 'Operator Name'
  @ObjectModel.text.element: ['operatorNameText']
  key dd07t.value_low as operatorName,

  @EndUserText.label: 'Gate Type Text'
  dd07t.text as operatorNameText
}
where dd07t.language = $session.system_language
