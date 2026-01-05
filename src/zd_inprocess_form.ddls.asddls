

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gate Type Domain Values'

@ObjectModel.dataCategory: #VALUE_HELP
@ObjectModel.representativeKey: 'formType'
define view entity ZD_INPROCESS_FORM
  as select from DDCDS_CUSTOMER_DOMAIN_VALUE_T( 
       p_domain_name: 'ZD_INPROCESS_FORM' ) as dd07t
{
  @EndUserText.label: 'Form Type'
  @ObjectModel.text.element: ['formText']
  key dd07t.value_low as formType,

  @EndUserText.label: 'Form Type Text'
  dd07t.text as formText
}
where dd07t.language = $session.system_language
