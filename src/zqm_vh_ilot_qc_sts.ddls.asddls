@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '5 Piece Inspection Lot Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@ObjectModel.resultSet.sizeCategory: #XS
define view entity ZQM_VH_ILOT_QC_STS
  as select from    DDCDS_CUSTOMER_DOMAIN_VALUE(
                    p_domain_name : 'ZQM_D_ILOT')   as Values
    left outer join DDCDS_CUSTOMER_DOMAIN_VALUE_T(
                       p_domain_name : 'ZQM_D_ILOT') as Texts on  Texts.domain_name    = Values.domain_name
                                                             and Texts.value_position = Values.value_position
                                                             and Texts.language       = $session.system_language
{
  key Texts.text as Text
}
where
     Values.value_low = '1'
  or Values.value_low = '2'
  or Values.value_low = '3'
