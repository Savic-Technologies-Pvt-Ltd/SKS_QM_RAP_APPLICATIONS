@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Line Inspection Shift Basic View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZQM_BA_LINSP_SHIFT_VH
  as select from    DDCDS_CUSTOMER_DOMAIN_VALUE(
                     p_domain_name : 'ZQM_D_SHIFT') as Values
    left outer join DDCDS_CUSTOMER_DOMAIN_VALUE_T(
                      p_domain_name : 'ZQM_SHIFT')  as Texts on  Texts.domain_name    = Values.domain_name
                                                             and Texts.value_position = Values.value_position
                                                             and Texts.language       = $session.system_language
{
  key Values.value_low as Value
}
