@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View For Inspection Lot Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}

define view entity ZCDS_QM_INS_LOT_I
  as select from    zta_qm_ins_lot               as _head
    left outer join I_InspectionCharacteristic   as a on a.InspectionLot = _head.inspectionlot
    left outer join I_CharcAttribSelectedCodeSet as b on  b.SelectedCodeSetPlant = a.InspectionSpecificationPlant
                                                      and b.SelectedCodeSet      = a.SelectedCodeSet
                                                      and b.Language             = $session.system_language
    left outer join zta_qm_insplot_i             as c on  c.inspectionlot = a.InspectionLot
                                                      and c.insp_lot_item = a.InspectionCharacteristic
  association to parent ZCDS_QM_INS_LOT_H as _Header on $projection.cuuid = _Header.cuuid
{
  key      _head.cuuid,
  key      a.InspectionLot                                                                as InspectionLot,
  key      a.InspectionCharacteristic                                                     as InspLotItem,
  key      a.InspPlanOperationInternalID,
           concat('Parameter',':')                                                        as Specification,
           concat(a.InspectionSpecificationText,'')                                       as Specification1,
           a.InspectionSpecification,
           a.InspectionSpecificationPlant,
           concat('Specification',':')                                                    as SelectedCodeSetText,
           case when a.InspSpecTargetValue is initial  or a.InspSpecTargetValue is null
           then '-'
           else
            cast(cast(a.InspSpecTargetValue as abap.dec( 16, 3 )) as abap.char( 22 )) end as InspSpecTargetValue,
           case when a.InspSpecUpperLimit is initial  or a.InspSpecUpperLimit is null
           then '-'
           else
            cast(cast(a.InspSpecUpperLimit as abap.dec( 16, 3 )) as abap.char( 22 )) end  as InspSpecUpperLimit,
           case when a.InspSpecLowerLimit is initial  or a.InspSpecLowerLimit is null
           then '-'
           else
            cast(cast(a.InspSpecLowerLimit as abap.dec( 16, 3 )) as abap.char( 22 )) end  as InspSpecLowerLimit,

           concat( concat( 'Max',' - '),
           case when a.InspSpecUpperLimit is initial  or a.InspSpecUpperLimit is null
           then ''
           else
            cast(cast(a.InspSpecUpperLimit as abap.dec( 16, 3 )) as abap.char( 22 ))
            end )                                                                         as lab_max,
           concat( concat( 'Min',' - '),
           case when a.InspSpecUpperLimit is initial  or a.InspSpecUpperLimit is null
           then ''
           else
            cast(cast(a.InspSpecUpperLimit as abap.dec( 16, 3 )) as abap.char( 22 ))
            end )                                                                         as lab_min,
           case when  ( a.InspSpecUpperLimit is initial or a.InspSpecUpperLimit is null ) and ( a.InspSpecLowerLimit is initial or a.InspSpecLowerLimit is null )
            then concat( b.SelectedCodeSetText,'')
            else

           case when  a.InspSpecLowerLimit is initial  or a.InspSpecLowerLimit is null
            then

              concat( concat(cast(cast(a.InspSpecUpperLimit as abap.dec( 16, 3 )) as abap.char( 22 )),'-'),

             ' Max')
             when
              a.InspSpecUpperLimit is initial  or a.InspSpecUpperLimit is null
            then
              concat( concat(cast(cast(a.InspSpecLowerLimit as abap.dec( 16, 3 )) as abap.char( 22 )),'-'),

             'Min')
            else


            concat( concat(cast(cast(a.InspSpecLowerLimit as abap.dec( 16, 3 )) as abap.char( 22 )),'-'),

             cast(cast(a.InspSpecUpperLimit as abap.dec( 16, 3 ))   as abap.char( 22 )))

             end

             end                                                                          as SelectedCodeSetText1,
           ''                                                                             as Inspect,
           ''                                                                             as Inspected,
           concat('Result1',':')                                                          as Reslab1,
           //         cast(concat(c.res,'')  as abap.dec( 4, 2 ))                                   as Resval1,
           concat(c.res,'')                                                               as Resval1,
           concat('Result2',':')                                                          as Reslab2,
           concat(c.res2,'')                                                              as Resval2,
           concat('Result3',':')                                                          as Reslab3,
           concat(c.res3,'')                                                              as Resval3,
           concat('Result4',':')                                                          as Reslab4,
           concat(c.res4,'')                                                              as Resval4,
           concat('Result5',':')                                                          as Reslab5,
           concat(c.res5,'')                                                              as Resval5,
           concat('Result6',':')                                                          as Reslab6,
           concat(c.res6,'')                                                              as Resval6,
           concat('Result7',':')                                                          as Reslab7,
           concat(c.res7,'')                                                              as Resval7,
           concat('Result8',':')                                                          as Reslab8,
           concat(c.res8,'')                                                              as Resval8,
           concat('Result9',':')                                                          as Reslab9,
           concat(c.res9,'')                                                              as Resval9,
           concat('Result10',':')                                                         as Reslab10,
           concat(c.res10,'')                                                             as Resval10,
           concat('Result11',':')                                                         as Reslab11,
           cast(concat(cast(c.res11 as abap.char(18)),'')  as tzntstmps )                 as Resval11,
           c.othertext1,
           c.othertext2,
           ''                                                                             as dm,
           c.res_mark1,
           c.res_mark2,
           c.res_mark3,
           c.res_mark4,
           c.res_mark5,
           c.res_mark6,
           c.res_mark7,
           c.res_mark8,
           c.res_mark9,
           c.res_mark10,
           c.res_mark11,
           c.res_mark1_ind,
           c.res_mark2_ind,
           c.res_mark3_ind,
           c.res_mark4_ind,
           c.res_mark5_ind,
           c.res_mark6_ind,
           c.res_mark7_ind,
           c.res_mark8_ind,
           c.res_mark9_ind,
           c.res_mark10_ind,
           c.res_mark11_ind,
           cast('00' as abap.dec( 4, 2 ))                                                 as tr,

           _Header
}
