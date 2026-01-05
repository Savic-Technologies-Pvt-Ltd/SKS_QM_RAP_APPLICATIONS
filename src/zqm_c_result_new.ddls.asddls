


@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Line Inspection Result Consumption'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZQM_C_RESULT_NEW
  as projection on ZQM_I_RESULT_NEW

{
  key Cuuid,
 // key Cuuiddate,
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

      _SPC : redirected to parent ZQM_C_line_insp_item_NEW
,
      _HDR : redirected to ZQM_C_line_insp_NEW

      /* Associations */


}
