@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Line Inspection Specifications Basic View'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZQM_BA_LINSP_SPC
  as select distinct  from ZQM_BA_LINSP_DT            as DT
    
     left outer  join            I_InspPlanOpCharcVersion_2 as CHAR on CHAR.BOOOperationInternalID = DT.BOOOperationInternalID 
 
                                                 and CHAR.InspectionPlanGroup    = DT.InspectionPlanGroup
                                              
                                                 
                                                 
    left outer join       zqm_t_linsp_spc            as SPC  on  DT.Cuuid     = SPC.cuuid
                                                             and DT.cuuiddate = SPC.cuuiddate
                                                             and DT.Inspectionlot = SPC.inspectionlot 
                                                             and DT.InspectionPlanGroup = SPC.inspectionplangroup
                                                             and DT.BOOOperationInternalID = SPC.boooperationinternalid
                                                              and SPC.inspectionlotitem = CHAR.BOOCharacteristic 
  association to parent ZQM_BA_LINSP_DT  as _DT  on  $projection.Cuuid                  = _DT.Cuuid
                                                 and $projection.cuuiddate              = _DT.cuuiddate
                                                 and $projection.Inspectionlot          = _DT.Inspectionlot
                                                 and $projection.InspectionPlanGroup    = _DT.InspectionPlanGroup
                                                 and $projection.BOOOperationInternalID = _DT.BOOOperationInternalID

  association to ZQM_BA_LINSP_HDR        as _HDR on  $projection.Cuuid = _HDR.Cuuid

  composition [0..*] of ZQM_BA_LINSP_RES as _RES

{
  key     DT.Cuuid,
  key     DT.cuuiddate,
  key     DT.Inspectionlot,
  key     DT.InspectionPlanGroup,
  key     DT.BOOOperationInternalID,

  key     CHAR.BOOCharacteristic           as InspectionLotItem,
  key     CHAR.BOOCharacteristicVersion,

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

          SPC.result1                      as Result1,
          SPC.result2                      as Result2,
          SPC.result3                      as Result3,
          SPC.result4                      as Result4,
          SPC.result5                      as Result5,
          SPC.result6                      as Result6,
          SPC.result7                      as Result7,
          SPC.result8                      as Result8,
          SPC.result9                      as Result9,
          SPC.result10                     as Result10,
          SPC.result11                     as Result11,
          SPC.result12                     as Result12,
          SPC.resultval1                   as Resultval1,
          SPC.resultval2                   as Resultval2,
          SPC.resultval3                   as Resultval3,
          SPC.resultval4                   as Resultval4,
          SPC.resultval5                   as Resultval5,
          SPC.resultval6                   as Resultval6,
          SPC.resultval7                   as Resultval7,
          SPC.resultval8                   as Resultval8,
          SPC.resultval9                   as Resultval9,
          SPC.resultval10                  as Resultval10,
          SPC.resultval11                  as Resultval11,
          SPC.resultval12                  as Resultval12,
          SPC.resulttxt1                   as Resulttxt1,
          SPC.resulttxt2                   as Resulttxt2,
          SPC.resulttxt3                   as Resulttxt3,
          SPC.resulttxt4                   as Resulttxt4,
          SPC.resulttxt5                   as Resulttxt5,
          SPC.resulttxt6                   as Resulttxt6,
          SPC.resulttxt7                   as Resulttxt7,
          SPC.resulttxt8                   as Resulttxt8,
          SPC.resulttxt9                   as Resulttxt9,
          SPC.resulttxt10                  as Resulttxt10,
          SPC.resulttxt11                  as Resulttxt11,
          SPC.resulttxt12                  as Resulttxt12,

          /* Associations */
          _DT,
          _RES,
          _HDR
}
