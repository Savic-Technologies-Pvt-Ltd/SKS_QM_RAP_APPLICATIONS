
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Line Inspection Operation Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZQM_C_PDIR_OPERTION_LIST
  as projection on ZQM_PDIR_OPERTION_LIST
{
  key    Cuuid,
  key    Inspectionlot,
  key    InspectionPlanGroup,
  key    BOOOperationInternalID,
         Operationtext,
         Createdby,
         Createdon,
         Changedby,
         Changedon,
             result1,
         result2,
         result3,
         result4,
         result5,
         result6,
         result7,
         result8,
         result9,
         result10,
         result11,
         result12,
         result13,
         result14,
         result15,
         result16,
         qcstatus,
          snapgauge            ,
  pokayokecheck            ,
  loadverification          ,
  machinecleanins             ,
  qa5pcsstat                  ,
  chutecleanop               ,
  chutpieces                ,
  inspobs                    ,
  machpcs                    ,
  rawmaterial                ,
  subqa2prd                  ,
  subprd2qa                ,
  obs5pcs1st               ,
  obslast                    ,
  obsfinal                    ,
  rejqty                     ,checked_visually,
  
         /* Associations */
         _HDR : redirected to parent ZQM_PR_PDIRHeader,
         _SPC : redirected to composition child ZQM__C_PDIR_SPECIFICATION_LIST
         
}
