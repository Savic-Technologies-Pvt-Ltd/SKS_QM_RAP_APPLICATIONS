@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZMMGATE_HEAD'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_MMGATE_HEAD
  as select from zmm_gate_head
  composition [1..*] of ZR_MMGATE_ITEM as _item
    composition [1..*] of ZR_MMGATE_DOC_HD as _docHeader
  
    
{
  key gatenumber as Gatenumber,
   key plant,
  truckdata as Truckdata,
  transportername as Transportername,
  vehicleno as Vehicleno,
  drivername as Drivername,
  @Semantics.user.createdBy: true
  createdby as Createdby,
  @Semantics.systemDateTime.createdAt: true
  creat_dat as CreatDat,
  @Semantics.user.lastChangedBy: true
  chan_by as ChanBy,
  @Semantics.systemDateTime.lastChangedAt: true
  chan_at as ChanAt,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  
    ebeln             ,
  ekorg                ,
  ekgrp                 ,
  lifnr                 ,
  bukrs                 ,
  vendorname            ,
  einvoicenumber        ,
  einvoicedate          ,
  podate                ,
  manualgateentry,
  challanno              ,
  challandate         ,
  gatetype,
    inwardtype,
     invoicenumber       ,
  invoicedate          ,
   ewayinvoicenumber     ,
  ewayinvoicedate       ,
  
   filename                          as Filename,
      attachments                       as Attachments,
      mimetype                          as Mimetype,
 _item,
 _docHeader
}
