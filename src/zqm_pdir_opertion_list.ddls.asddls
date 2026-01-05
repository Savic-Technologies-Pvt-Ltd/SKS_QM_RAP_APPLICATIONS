@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Line Inspection Operation Interface View'
@Metadata.ignorePropagatedAnnotations: true
define  view entity ZQM_PDIR_OPERTION_LIST
  as select from zqm_t_pdir_1              as Header
    inner join   I_InspectionLot              as InspLot on Header.inspectionlot = InspLot.InspectionLot
    inner join   I_InspPlanOperationVersion_2 as Opr     on InspLot.BillOfOperationsGroup = Opr.InspectionPlanGroup
    
  association to parent ZQM_BA_PDIRHeader as _HDR on $projection.Cuuid = _HDR.Cuuid
  composition [0..*] of ZQM_PDIR_SPECIFICATION_LIST as _SPC
{
  key    Header.cuuid         as Cuuid,
  key    Header.inspectionlot as Inspectionlot,
  key    Opr.InspectionPlanGroup,
  key    Opr.BOOOperationInternalID,
         Opr.OperationText    as Operationtext,
         Header.created_by     as Createdby,
         Header.created_on     as Createdon,
         Header.changed_by     as Changedby,
         Header.changed_on     as Changedon,
         
          Header.result1,
         Header.result2,
         Header.result3,
         Header.result4,
         Header.result5,
         Header.result6,
         Header.result7,
         Header.result8,
         Header.result9,
         Header.result10,
         Header.result11,
                  Header.result12,
                  Header.result13,
                           Header.result14,
                  
                           Header.result15,
                           Header.result16,
                  
         
         Header.qcstatus,
         Header.snapgauge            ,
  Header.pokayokecheck            ,
  Header.loadverification          ,
  Header.machinecleanins             ,
  Header.qa5pcsstat                  ,
  Header.chutecleanop               ,
  Header.chutpieces                ,
  Header.inspobs                    ,
  Header.machpcs                    ,
  Header.rawmaterial                ,
  Header.subqa2prd                  ,
  Header.subprd2qa                ,
  Header.obs5pcs1st               ,
  Header.obslast                    ,
  Header.obsfinal                    ,
  Header.rejqty                     ,Header.checked_visually,
  
         _HDR,
         _SPC
} where
Opr.BOOOperationInternalID = '00000005';
