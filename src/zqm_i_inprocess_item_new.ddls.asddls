@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Inprocess Item Interface view'
@Metadata.ignorePropagatedAnnotations: true



define view entity ZQM_I_Inprocess_item_NEW as select from zqm_t_inpr_hd as A


left outer join I_InspPlnMatlAssgmtVersion_2 as inspPlan on inspPlan.Material = A.material and inspPlan.Plant = A.plant and inspPlan.IsDeleted <> 'X'
left outer join   I_InspPlanOperationVersion_2 as Opr     on Opr.InspectionPlanGroup = inspPlan.InspectionPlanGroup  
and Opr.IsDeleted <> 'X' 
left outer join I_InspPlanOpCharcVersion_2 as Char on Char.InspectionPlanGroup = Opr.InspectionPlanGroup
                                                    and Char.BOOOperationInternalID = Opr.BOOOperationInternalID
// as a
//
//left outer join   I_InspectionLot              as InspLot on a.inspectionlot = InspLot.InspectionLot
//    left outer join   I_InspPlanOperationVersion_2 as Opr     on InspLot.BillOfOperationsGroup = Opr.InspectionPlanGroup
//    
//    and Opr.BOOOperationInternalID = '00000005'
//  //  inner join I_InspPlanOpCharcVersion_2 as unique on Opr.BOOOperationInternalID = unique.BOOOperationInternalID
//  left outer join I_InspectionCharacteristic   as Char on Char.InspectionLot = a.inspectionlot
//                                                           and Char.InspPlanOperationInternalID =   '00000005'
//    left outer join I_CharcAttribSelectedCodeSet as Code on  Code.SelectedCodeSetPlant = Char.InspectionSpecificationPlant
//                                                         and Code.SelectedCodeSet      = Char.SelectedCodeSet
//                                                         and Code.Language             = $session.system_language
left outer join zqm_t_inpr_it as item on item.cuuid = A.cuuid and
 item.boooperationinternalid  =  Opr.BOOOperationInternalID and
  item.inspectionlot            =  A.inspectionlot and
  item.inspectionlotitem = Char.BOOCharacteristic and
  item.boocharacteristicversion =  Char.BOOCharacteristicVersion and
  item.inspectionplangroup      = Opr.InspectionPlanGroup


    association to parent ZQM_I_Inprocess_NEW

 as _HDR on $projection.Cuuid = _HDR.Cuuid                                                       
{

    
  key A.cuuid                                         as Cuuid,
  key Char.BOOOperationInternalID                     as Boooperationinternalid,
  key Char.BOOCharacteristic                          as Inspectionlotitem,
  key A.inspectionlot                                 as Inspectionlot,
  key Char.BOOCharacteristicVersion                   as Boocharacteristicversion,
  key Char.InspectionPlanGroup                        as Inspectionplangroup,
    
        cast( 'Result 1' as abap.char( 10 ) )                as Resulttxt1,
    cast( 'Result 2' as abap.char( 10 ) )                  as Resulttxt2,
    cast( 'Result 3' as abap.char( 10 ) )                  as Resulttxt3,
    cast( 'Result 4' as abap.char( 10 ) )                  as Resulttxt4,
   cast( 'Result 5' as abap.char( 10 ) )                   as Resulttxt5,
   cast( 'Result 6' as abap.char( 10 ) )                  as  Resulttxt6,
   cast( 'Result 7' as abap.char( 10 ) )                  as  Resulttxt7,
   cast( 'Result 8' as abap.char( 10 ) )                  as  Resulttxt8,
 cast( 'Result 9' as abap.char( 10 ) )                   as  Resulttxt9, 
 cast( 'Result 10' as abap.char( 10 ) )                  as    Resulttxt10, 
 cast( 'Result 11' as abap.char( 10 ) )                  as    Resulttxt11, 
 cast( 'Result 12' as abap.char( 10 ) )                  as    Resulttxt12, 
 cast( 'Result 13' as abap.char( 10 ) )                   as   Resulttxt13, 
 cast( 'Result 14' as abap.char( 10 ) )                  as    Resulttxt14, 
 cast( 'Result 15' as abap.char( 10 ) )                  as    Resulttxt15, 
 cast( 'Result 16' as abap.char( 10 ) )                  as    Resulttxt16, 
    
    case
when Char.InspSpecTargetValue is initial
or Char.InspSpecTargetValue is null
then '-'
else cast( cast( Char.InspSpecTargetValue as abap.dec(16,3) ) as abap.char(22) )
end as InspSpecTargetValue,

case
when Char.InspSpecUpperLimit is initial
or Char.InspSpecUpperLimit is null
then '-'
else cast( cast( Char.InspSpecUpperLimit as abap.dec(16,3) ) as abap.char(22) )
end as InspSpecUpperLimit,

case
when Char.InspSpecLowerLimit is initial
or Char.InspSpecLowerLimit is null
then '-'
else cast( cast( Char.InspSpecLowerLimit as abap.dec(16,3) ) as abap.char(22) )
end as InspSpecLowerLimit,

Char.InspectionSpecificationText as InspectionSpecification,

case
when ( Char.InspSpecUpperLimit is initial or Char.InspSpecUpperLimit is null )
and ( Char.InspSpecLowerLimit is initial or Char.InspSpecLowerLimit is null )
then concat( Char.InspectionSpecification, '' )

else case
when Char.InspSpecLowerLimit is initial
or Char.InspSpecLowerLimit is null
then concat(
concat( cast( cast( Char.InspSpecUpperLimit as abap.dec(16,3) ) as abap.char(22) ), '-' ),
' Max'
)

when Char.InspSpecUpperLimit is initial
or Char.InspSpecUpperLimit is null
then concat(
concat( cast( cast( Char.InspSpecLowerLimit as abap.dec(16,3) ) as abap.char(22) ), '-' ),
' Min'
)

else concat(
concat( cast( cast( Char.InspSpecLowerLimit as abap.dec(16,3) ) as abap.char(22) ), '-' ),
cast( cast( Char.InspSpecUpperLimit as abap.dec(16,3) ) as abap.char(22) )
)
end
end as Specification,


    item.spc as Spc,
//    item.specification as Specification,
    item.selectedcodesettext as Selectedcodesettext,
     item.samples, 
item.observed ,
item.threaddetails, 
    
//    item.result1 as Result1,
//    item.result2 as Result2,
//    item.result3 as Result3,
//    item.result4 as Result4,
//    item.result5 as Result5,
//    item.result6 as Result6,
//    item.result7 as Result7,
//    item.result8 as Result8,
//    item.result9 as Result9,
//    item.result10 as Result10,
//    item.result11 as Result11,
//    item.result12 as Result12,
//    item.result13 as Result13,
//    item.result14 as Result14,
//    item.result15 as Result15,
//    item.result16 as Result16,
//    item.resultval1 as Resultval1,
//    item.resultval2 as Resultval2,
//    item.resultval3 as Resultval3,
//    item.resultval4 as Resultval4,
//    item.resultval5 as Resultval5,
//    item.resultval6 as Resultval6,
//    item.resultval7 as Resultval7,
//    item.resultval8 as Resultval8,
//    item.resultval9 as Resultval9,
//    item.resultval10 as Resultval10,
//    item.resultval11 as Resultval11,
//    item.resultval12 as Resultval12,
//    item.resultval13 as Resultval13,
//    item.resultval14 as Resultval14,
//    item.resultval15 as Resultval15,
//    item.resultval16 as Resultval16,
//
//    item.res_mark1_ind as ResMark1Ind,
//    item.res_mark2_ind as ResMark2Ind,
//    item.res_mark3_ind as ResMark3Ind,
//    item.res_mark4_ind as ResMark4Ind,
//    item.res_mark5_ind as ResMark5Ind,
//    item.res_mark6_ind as ResMark6Ind,
//    item.res_mark7_ind as ResMark7Ind,
//    item.res_mark8_ind as ResMark8Ind,
//    item.res_mark9_ind as ResMark9Ind,
//    item.res_mark10_ind as ResMark10Ind,
//    item.res_mark11_ind as ResMark11Ind,
//    item.res_mark12_ind as ResMark12Ind,
//    item.res_mark13_ind as ResMark13Ind,
//    item.res_mark14_ind as ResMark14Ind,
//    item.res_mark15_ind as ResMark15Ind,
//    item.res_mark16_ind as ResMark16Ind,
//    item.res_mark1 as ResMark1,
//    item.res_mark2 as ResMark2,
//    item.res_mark3 as ResMark3,
//    item.res_mark4 as ResMark4,
//    item.res_mark5 as ResMark5,
//    item.res_mark6 as ResMark6,
//    item.res_mark7 as ResMark7,
//    item.res_mark8 as ResMark8,
//    item.res_mark9 as ResMark9,
//    item.res_mark10 as ResMark10,
//    item.res_mark11 as ResMark11,
//    item.remark as Remark,
//   
//case 
//  when item.result1 is not initial and item.result1 > '0' and item.result1 < '999999999'
//  then cast( cast( item.result1 as abap.dec(18,6) ) * cast( '0.039' as abap.dec(18,6) ) as abap.char(40) )
//  else cast( '' as abap.char(40) )
//end as result1mm,
//
//case 
//  when item.result2 is not initial and item.result2 > '0' and item.result2 < '999999999'
//  then cast( cast( item.result2 as abap.dec(18,6) ) * cast( '0.039' as abap.dec(18,6) ) as abap.char(40) )
//  else cast( '' as abap.char(40) )
//end as result2mm,
//
//case 
//  when item.result3 is not initial and item.result3 > '0' and item.result3 < '999999999'
//  then cast( cast( item.result3 as abap.dec(18,6) ) * cast( '0.039' as abap.dec(18,6) ) as abap.char(40) )
//  else cast( '' as abap.char(40) )
//end as result3mm,
//
//case 
//  when item.result4 is not initial and item.result4 > '0' and item.result4 < '999999999'
//  then cast( cast( item.result4 as abap.dec(18,6) ) * cast( '0.039' as abap.dec(18,6) ) as abap.char(40) )
//  else cast( '' as abap.char(40) )
//end as result4mm,
//
//case 
//  when item.result5 is not initial and item.result5 > '0' and item.result5 < '999999999'
//  then cast( cast( item.result5 as abap.dec(18,6) ) * cast( '0.039' as abap.dec(18,6) ) as abap.char(40) )
//  else cast( '' as abap.char(40) )
//end as result5mm,
//
//case 
//  when item.result6 is not initial and item.result6 > '0' and item.result6 < '999999999'
//  then cast( cast( item.result6 as abap.dec(18,6) ) * cast( '0.039' as abap.dec(18,6) ) as abap.char(40) )
//  else cast( '' as abap.char(40) )
//end as result6mm,
//
//case 
//  when item.result7 is not initial and item.result7 > '0' and item.result7 < '999999999'
//  then cast( cast( item.result7 as abap.dec(18,6) ) * cast( '0.039' as abap.dec(18,6) ) as abap.char(40) )
//  else cast( '' as abap.char(40) )
//end as result7mm,
//
//case 
//  when item.result8 is not initial and item.result8 > '0' and item.result8 < '999999999'
//  then cast( cast( item.result8 as abap.dec(18,6) ) * cast( '0.039' as abap.dec(18,6) ) as abap.char(40) )
//  else cast( '' as abap.char(40) )
//end as result8mm,
//
//case 
//  when item.result9 is not initial and item.result9 > '0' and item.result9 < '999999999'
//  then cast( cast( item.result9 as abap.dec(18,6) ) * cast( '0.039' as abap.dec(18,6) ) as abap.char(40) )
//  else cast( '' as abap.char(40) )
//end as result9mm,
//
//case 
//  when item.result10 is not initial and item.result10 > '0' and item.result10 < '999999999'
//  then cast( cast( item.result10 as abap.dec(18,6) ) * cast( '0.039' as abap.dec(18,6) ) as abap.char(40) )
//  else cast( '' as abap.char(40) )
//end as result10mm,
//
//case 
//  when item.result11 is not initial and item.result11 > '0' and item.result11 < '999999999'
//  then cast( cast( item.result11 as abap.dec(18,6) ) * cast( '0.039' as abap.dec(18,6) ) as abap.char(40) )
//  else cast( '' as abap.char(40) )
//end as result11mm,
//
//case 
//  when item.result12 is not initial and item.result12 > '0' and item.result12 < '999999999'
//  then cast( cast( item.result12 as abap.dec(18,6) ) * cast( '0.039' as abap.dec(18,6) ) as abap.char(40) )
//  else cast( '' as abap.char(40) )
//end as result12mm,
//
//case 
//  when item.result13 is not initial and item.result13 > '0' and item.result13 < '999999999'
//  then cast( cast( item.result13 as abap.dec(18,6) ) * cast( '0.039' as abap.dec(18,6) ) as abap.char(40) )
//  else cast( '' as abap.char(40) )
//end as result13mm,
//
//case 
//  when item.result14 is not initial and item.result14 > '0' and item.result14 < '999999999'
//  then cast( cast( item.result14 as abap.dec(18,6) ) * cast( '0.039' as abap.dec(18,6) ) as abap.char(40) )
//  else cast( '' as abap.char(40) )
//end as result14mm,
//
//case 
//  when item.result15 is not initial and item.result15 > '0' and item.result15 < '999999999'
//  then cast( cast( item.result15 as abap.dec(18,6) ) * cast( '0.039' as abap.dec(18,6) ) as abap.char(40) )
//  else cast( '' as abap.char(40) )
//end as result15mm,
//
//case 
//  when item.result16 is not initial and item.result16 > '0' and item.result16 < '999999999'
//  then cast( cast( item.result16 as abap.dec(18,6) ) * cast( '0.039' as abap.dec(18,6) ) as abap.char(40) )
//  else cast( '' as abap.char(40) )
//end as result16mm,

    _HDR                        
}                               

