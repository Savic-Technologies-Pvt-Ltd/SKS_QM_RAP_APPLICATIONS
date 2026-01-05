@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Line Inspection Char. Value Basic View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType: {
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity  ZQM_BA_LINSP_CHARVAL
  as select from I_Product                                                         as MAT
    inner join   I_ClfnObjectCharcValForKeyDate( P_KeyDate: $session.system_date ) as VAL  on VAL.ClfnObjectID = MAT.Product

    inner join   I_ClfnCharacteristicForKeyDate( P_KeyDate: $session.system_date ) as CHAR on VAL.CharcInternalID = CHAR.CharcInternalID

{
  key MAT.Product                                                                               as Product,

      max(case when CHAR.Characteristic = 'DRAWING_NO' then VAL.CharcValue else '' end)         as DRGno,
      max(case when CHAR.Characteristic = 'RAW_MATERIAL_GRADE' then VAL.CharcValue else '' end) as Grade,
      max(case when CHAR.Characteristic = 'DEP_TYPE' then VAL.CharcValue else '' end)           as Rmspecification,
      max(case when CHAR.Characteristic = 'ITEM_CODE' then VAL.CharcValue else '' end)          as Partnumber

}
group by
  MAT.Product
