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
define view entity ZC_FEASI_OP as projection  on ZR_FEASI_OP

{
    key Cuuid,
    key Itemno,
        key cuuiditem,
     itemnumber,
    Machine,
    Remarks,
        operation,
    
    /* Associations */
    _HDR: redirected to parent ZC_FEASI_HD

}
