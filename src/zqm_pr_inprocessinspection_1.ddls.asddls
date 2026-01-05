@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for Inprocess Inspection Header'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZQM_PR_InprocessInspection_1
  provider contract transactional_query
  as projection on ZQM_BA_InprocessInspection_1

{
  key cuuid,
      inspectionlot,
      Lotcreate,
      material,
      inspectionlotobjecttext,
      batch,
      plant,
      insplotorig,
      manufacturingorder,
      inspectionlottext,
      inspectionlottype,
      @Semantics.quantity.unitOfMeasure: 'Baseunit'
      lotqty,
      baseunit,
      equipment,
      statusprofile,
      startofinsp,
      endofinsp,
      customer,
      supplier,
      manufacturer,
      purchasingdocument,
      purchasingdocumentitem,
      scheduleline,
      SalesOrder,
      salesorderitem,
      language,
      companycode,
      InspectionOperation,
      operationtext,
      workcentertext,
      operationconfirmation,
      DRGno,
      Grade,
      RM_Specification,
      PartNo,
      Shift,
      WasherLotNo,
                @Consumption.valueHelpDefinition: [{ entity: { name: 'ZD_OPERATOR_NAME', element: 'operatorNameText' } }]
      
      OperatorName,
      Inspection,
      checkbox,
      checkbox2,
      approved,
      snapgaugeavl,
      notapproved,
      pokayokechecked,
      obseropera,
      cleaned,
      loadverf,
      nopiecchute,
      obseinspector,
      nopiecesaroundmachine,
      dmt,
      vcd,
      dial,
      dpmt,
      pp,
      gaugenogo,
      nogo,
      Qcstatus,
      ar1,
      ar2,
      ar3,
      ar4,
      ar5,
      ar6,
      ar7,
      ar8,
      ar9,
      ar10,
      ar11,
      prodtime,
      qatime,
      previousopt,
      nextopt,
      rawmaterial,
      @Semantics.largeObject:{
      mimeType: 'Mimetype',
      fileName: 'Filename',
      contentDispositionPreference: #INLINE
      }
      Attachments,
      @Semantics.mimeType: true
      Mimetype,
      Filename,
       MaterialDescription,
      CustomerName,
            @Semantics.quantity.unitOfMeasure: 'Baseunit'
      
      lot_quan,
                          @Consumption.valueHelpDefinition: [{ entity: { name: 'ZD_INPROCESS_FORM', element: 'formText' } }]
      
      formtype,
      /* Associations */
           _item_operation : redirected to composition child ZQM_PR_InprocessInspection_2
}
