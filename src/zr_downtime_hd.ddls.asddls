@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Downtime Header Interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZR_DOWNTIME_HD as select from zqm_downtime_hd
 composition [1..*] of ZR_DOWNTIME_IT
 as _Item

  association [0..*] to ZR_DOWNTIME_RE as _GrandChild on $projection.Cuuid = _GrandChild.Cuuid

{
    key cuuid as Cuuid,
    downtimeno as Downtimeno,
    plant as Plant,
    filename as Filename,
    attachments as Attachments,
    mimetype as Mimetype,
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
    _Item,
    _GrandChild
}
