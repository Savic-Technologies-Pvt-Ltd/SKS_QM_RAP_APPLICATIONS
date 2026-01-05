@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Line Inspection Results Basic View'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZQM_BA_LINSP_RES
  as select from zqm_t_linsp_res
  association to parent ZQM_BA_LINSP_SPC as _SPC on  $projection.Cuuid                    = _SPC.Cuuid
                                                 and $projection.Cuuiddate                = _SPC.cuuiddate
                                                 and $projection.Inspectionlot            = _SPC.Inspectionlot
                                                 and $projection.Inspectionlotitem        = _SPC.InspectionLotItem
                                                 and $projection.Inspectionplangroup      = _SPC.InspectionPlanGroup
                                                 and $projection.Boooperationinternalid   = _SPC.BOOOperationInternalID
                                                 and $projection.Boocharacteristicversion = _SPC.BOOCharacteristicVersion

  association to ZQM_BA_LINSP_HDR        as _HDR on  $projection.Cuuid = _HDR.Cuuid
{
  key cuuid                    as Cuuid,
  key cuuiddate                as Cuuiddate,
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

      /* Associations */
      _SPC,
      _HDR
}
