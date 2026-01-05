@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZQM_C_Inprocess_cHEM_NEW'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define  view entity ZQM_C_Inprocess_cHEM_NEW as projection on ZQM_i_Inprocess_cHEM_NEW


{
    key Cuuid as Cuuid,
    key Itemno as Itemno,
    element,
    CPercent as CPercent,
    SPercent as SPercent,
    BPercent as BPercent,
    PPercent as PPercent,
    MinValue as MinValue,
    MaxValue as MaxValue,
    Actual as Actual,
    _HDR : redirected to parent ZQM_C_Inprocess_NEW
}
