@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Machine Plan Header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZR_MACH_PL_HD as select from zqm_mach_pl_hd

 composition [1..*] of ZR_MACH_PL_IT as _Item

{
    key cuuid as Cuuid,
    machineplanno as Machineplanno,
      @Semantics.systemDateTime.createdAt: true
    
    created_on as CreatedOn,
      @Semantics.user.createdBy: true
    
    created_by as CreatedBy,
      @Semantics.systemDateTime.lastChangedAt: true
    
    changed_on as ChangedOn,
      @Semantics.user.lastChangedBy: true
    
    changed_by as ChangedBy,
    local_last_changed_on as LocalLastChangedOn,
    local_last_changed_by as LocalLastChangedBy,
    
    filename           ,
  attachments       ,
  mimetype          ,
  workcenter        ,
  workcenterid       ,
    _Item
}
