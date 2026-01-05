

@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Line Inspection Result'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZQM_I_RESULT_NEW
  as select from zqm_t_res_it
  association to parent ZQM_I_line_insp_item_NEW
 as _SPC on  $projection.Cuuid                    = _SPC.Cuuid
                                               //  and $projection.Cuuiddate                = _SPC.cuuiddate
                                                 and $projection.Inspectionlot            = _SPC.Inspectionlot
                                                 and $projection.Inspectionlotitem        = _SPC.Inspectionlotitem
                                                 and $projection.Inspectionplangroup      = _SPC.Inspectionplangroup
                                                 and $projection.Boooperationinternalid   = _SPC.Boooperationinternalid
                                                 and $projection.Boocharacteristicversion = _SPC.Boocharacteristicversion

  association to ZQM_I_line_insp_NEW        as _HDR on  $projection.Cuuid = _HDR.Cuuid
{
  key cuuid                    as Cuuid,
//  key cuuiddate                as Cuuiddate,
  key cuuidresult              as Cuuidresult,
  key boooperationinternalid   as Boooperationinternalid,
  key inspectionlotitem        as Inspectionlotitem,
  key inspectionlot            as Inspectionlot,
  key boocharacteristicversion as Boocharacteristicversion,
  key inspectionplangroup      as Inspectionplangroup,
      spc                      as Spc,
      recordingdatetime as RecordingDateTime,
      specification            as Specification,
      selectedcodesettext      as Selectedcodesettext,
      result1                  as Result1,
      result2                  as Result2,
      result3                  as Result3,
      result4                  as Result4,
      result5                  as Result5,
      result6                  as Result6,
      result7                  as Result7,
      result8                  as Result8,
      result9                  as Result9,
      result10                 as Result10,
      result11                 as Result11,
      result12                 as Result12,
      resultval1               as Resultval1,
      resultval2               as Resultval2,
      resultval3               as Resultval3,
      resultval4               as Resultval4,
      resultval5               as Resultval5,
      resultval6               as Resultval6,
      resultval7               as Resultval7,
      resultval8               as Resultval8,
      resultval9               as Resultval9,
      resultval10              as Resultval10,
      resultval11              as Resultval11,
      resultval12              as Resultval12,
      resulttxt1               as Resulttxt1,
      resulttxt2               as Resulttxt2,
      resulttxt3               as Resulttxt3,
      resulttxt4               as Resulttxt4,
      resulttxt5               as Resulttxt5,
      resulttxt6               as Resulttxt6,
      resulttxt7               as Resulttxt7,
      resulttxt8               as Resulttxt8,
      resulttxt9               as Resulttxt9,
      resulttxt10              as Resulttxt10,
      resulttxt11              as Resulttxt11,
      resulttxt12              as Resulttxt12,
      res_mark1,
      res_mark2,
      res_mark3,
      res_mark4,
      res_mark5,
      res_mark6,
      res_mark7,
      res_mark8,
      res_mark9,
      res_mark10,
      res_mark11,
      res_mark12,
      /* Associations */
      _SPC,
      _HDR
}
