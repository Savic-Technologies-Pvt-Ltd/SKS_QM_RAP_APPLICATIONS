@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Inprocess Item Consumption view'
@Metadata.ignorePropagatedAnnotations: true

@Metadata.allowExtensions: true
define  view entity ZQM_C_Inprocess_item_NEW as projection on ZQM_I_Inprocess_item_NEW


{
    key Cuuid,
    key Boooperationinternalid,
    key Inspectionlotitem,
    key Inspectionlot,
    key Boocharacteristicversion,
    key Inspectionplangroup,
     Spc,
      InspSpecTargetValue,
      InspSpecUpperLimit,
      InspSpecLowerLimit,
      InspectionSpecification,
      Specification,
    Selectedcodesettext,
     samples, 
observed ,
threaddetails, 
//    Result1,
//    Result2,
//    Result3,
//    Result4,
//    Result5,
//    Result6,
//    Result7,
//    Result8,
//    Result9,
//    Result10,
//  
//    Resultval1,
//    Resultval2,
//    Resultval3,
//    Resultval4,
//    Resultval5,
//    Resultval6,
//    Resultval7,
//    Resultval8,
//    Resultval9,
//    Resultval10,
//  
//    Resulttxt1,
//    Resulttxt2,
//    Resulttxt3,
//    Resulttxt4,
//    Resulttxt5,
//    Resulttxt6,
//    Resulttxt7,
//    Resulttxt8,
//    Resulttxt9,
//    Resulttxt10,
// 
//    ResMark1Ind,
//    ResMark2Ind,
//    ResMark3Ind,
//    ResMark4Ind,
//    ResMark5Ind,
//    ResMark6Ind,
//    ResMark7Ind,
//    ResMark8Ind,
//    ResMark9Ind,
//    ResMark10Ind,
//   
//    ResMark1,
//    ResMark2,
//    ResMark3,
//    ResMark4,
//    ResMark5,
//    ResMark6,
//    ResMark7,
//    ResMark8,
//    ResMark9,
//    ResMark10,
//    ResMark11,
//    Remark,
//    
//  result1mm                 ,  
//  result2mm                 ,  
//  result3mm                 ,  
//  result4mm                 ,  
//  result5mm                 ,  
//  result6mm                 ,  
//  result7mm                 ,  
//  result8mm                 ,  
//  result9mm                 ,  
//  result10mm                ,    
//  result11mm                ,    
//  result12mm                ,    
//  result13mm                ,    
//  result14mm                ,    
//  result15mm                ,    
//  result16mm                , 

    /* Associations */

    _HDR : redirected to parent ZQM_C_Inprocess_NEW


    
}
