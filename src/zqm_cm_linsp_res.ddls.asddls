@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Line Inspection Results Consumption View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZQM_CM_LINSP_RES
  as projection on ZQM_BA_LINSP_RES
{
  key Cuuid,
  key Cuuiddate,
  key Cuuidresult,
  key Boooperationinternalid,
  key Inspectionlotitem,
  key Inspectionlot,
  key Boocharacteristicversion,
  key Inspectionplangroup,
      Spc,
      RecordingDateTime,
      Specification,
      Selectedcodesettext,
      Result1,
      Result2,
      Result3,
      Result4,
      Result5,
      Result6,
      Result7,
      Result8,
      Result9,
      Result10,
      Result11,
      Result12,
      Resultval1,
      Resultval2,
      Resultval3,
      Resultval4,
      Resultval5,
      Resultval6,
      Resultval7,
      Resultval8,
      Resultval9,
      Resultval10,
      Resultval11,
      Resultval12,
      Resulttxt1,
      Resulttxt2,
      Resulttxt3,
      Resulttxt4,
      Resulttxt5,
      Resulttxt6,
      Resulttxt7,
      Resulttxt8,
      Resulttxt9,
      Resulttxt10,
      Resulttxt11,
      Resulttxt12,

      _SPC : redirected to parent ZQM_CM_LINSP_SPC,
      _HDR : redirected to ZQM_CM_LINSP_HDR
      /* Associations */


}
