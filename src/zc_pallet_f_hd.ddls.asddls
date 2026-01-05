@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Pallet Header'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root  view entity ZC_PALLET_F_HD provider contract transactional_query as projection on ZR_PALLET_F_HD

{
    key Cuuid as Cuuid,
    Palletform as Palletform,
    Filename as Filename,
    Attachments as Attachments,
    Mimetype as Mimetype,
    Createdon as Createdon,
    Createdby as Createdby,
    Changedon as Changedon,
    Changedby as Changedby,
    Locallastchangedon as Locallastchangedon,
    Locallastchangedby as Locallastchangedby  ,
    
    
         _Item : redirected to composition child ZC_PALLET_F_IT

    
    }
