@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Line Inspection Specifications Basic View'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZQM_PDIR_SPECIFICATION_LIST
as select distinct from ZQM_PDIR_OPERTION_LIST as DT

inner join I_InspPlanOpCharcVersion_2 as CHAR on DT.BOOOperationInternalID = CHAR.BOOOperationInternalID

left outer join zqm_t_pdir_spc as SPC on DT.Cuuid = SPC.cuuid
// and DT.cuuiddate = SPC.cuuiddate
 and SPC.inspectionlot = DT.Inspectionlot
 and SPC.inspectionplangroup = DT.InspectionPlanGroup
 and SPC.boooperationinternalid = DT.BOOOperationInternalID
 and SPC.inspectionlotitem = CHAR.BOOCharacteristic
 and SPC.boocharacteristicversion = CHAR.BOOCharacteristicVersion
association to parent ZQM_PDIR_OPERTION_LIST as _OperationItem on $projection.Cuuid = _OperationItem.Cuuid
//and $projection.cuuiddate = _DT.cuuiddate
and $projection.Inspectionlot = _OperationItem.Inspectionlot
and $projection.InspectionPlanGroup = _OperationItem.InspectionPlanGroup
and $projection.BOOOperationInternalID = _OperationItem.BOOOperationInternalID

association to ZQM_BA_PDIRHeader as _HDR on $projection.Cuuid = _HDR.Cuuid


{
key DT.Cuuid,
//key DT.cuuiddate,
key DT.Inspectionlot,
key DT.InspectionPlanGroup,
key DT.BOOOperationInternalID,

key CHAR.BOOCharacteristic as InspectionLotItem,
key CHAR.BOOCharacteristicVersion,

SPC.spc,

case
when CHAR.InspSpecTargetValue is initial
or CHAR.InspSpecTargetValue is null
then '-'
else cast( cast( CHAR.InspSpecTargetValue as abap.dec(16,3) ) as abap.char(22) )
end as InspSpecTargetValue,

case
when CHAR.InspSpecUpperLimit is initial
or CHAR.InspSpecUpperLimit is null
then '-'
else cast( cast( CHAR.InspSpecUpperLimit as abap.dec(16,3) ) as abap.char(22) )
end as InspSpecUpperLimit,

case
when CHAR.InspSpecLowerLimit is initial
or CHAR.InspSpecLowerLimit is null
then '-'
else cast( cast( CHAR.InspSpecLowerLimit as abap.dec(16,3) ) as abap.char(22) )
end as InspSpecLowerLimit,

CHAR.InspectionSpecificationText as InspectionSpecification,

case
when ( CHAR.InspSpecUpperLimit is initial or CHAR.InspSpecUpperLimit is null )
and ( CHAR.InspSpecLowerLimit is initial or CHAR.InspSpecLowerLimit is null )
then concat( CHAR.InspectionSpecification, '' )

else case
when CHAR.InspSpecLowerLimit is initial
or CHAR.InspSpecLowerLimit is null
then concat(
concat( cast( cast( CHAR.InspSpecUpperLimit as abap.dec(16,3) ) as abap.char(22) ), '-' ),
' Max'
)

when CHAR.InspSpecUpperLimit is initial
or CHAR.InspSpecUpperLimit is null
then concat(
concat( cast( cast( CHAR.InspSpecLowerLimit as abap.dec(16,3) ) as abap.char(22) ), '-' ),
' Min'
)

else concat(
concat( cast( cast( CHAR.InspSpecLowerLimit as abap.dec(16,3) ) as abap.char(22) ), '-' ),
cast( cast( CHAR.InspSpecUpperLimit as abap.dec(16,3) ) as abap.char(22) )
)
end
end as Specification,

SPC.result1 as Result1,
SPC.result2 as Result2,
SPC.result3 as Result3,
SPC.result4 as Result4,
SPC.result5 as Result5,
SPC.result6 as Result6,
SPC.result7 as Result7,
SPC.result8 as Result8,
SPC.result9 as Result9,
SPC.result10 as Result10,
SPC.result11 as Result11,
SPC.result12 as Result12,
SPC.result13 as Result13,
SPC.result14 as Result14,
SPC.result15 as Result15,
SPC.result16 as Result16,
SPC.resultval1 as Resultval1,
SPC.resultval2 as Resultval2,
SPC.resultval3 as Resultval3,
SPC.resultval4 as Resultval4,
SPC.resultval5 as Resultval5,
SPC.resultval6 as Resultval6,
SPC.resultval7 as Resultval7,
SPC.resultval8 as Resultval8,
SPC.resultval9 as Resultval9,
SPC.resultval10 as Resultval10,
SPC.resultval11 as Resultval11,
SPC.resultval12 as Resultval12,
SPC.resultval13 as Resultval13,
SPC.resultval14 as Resultval14,
SPC.resultval15 as Resultval15,
SPC.resultval16 as Resultval16,
SPC.resulttxt1 as Resulttxt1,
SPC.resulttxt2 as Resulttxt2,
SPC.resulttxt3 as Resulttxt3,
SPC.resulttxt4 as Resulttxt4,
SPC.resulttxt5 as Resulttxt5,
SPC.resulttxt6 as Resulttxt6,
SPC.resulttxt7 as Resulttxt7,
SPC.resulttxt8 as Resulttxt8,
SPC.resulttxt9 as Resulttxt9,
SPC.resulttxt10 as Resulttxt10,
SPC.resulttxt11 as Resulttxt11,
SPC.resulttxt12 as Resulttxt12,
SPC.resulttxt13 as Resulttxt13,
SPC.resulttxt14 as Resulttxt14,
SPC.resulttxt15 as Resulttxt15,
SPC.resulttxt16 as Resulttxt16,
SPC.res_mark1_ind ,
SPC.res_mark2_ind ,
SPC.res_mark3_ind ,
SPC.res_mark4_ind ,
SPC.res_mark5_ind ,
SPC.res_mark6_ind ,
SPC.res_mark7_ind ,
SPC.res_mark8_ind ,
SPC.res_mark9_ind ,
SPC.res_mark10_ind ,
SPC.res_mark11_ind ,
SPC.res_mark12_ind ,
SPC.res_mark13_ind ,
SPC.res_mark14_ind ,
SPC.res_mark15_ind ,
SPC.res_mark16_ind ,
SPC.res_mark1,
SPC.res_mark2,
SPC.res_mark3,
SPC.res_mark4,
SPC.res_mark5,
SPC.res_mark6,
SPC.res_mark7,
SPC.res_mark8,
SPC.res_mark9,
SPC.res_mark10,
SPC.res_mark11,
SPC.remark,

/* Associations */
_OperationItem,
// _RES,
_HDR
}
