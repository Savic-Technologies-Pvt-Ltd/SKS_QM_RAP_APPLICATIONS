


@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gate Type Domain Values'

@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.representativeKey: 'KEYVALUE'
define view entity ZC_ACCEPTANCE
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( 
       p_domain_name: 'ZD_ACCEPTANCE' ) as dd07t
{
  @EndUserText.label: 'Operator Name'
  @ObjectModel.text.element: ['VALUE']
  key dd07t.value_low as KEYVALUE,

  @EndUserText.label: 'Gate Type Text'
  dd07t.text as VALUE
}
where dd07t.language = $session.system_language
