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
define view entity ZC_FEASI_IT as projection  on ZR_FEASI_IT

{
    key Cuuid,
    key Itemno,
    Remarks,
    yes_no,
    /* Associations */
    _HDR: redirected to parent ZC_FEASI_HD

}
