@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: '5 Piece Inspection Lot Report'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZQM_BA_ILOT_I
  //  as select from    zqm_t_ilot_h                 as Header
  //
  //    left outer join I_InspectionCharacteristic   as Char on Char.InspectionLot = Header.reportnumber
  //
  //    left outer join I_CharcAttribSelectedCodeSet as Code on  Code.SelectedCodeSetPlant = Char.InspectionSpecificationPlant
  //                                                         and Code.SelectedCodeSet      = Char.SelectedCodeSet
  //                                                         and Code.Language             = $session.system_language
  //
  //    left outer join zqm_t_ilot_i                 as Item on  Item.reportnumber     = Char.InspectionLot
  //                                                         and Item.reportnumberitem = Char.InspectionCharacteristic
  //
  //  association to parent ZQM_BA_ILOT_H as _Header on $projection.Uniqueid = _Header.Uniqueid
  //{
  //  key Header.uniqueid                                        as Uniqueid,
  //      Char.InspectionLot                                     as ReportNumber,
  //      Char.InspectionCharacteristic                          as ReportNumberItem,
  //      Char.InspPlanOperationInternalID,
  //      /////
  //      concat('Parameter',':')                                as Parameter_,
  //
  //      /* --- CodeSet / Range Text --- */
  //      case
  //        when Char.InspSpecLowerLimit is initial or Char.InspSpecLowerLimit is null
  //          then concat(cast(cast(Char.InspSpecUpperLimit as abap.dec(16,3)) as abap.char(22)), ' - Max')
  //        when Char.InspSpecUpperLimit is initial or Char.InspSpecUpperLimit is null
  //          then concat(cast(cast(Char.InspSpecLowerLimit as abap.dec(16,3)) as abap.char(22)), ' - Min')
  //        else
  //          concat(
  //            concat(cast(cast(Char.InspSpecLowerLimit as abap.dec(16,3)) as abap.char(22)), ' - '),
  //            cast(cast(Char.InspSpecUpperLimit as abap.dec(16,3)) as abap.char(22))
  //          )
  //      end                                                    as SelectedCodeSetText,
  //
  //      /* --- Specification Labels --- */
  //      @EndUserText.label: 'Specification'
  //      concat('Parameter:', Char.InspectionSpecificationText) as Specification,
  //
  //      case when Char.InspSpecTargetValue is initial or Char.InspSpecTargetValue is null
  //           then '-'
  //           else cast(cast(Char.InspSpecTargetValue as abap.dec(16,3)) as abap.char(22))
  //      end                                                    as InspSpecTargetValue,
  //
  //      case when Char.InspSpecUpperLimit is initial or Char.InspSpecUpperLimit is null
  //           then '-'
  //           else cast(cast(Char.InspSpecUpperLimit as abap.dec(16,3)) as abap.char(22))
  //      end                                                    as InspSpecUpperLimit,
  //
  //      case when Char.InspSpecLowerLimit is initial or Char.InspSpecLowerLimit is null
  //           then '-'
  //           else cast(cast(Char.InspSpecLowerLimit as abap.dec(16,3)) as abap.char(22))
  //      end                                                    as InspSpecLowerLimit,
  //
  //      ////
  //
  //      /* --- Range Labels --- */
  //      concat('Max - ',
  //             case when Char.InspSpecUpperLimit is initial or Char.InspSpecUpperLimit is null
  //                  then ''
  //                  else cast(cast(Char.InspSpecUpperLimit as abap.dec(16,3)) as abap.char(22))
  //             end)                                            as lab_max,
  //
  //      concat('Min - ',
  //             case when Char.InspSpecLowerLimit is initial or Char.InspSpecLowerLimit is null
  //                  then ''
  //                  else cast(cast(Char.InspSpecLowerLimit as abap.dec(16,3)) as abap.char(22))
  //             end)                                            as lab_min,
  //
  //      Item.specificationtext                                 as Specificationtext,
  //      Item.result1val1                                       as Result1val1,
  //      Item.result1val2                                       as Result1val2,
  //      Item.result1val3                                       as Result1val3,
  //      Item.result1val4                                       as Result1val4,
  //      Item.result1val5                                       as Result1val5,
  //      Item.result1val6                                       as Result1val6,
  //      Item.result1val7                                       as Result1val7,
  //      Item.result1val8                                       as Result1val8,
  //      Item.result1val9                                       as Result1val9,
  //      Item.result1val10                                      as Result1val10,
  //      Item.result1val11                                      as Result1val11,
  //      Item.result2val1                                       as Result2val1,
  //      Item.result2val2                                       as Result2val2,
  //      Item.result2val3                                       as Result2val3,
  //      Item.result2val4                                       as Result2val4,
  //      Item.result2val5                                       as Result2val5,
  //      Item.result2val6                                       as Result2val6,
  //      Item.result2val7                                       as Result2val7,
  //      Item.result2val8                                       as Result2val8,
  //      Item.result2val9                                       as Result2val9,
  //      Item.result2val10                                      as Result2val10,
  //      Item.result2val11                                      as Result2val11,
  //      cast( 'Result 1' as abap.char( 10 ) )                  as Resulttxt1,
  //      cast( 'Result 2' as abap.char( 10 ) )                  as Resulttxt2,
  //      cast( 'Result 3' as abap.char( 10 ) )                  as Resulttxt3,
  //      cast( 'Result 4' as abap.char( 10 ) )                  as Resulttxt4,
  //      cast( 'Result 5' as abap.char( 10 ) )                  as Resulttxt5,
  //      cast( 'Result 6' as abap.char( 10 ) )                  as Resulttxt6,
  //      cast( 'Result 7' as abap.char( 10 ) )                  as Resulttxt7,
  //      cast( 'Result 8' as abap.char( 10 ) )                  as Resulttxt8,
  //      cast( 'Result 9' as abap.char( 10 ) )                  as Resulttxt9,
  //      cast( 'Result 10' as abap.char( 10 ) )                 as Resulttxt10,
  //      cast( 'Result 11' as abap.char( 10 ) )                 as Resulttxt11,
  //      Item.createdby                                         as Createdby,
  //      Item.createdon                                         as Createdon,
  //      Item.changedby                                         as Changedby,
  //      Item.changedon                                         as Changedon,
  //      _Header
  //}

  as select from    zqm_t_ilot_i                 as Item

    left outer join I_InspectionCharacteristic   as Char on Char.InspectionLot = Item.reportnumber

    left outer join I_CharcAttribSelectedCodeSet as Code on  Code.SelectedCodeSetPlant = Char.InspectionSpecificationPlant
                                                         and Code.SelectedCodeSet      = Char.SelectedCodeSet
                                                         and Code.Language             = $session.system_language

  association to parent ZQM_BA_ILOT_H as _Header on $projection.Uniqueid = _Header.Uniqueid
{
  key Item.uniqueid                                          as Uniqueid,
      Char.InspectionLot                                     as ReportNumber,
      Char.InspectionCharacteristic                          as ReportNumberItem,
      Char.InspPlanOperationInternalID,
      /////
      concat('Parameter',':')                                 as Parameter_,
 
      /* --- CodeSet / Range Text --- */
      case
        when Char.InspSpecLowerLimit is initial or Char.InspSpecLowerLimit is null
          then concat(cast(cast(Char.InspSpecUpperLimit as abap.dec(16,3)) as abap.char(22)), ' - Max')
        when Char.InspSpecUpperLimit is initial or Char.InspSpecUpperLimit is null
          then concat(cast(cast(Char.InspSpecLowerLimit as abap.dec(16,3)) as abap.char(22)), ' - Min')
        else
          concat(
            concat(cast(cast(Char.InspSpecLowerLimit as abap.dec(16,3)) as abap.char(22)), ' - '),
            cast(cast(Char.InspSpecUpperLimit as abap.dec(16,3)) as abap.char(22))
          )
      end                                                    as SelectedCodeSetText,

      /* --- Specification Labels --- */
      @EndUserText.label: 'Specification'
      concat('Parameter:', Char.InspectionSpecificationText) as Specification,

      case when Char.InspSpecTargetValue is initial or Char.InspSpecTargetValue is null
           then '-'
           else cast(cast(Char.InspSpecTargetValue as abap.dec(16,3)) as abap.char(22))
      end                                                    as InspSpecTargetValue,

      case when Char.InspSpecUpperLimit is initial or Char.InspSpecUpperLimit is null
           then '-'
           else cast(cast(Char.InspSpecUpperLimit as abap.dec(16,3)) as abap.char(22))
      end                                                    as InspSpecUpperLimit,

      case when Char.InspSpecLowerLimit is initial or Char.InspSpecLowerLimit is null
           then '-'
           else cast(cast(Char.InspSpecLowerLimit as abap.dec(16,3)) as abap.char(22))
      end                                                    as InspSpecLowerLimit,

      ////

      /* --- Range Labels --- */
      concat('Max - ',
             case when Char.InspSpecUpperLimit is initial or Char.InspSpecUpperLimit is null
                  then ''
                  else cast(cast(Char.InspSpecUpperLimit as abap.dec(16,3)) as abap.char(22))
             end)                                            as lab_max,

      concat('Min - ',
             case when Char.InspSpecLowerLimit is initial or Char.InspSpecLowerLimit is null
                  then ''
                  else cast(cast(Char.InspSpecLowerLimit as abap.dec(16,3)) as abap.char(22))
             end)                                            as lab_min,

      Item.specificationtext                                 as Specificationtext,
      Item.result1val1                                       as Result1val1,
      Item.result1val2                                       as Result1val2,
      Item.result1val3                                       as Result1val3,
      Item.result1val4                                       as Result1val4,
      Item.result1val5                                       as Result1val5,
      Item.result1val6                                       as Result1val6,
      Item.result1val7                                       as Result1val7,
      Item.result1val8                                       as Result1val8,
      Item.result1val9                                       as Result1val9,
      Item.result1val10                                      as Result1val10,
      Item.result1val11                                      as Result1val11,
      Item.result2val1                                       as Result2val1,
      Item.result2val2                                       as Result2val2,
      Item.result2val3                                       as Result2val3,
      Item.result2val4                                       as Result2val4,
      Item.result2val5                                       as Result2val5,
      Item.result2val6                                       as Result2val6,
      Item.result2val7                                       as Result2val7,
      Item.result2val8                                       as Result2val8,
      Item.result2val9                                       as Result2val9,
      Item.result2val10                                      as Result2val10,
      Item.result2val11                                      as Result2val11,
      cast( 'Result 1' as abap.char( 10 ) )                  as Resulttxt1,
      cast( 'Result 2' as abap.char( 10 ) )                  as Resulttxt2,
      cast( 'Result 3' as abap.char( 10 ) )                  as Resulttxt3,
      cast( 'Result 4' as abap.char( 10 ) )                  as Resulttxt4,
      cast( 'Result 5' as abap.char( 10 ) )                  as Resulttxt5,
      cast( 'Result 6' as abap.char( 10 ) )                  as Resulttxt6,
      cast( 'Result 7' as abap.char( 10 ) )                  as Resulttxt7,
      cast( 'Result 8' as abap.char( 10 ) )                  as Resulttxt8,
      cast( 'Result 9' as abap.char( 10 ) )                  as Resulttxt9,
      cast( 'Result 10' as abap.char( 10 ) )                 as Resulttxt10,
      cast( 'Result 11' as abap.char( 10 ) )                 as Resulttxt11,
      Item.createdby                                         as Createdby,
      Item.createdon                                         as Createdon,
      Item.changedby                                         as Changedby,
      Item.changedon                                         as Changedon,
      _Header
}
