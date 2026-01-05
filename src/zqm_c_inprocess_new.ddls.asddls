    @AccessControl.authorizationCheck: #NOT_REQUIRED
    @EndUserText.label: 'Inprocess Consumption view'
    @Metadata.ignorePropagatedAnnotations: true
    @Metadata.allowExtensions: true
    define root view entity ZQM_C_Inprocess_NEW
      provider contract transactional_query
      as projection on ZQM_I_Inprocess_NEW
    
    {
      key Cuuid,
          Inspectionlot,
          Lotcreate,
          Startofinsp,
          Endofinsp,
          Plant,
          Material,
          Customer,
          @Semantics.quantity.unitOfMeasure: 'Baseunit'
    
          Lotqty,
          Baseunit,
          Manufacturingorder,
          Inspectionlotobjecttext,
          Batch,
          Supplier,
          Manufacturer,
          Inspectionoperation,
          Inspection,
          Salesorder,
          Drgno,
          RmSpecification,
          Grade,
          Partno,
          Operationtext,
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
          Result1,
          Result2,
          Result3,
          Result4,
          Result5,
          Result6,
          Result7,
          Result8,
          Result9,
          Result10,
          Result11,
          Result12,
          Result13,
          Result14,
          Result15,
          Result16,
          @Consumption.valueHelpDefinition: [{ entity: { name: 'ZQM_QCSTATUS', element: 'operatorNameText' } }]
    
          Qcstatus,
          Snapgauge,
          Pokayokecheck,
          Loadverification,
          Machinecleanins,
          Qa5pcsstat,
          Chutecleanop,
          Chutpieces,
          Inspobs,
          Machpcs,
          Rawmaterial,
          Subqa2prd,
          Subprd2qa,
          Obs5pcs1st,
          Obslast,
          Obsfinal,
          Rejqty,
          Materialdescription,
          Customername,
          QtyChkd,
          InvNo,
          InvDate,
          @Semantics.quantity.unitOfMeasure: 'Baseunit'
    
          InvQty,
          CustDraw,
          SksDraw,
          Materiallongtxt,
          FilenameUl,
          AttachmentsUl,
          MimetypeUl,
          @Consumption.valueHelpDefinition: [{ entity: { name: 'ZD_INPROCESS_FORM', element: 'formText' } }]
    
          Formtype,
          Remark,
          Lever,
          Basedon,
          PoNo,
          @Consumption.valueHelpDefinition: [{ entity: { name: 'ZD_APPROVED_BY', element: 'operatorNameText' } }]
    
          ApprovedBy,
          @Consumption.valueHelpDefinition: [{ entity: { name: 'ZD_REPORTED_BY', element: 'operatorNameText' } }]
    
          ReportedBy,
          CheckedVisually,
          CreatedOn,
          CreatedBy,
          ChangedOn,
          ChangedBy,
          LocalLastChangedOn,
          LocalLastChangedBy,
          lotcreatetime,
          @Consumption.valueHelpDefinition: [{ entity: { name: 'ZQM_APPR_FURTHER', element: 'operatorNameText' } }]
    
          appr_further,
          _Item : redirected to composition child ZQM_C_Inprocess_item_NEW,
          _ChemItem : redirected to composition child ZQM_C_Inprocess_cHEM_NEW
    
    
    
    }
