@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Line Inspection Accept/Reject Value Help'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZQM_BA_LINSP_ACCREJ_VH
  as select from    DDCDS_CUSTOMER_DOMAIN_VALUE(
                    p_domain_name : 'ZQM_D_ACC_REJ')   as Values
    left outer join DDCDS_CUSTOMER_DOMAIN_VALUE_T(
                      p_domain_name : 'ZQM_D_ACC_REJ') as Texts on  Texts.domain_name    = Values.domain_name
                                                              and Texts.value_position = Values.value_position
                                                             and Texts.language       = $session.system_language
{
  key Texts.text as Text
}
where
     Values.value_low = '1'
  or Values.value_low = '2'
  or Values.value_low = '3'
  or Values.value_low = '4'
  or Values.value_low = '5'
