@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Value Help For Cleaned/NotCleaned'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZCDS_QM_DD_05
  as select from    DDCDS_CUSTOMER_DOMAIN_VALUE(
                    p_domain_name : 'ZDO_CHECKBOX')   as Values
    left outer join DDCDS_CUSTOMER_DOMAIN_VALUE_T(
                      p_domain_name : 'ZDO_CHECKBOX') as Texts on  Texts.domain_name    = Values.domain_name
                                                               and Texts.value_position = Values.value_position
                                                               and Texts.language       = $session.system_language
{

  key Texts.text
}
where
     Values.value_low = '3'
  or Values.value_low = '4'
