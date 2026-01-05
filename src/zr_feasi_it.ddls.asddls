@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Feasibility Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZR_FEASI_IT as select from zsd_feasi_it
 association to parent ZR_FEASI_HD
 as _HDR on $projection.Cuuid = _HDR.Cuuid
 
{
    key cuuid as Cuuid,
    key itemno as Itemno,
    remarks as Remarks,
    yes_no,
    _HDR
}
