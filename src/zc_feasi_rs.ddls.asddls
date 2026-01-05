

@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Feasibility Item Consumption'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZC_FEASI_RS as projection  on ZR_FEASI_RS

{
    key Cuuid,
    key Itemno,
    Area,
    High,
        Medium,
    Low,
     high_value  ,
  medium_value ,
  low_value  ,
    /* Associations */
    _HDR: redirected to parent ZC_FEASI_HD

}
