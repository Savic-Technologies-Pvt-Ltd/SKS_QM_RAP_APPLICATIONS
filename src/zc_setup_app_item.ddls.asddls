@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Setup Approval Item Consumption'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define  view entity ZC_SETUP_APP_ITEM   as projection on ZR_SETUP_APP_ITEM
{
    key Cuuid,
    key Itemno,
    Parameters,
    Specifications,
    Mmr,
    Obs1,
    Obs2,
    Obs3,
    Obs4,
    Obs5,
     obs1_t ,
    obs2_t ,
    obs3_t ,
    obs4_t ,
    obs5_t ,
    _HDR : redirected to parent ZC_SETUP_APP_HEAD
    
}
