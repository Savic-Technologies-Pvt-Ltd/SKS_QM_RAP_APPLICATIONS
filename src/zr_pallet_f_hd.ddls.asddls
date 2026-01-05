@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Pallet Header'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZR_PALLET_F_HD as select from zsd_pallet_hd

 composition [0..*] of ZR_PALLET_F_IT
 as _Item
 
{
    key cuuid as Cuuid,
    palletform as Palletform,
    filename as Filename,
    attachments as Attachments,
    mimetype as Mimetype,
    createdon as Createdon,
    createdby as Createdby,
    changedon as Changedon,
    changedby as Changedby,
    locallastchangedon as Locallastchangedon,
    locallastchangedby as Locallastchangedby,
    _Item

}
