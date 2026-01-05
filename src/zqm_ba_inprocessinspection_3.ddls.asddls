@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View for Inprocess Inspection Lot Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZQM_BA_InprocessInspection_3
  as select from    ZQM_BA_InprocessInspection_2 as inspoper

    left outer join I_InspPlanOpCharcVersion_2   as planopchar on inspoper.BOOOperationInternalID = planopchar.BOOOperationInternalID

    left outer join zqm_t_inpr_ins_2             as item       on item.cuuid = inspoper.Cuuid
                                                                        and item.inspectionlot          = inspoper.Inspectionlot
                                                                        and item.inspectionplangroup    = planopchar.InspectionPlanGroup
                                                                        and item.boooperationinternalid = planopchar.BOOOperationInternalID
      and item.boocharacteristicversion = planopchar.BOOCharacteristicVersion
                                                                                                                                           
                                                                        
  association to parent ZQM_BA_InprocessInspection_2 as _item_operation on  $projection.Cuuid                  = _item_operation.Cuuid
                                                                        and $projection.Inspectionlot          = _item_operation.Inspectionlot
                                                                        and $projection.InspectionPlanGroup    = _item_operation.InspectionPlanGroup
                                                                        and $projection.BOOOperationInternalID = _item_operation.BOOOperationInternalID
////// composition [0..*] of ZQM_BA_InprocessInspection_4 as _item_calculation

  association to ZQM_BA_InprocessInspection_1        as _Header         on  $projection.Cuuid = _Header.cuuid


{
  key     inspoper.Cuuid                                                                         as Cuuid,
  key     inspoper.Inspectionlot                                                                 as Inspectionlot,
  key     inspoper.InspectionPlanGroup,
  key     inspoper.BOOOperationInternalID,
  key     planopchar.BOOCharacteristic                                                           as InspLotItem,
  key     planopchar.BOOCharacteristicVersion,

          case when planopchar.InspSpecUpperLimit is initial  or planopchar.InspSpecUpperLimit is null
          then '-'
          else
          cast(cast(planopchar.InspSpecUpperLimit as abap.dec( 16, 3 )) as abap.char( 22 )) end  as InspSpecUpperLimit,

          case when planopchar.InspSpecLowerLimit is initial  or planopchar.InspSpecLowerLimit is null
          then '-'
          else
           cast(cast(planopchar.InspSpecLowerLimit as abap.dec( 16, 3 )) as abap.char( 22 )) end as InspSpecLowerLimit,

          planopchar.InspectionSpecification,
          case when  ( planopchar.InspSpecUpperLimit is initial or planopchar.InspSpecUpperLimit is null )
                 and ( planopchar.InspSpecLowerLimit is initial or planopchar.InspSpecLowerLimit is null )
          then concat( planopchar.InspectionSpecification,'')
          else

          case when  planopchar.InspSpecLowerLimit is initial  or planopchar.InspSpecLowerLimit is null
          then

          concat( concat(cast(cast(planopchar.InspSpecUpperLimit as abap.dec( 16, 3 )) as abap.char( 22 )),'-'),

          ' Max')
          when
          planopchar.InspSpecUpperLimit is initial  or planopchar.InspSpecUpperLimit is null
          then
          concat( concat(cast(cast(planopchar.InspSpecLowerLimit as abap.dec( 16, 3 )) as abap.char( 22 )),'-'),

          'Min')
          else


          concat( concat(cast(cast(planopchar.InspSpecLowerLimit as abap.dec( 16, 3 )) as abap.char( 22 )),'-'),

          cast(cast(planopchar.InspSpecUpperLimit as abap.dec( 16, 3 ))   as abap.char( 22 )))

          end

          end                                                                                    as Specification,
          item.ind                                                                               as Ind,
          item.time                                                                              as Time,
          item.res1                                                                              as Res1,
          item.res2                                                                              as Res2,
          item.res3                                                                              as Res3,
          item.res4                                                                              as Res4,
          item.res5                                                                              as Res5,
          item.res6                                                                              as Res6,
          item.res7                                                                              as Res7,
          item.res8                                                                              as Res8,
          item.res9                                                                              as Res9,
          item.res10                                                                             as Res10,
          item.res11                                                                             as Res11,
          item.res12                                                                             as Res12,
          item.res13                                                                             as Res13,
          item.res14                                                                             as Res14,
          item.res15                                                                             as Res15,
          item.res16                                                                             as Res16,
          item.res17                                                                             as Res17,
          item.res18                                                                             as Res18,
          item.res19                                                                             as Res19,
          item.res20                                                                             as Res20,
          item.res21                                                                             as Res21,
          item.res22                                                                             as Res22,
          item.res23                                                                             as Res23,
          item.res24                                                                             as Res24,
          item.res25                                                                             as Res25,
          item.othertext1                                                                        as Othertext1,
          item.othertext2                                                                        as Othertext2,
          item.shift                                                                             as Shift,
          item.shif_date                                                                         as Shift_Date,
          item.rec_time1                                                                         as Recording_Time1,
          item.rec_time2                                                                         as Recording_Time2,
          item.rec_time3                                                                         as Recording_Time3,
          item.rec_time4                                                                         as Recording_Time4,
          item.rec_time5                                                                         as Recording_Time5,
          item.rec_time6                                                                         as Recording_Time6,
          item.rec_time7                                                                         as Recording_Time7,
          item.rec_time8                                                                         as Recording_Time8,
          item.rec_time9                                                                         as Recording_Time9,
          item.rec_time10                                                                        as Recording_Time10,
          item.rec_time11                                                                        as Recording_Time11,

          /* Association */

          _item_operation,
//////          _item_calculation,
          _Header
}
