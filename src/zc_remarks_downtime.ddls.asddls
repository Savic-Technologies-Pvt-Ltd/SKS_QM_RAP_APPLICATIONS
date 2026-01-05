

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gate Type Domain Values'

@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.representativeKey: 'KEYVALUE'
define view entity ZC_REMARKS_DOWNTIME
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( 
       p_domain_name: 'ZD_REMARKS_DOWNTIME' ) as dd07t
{
  @EndUserText.label: 'Remark ID'
  @ObjectModel.text.element: ['VALUE']
  key dd07t.value_low as KEYVALUE,

  @EndUserText.label: 'Remark'
  dd07t.text as VALUE
}
where dd07t.language = $session.system_language
