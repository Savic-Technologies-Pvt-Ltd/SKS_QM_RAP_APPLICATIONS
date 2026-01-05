@AbapCatalog.sqlViewName: 'ZPLANTSHLPV'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Plant Search Help CDS View'
@Search.searchable: true
define view ZC_PlantSearchHelp
  as select from I_Plant
{
  key Plant,
       PlantName
}
