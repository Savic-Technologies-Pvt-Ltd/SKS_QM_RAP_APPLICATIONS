@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Projection View Inspection Lot Header'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZCDS_QM_INS_LOT_P01
  provider contract transactional_query
  as projection on ZCDS_QM_INS_LOT_H
{

  key     cuuid,
          inspectionlot,
          Lotcreate,
          InspectionLotCreatedOnTime,
          ProductLongText,
          @ObjectModel.text.element: [ 'InspectionLotObjectText' ]
          Material,
          InspectionLotObjectText,
          batch,
          Plant,
          InspLotOrig,
          manufacturingorder,
          InspectionLotText,
          InspectionLotType,
          @Semantics.quantity.unitOfMeasure: 'Baseunit'
          LotQty,
          Baseunit,
          Equipment,
          StatusProfile,
          StartOfInsp,
          EndOfInsp,
          Customer,
          supplier,
          Manufacturer,
          PurchasingDocument,
          PurchasingDocumentItem,
          ScheduleLine,
          Ord,
          SalesOrderItem,
          Language,
          CompanyCode,
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
          OperatorName,
          Inspection,
          Monito,
          A,
          Systemstatus,

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
          other,
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
          @Semantics.largeObject:{
          mimeType: 'Mimetype_ul',
          fileName: 'Filename_ul',
          contentDispositionPreference: #INLINE
          }
          Attachments_ul,
          @Semantics.mimeType: true
          Mimetype_ul,
          Filename_ul,
          FirstFivePieceObse,
          LastPieceObservation,
          FinalObservation,
          QC_Status,
          qc_criticality,
          Rejection_Quantity,



          _Item : redirected to composition child ZCDS_QM_INS_LOT_P02
}
