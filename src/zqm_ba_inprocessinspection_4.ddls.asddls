@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View for Inprocess Inspection Lot Calculation'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZQM_BA_InprocessInspection_4
  as select from    ZQM_BA_InprocessInspection_3 as inspeitem

    left outer join zqm_t_inpr_ins_3             as itemcal on  itemcal.inspectionlot = inspeitem.Inspectionlot
                                                            and itemcal.insp_lot_item = inspeitem.InspLotItem
  association to parent ZQM_BA_InprocessInspection_3 as _item   on  $projection.Cuuid                    = _item.Cuuid
                                                                and $projection.Inspectionlot            = _item.Inspectionlot
                                                               and $projection.InspLotItem              = _item.InspLotItem
                                                                 and $projection.BOOOperationInternalID   = _item.BOOOperationInternalID
                                                                and $projection.BOOCharacteristicVersion = _item.BOOCharacteristicVersion
                                                                and $projection.InspectionPlanGroup      = _item.InspectionPlanGroup
  association to ZQM_BA_InprocessInspection_1        as _header on  $projection.Cuuid = _header.cuuid

{
  key     inspeitem.Cuuid,
  key     inspeitem.Inspectionlot,
  key     inspeitem.InspectionPlanGroup,
  key     inspeitem.BOOOperationInternalID,
  key     inspeitem.InspLotItem,
  key     inspeitem.BOOCharacteristicVersion,
  key     itemcal.cuuid               as Cuuid_cal,
          itemcal.specification       as Specification,
          itemcal.selectedcodesettext as Selectedcodesettext,
          itemcal.ind                 as Ind,
          itemcal.time                as Time,
          itemcal.read_res1           as ReadRes1,
          itemcal.read_res2           as ReadRes2,
          itemcal.read_res3           as ReadRes3,
          itemcal.read_res4           as ReadRes4,
          itemcal.read_res5           as ReadRes5,
          itemcal.read_res6           as ReadRes6,
          itemcal.read_res7           as ReadRes7,
          itemcal.read_res8           as ReadRes8,
          itemcal.read_res9           as ReadRes9,
          itemcal.read_res10          as ReadRes10,
          itemcal.read_res11          as ReadRes11,
          itemcal.read_res12          as ReadRes12,
          itemcal.read_res13          as ReadRes13,
          itemcal.read_res14          as ReadRes14,
          itemcal.read_res15          as ReadRes15,
          itemcal.read_res16          as ReadRes16,
          itemcal.read_res17          as ReadRes17,
          itemcal.read_res18          as ReadRes18,
          itemcal.read_res19          as ReadRes19,
          itemcal.read_res20          as ReadRes20,
          itemcal.read_res21          as ReadRes21,
          itemcal.read_res22          as ReadRes22,
          itemcal.read_res23          as ReadRes23,
          itemcal.read_res24          as ReadRes24,
          itemcal.read_res25          as ReadRes25,
          itemcal.othertext1          as Othertext1,
          itemcal.othertext2          as Othertext2,
          itemcal.grandbar_x          as GrandbarX,
          itemcal.ucl_x               as UclX,
          itemcal.ucl_r               as UclR,
          itemcal.sigma               as Sigma,
          itemcal.rbar                as Rbar,
          itemcal.lcl_x               as LclX,
          itemcal.lcl_r               as LclR,
          itemcal.cpk                 as Cpk,
          itemcal.a2                  as A2,
          itemcal.d4                  as D4,
          itemcal.d3                  as D3,
          itemcal.tol                 as Tol,
          itemcal.cp                  as Cp,
          itemcal.cpk2                as Cpk2,
          itemcal.created_by          as CreatedBy,
          itemcal.created_on          as CreatedOn,
          itemcal.last_change_by      as LastChangeBy,
          itemcal.last_change_on      as LastChangeOn,
          
          /* Association */
          _item,
          _header

}
