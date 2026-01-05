@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View for PDIR Header'
@Metadata.ignorePropagatedAnnotations: false
@Metadata.allowExtensions: true
define root view entity ZQM_PR_PDIRHeader
  provider contract transactional_query
  as projection on ZQM_BA_PDIRHeader
{
  key Cuuid,
      Inspectionlot,
      lotcreate,
      startofinsp,
      endofinsp,
      plant,
      material,
      customer,
      lotqty,
      baseunit,
      manufacturingorder,
      inspectionlotobjecttext,
      batch,
      supplier,
      manufacturer,
      inspectionoperation,
      inspection,
      salesorder,
      drgno,
      RmSpecification,
      grade,
      partno,
      operationtext,
      Workcentertext,
      Operationconfirmation,
      Shift,
          @Consumption.valueHelpDefinition: [{ entity: { name: 'ZD_OPERATOR_NAME', element: 'operatorNameText' } }]
      
      Operatorname,
      Previousopt,
      Nextopt,
      Filename,
      
       @Semantics.largeObject:{
          mimeType: 'Mimetype',
          fileName: 'Filename',
          contentDispositionPreference: #INLINE
          }
          Attachments,
      Mimetype,
      Dmt,
      Vcd,
      Dial,
      Dpmt,
      Pp,
      Gaugenogo,
      Nogo,
      Other,
      Qcstatus,
      CreatedOn,
      CreatedBy,
      ChangedOn,
      ChangedBy,
      LocalLastChangedOn,
      LocalLastChangedBy,
      MaterialDescription,
      CustomerName,
      qty_chkd,
      inv_no,
      inv_date,
      inv_qty,
      cust_draw,
      sks_draw,
      remark,
      lever,
      basedon,
      checked_visually,
      materiallongtxt,
       @Semantics.largeObject:{
          mimeType: 'Mimetype_ul',
          fileName: 'Filename_ul',
          contentDispositionPreference: #INLINE
          }
          Attachments_ul,
          @Semantics.mimeType: true
          Mimetype_ul,
          Filename_ul,
                    @Consumption.valueHelpDefinition: [{ entity: { name: 'ZC_PDIR_FORM', element: 'formText' } }]
          
          formtype,
          po_no,
                    @Consumption.valueHelpDefinition: [{ entity: { name: 'ZD_APPROVED_BY', element: 'operatorNameText' } }]
          
          approved_by,
          @Consumption.valueHelpDefinition: [{ entity: { name: 'ZD_REPORTED_BY', element: 'operatorNameText' } }]
          reported_by,
      /* Associations */
      _Item : redirected to composition child ZQM_PR_PDIRItem,
     _OperationItem : redirected to composition child ZQM_C_PDIR_OPERTION_LIST
      
}
