@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZQM_i_Inprocess_cHEM_NEW'
@Metadata.ignorePropagatedAnnotations: true
define  view entity ZQM_i_Inprocess_cHEM_NEW as select from zqm_t_inpr_ch
    association to parent ZQM_I_Inprocess_NEW

 as _HDR on $projection.Cuuid = _HDR.Cuuid 
{
    key cuuid as Cuuid,
    key itemno as Itemno,
    element,
    c_percent as CPercent,
    s_percent as SPercent,
    b_percent as BPercent,
    p_percent as PPercent,
    min_value as MinValue,
    max_value as MaxValue,
    actual as Actual,
   _HDR   // Make association public
}
