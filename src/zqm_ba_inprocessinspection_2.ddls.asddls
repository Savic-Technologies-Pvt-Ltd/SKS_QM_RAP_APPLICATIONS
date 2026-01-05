@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View for Inprocess Inspection Lot Operation'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZQM_BA_InprocessInspection_2
  as select from    zqm_t_inpr_ins_1             as head
    inner join      I_InspectionLot              as inspe    on head.inspectionlot = inspe.InspectionLot

    left outer join I_InspPlanOperationVersion_2 as planoper on inspe.BillOfOperationsGroup = planoper.InspectionPlanGroup
  association to parent ZQM_BA_InprocessInspection_1 as _Header on $projection.Cuuid = _Header.cuuid
  composition [*] of ZQM_BA_InprocessInspection_3    as _item


{
  key     head.cuuid         as Cuuid,
  key     head.inspectionlot as Inspectionlot,
  key     planoper.InspectionPlanGroup,
  key     planoper.BOOOperationInternalID,
          planoper.OperationText,
          head.shift_rec     as Shift,
          head.shif_date     as Shift_Date,
          head.rec_time1     as Recoding_Result1,
          head.rec_time2     as Recoding_Result2,
          head.rec_time3     as Recoding_Result3,
          head.rec_time4     as Recoding_Result4,
          head.rec_time5     as Recoding_Result5,
          head.rec_time6     as Recoding_Result6,
          head.rec_time7     as Recoding_Result7,
          head.rec_time8     as Recoding_Result8,
          head.rec_time9     as Recoding_Result9,
          head.rec_time10    as Recoding_Result10,
          head.rec_time11    as Recoding_Result11,

          /* Association */
          _Header,
          _item


}
where
planoper.BOOOperationInternalID = '00000003';
