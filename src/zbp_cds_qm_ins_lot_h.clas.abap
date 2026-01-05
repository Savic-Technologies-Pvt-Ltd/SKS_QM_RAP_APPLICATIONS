CLASS zbp_cds_qm_ins_lot_h DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zcds_qm_ins_lot_h.
  TYPES: ltt_data_h TYPE TABLE OF zcds_qm_ins_lot_h.
  TYPES: ltt_data_i TYPE TABLE OF zcds_qm_ins_lot_i.
  CLASS-METHODS get_pdf_xml
    IMPORTING
      im_data_h  TYPE ltt_data_h
      im_data_i  TYPE  ltt_data_i
    EXPORTING
      ex_base_64 TYPE   string.
ENDCLASS.



CLASS ZBP_CDS_QM_INS_LOT_H IMPLEMENTATION.


  METHOD    get_pdf_xml.
    DATA: lwa_data   TYPE zcds_qm_ins_lot_h,
          lv_subject TYPE string,
          lv_xml2    TYPE string.
    DATA(lv_time) = CONV t( xco_cp=>sy->time( xco_cp_time=>time_zone->user )->as( xco_cp_time=>format->abap )->value )..

    lwa_data = VALUE #( im_data_h[ 1 ] OPTIONAL ).

    SELECT  SINGLE
        i_inspectionlot~inspectionlot,
       i_inspectionlot~inspectionlotcreatedontime
     FROM
      i_inspectionlot
      WHERE inspectionlot = @lwa_data-inspectionlot
      INTO @DATA(lwa_insptime).    SELECT SINGLE a~workcenterinternalid,
    b~workcenter
    FROM I_WorkCenterText  AS a
    INNER JOIN I_WorkCenter AS b
    ON a~WorkCenterInternalID = b~WorkCenterInternalID
    AND Language = @sy-langu
    WHERE a~WorkCenterText = @lwa_data-workcentertext
    INTO @DATA(lwa_textid).


    DATA(lv_createdatetime) = |{ lwa_data-Lotcreate }{ lwa_insptime-InspectionLotCreatedOnTime }|.


    DATA(lv_xml1) =  |<?xml version="1.0" encoding="UTF-8"?>| &&
                   |<Form>| &&
                   |<FivePiece>| &&
                   |<DateTime>| && lv_createdatetime && |</DateTime>| &&
                   |<PrintTime>| && lv_time && |</PrintTime>| &&
                   |<LotNo>| && lwa_data-inspectionlot && |</LotNo>| &&
                   |<Batch>| && lwa_data-Batch && |</Batch>| &&
                   |<WashorLotNo>| && lwa_data-WasherLotNo && |</WashorLotNo>| &&
                   |<Machine>| && lwa_textid-WorkCenter && |</Machine>| &&
                   |<OperationNo>| && lwa_data-OperationConfirmation && |</OperationNo>| &&
                   |<Grade>| && lwa_data-Grade && |</Grade>| &&
                   |<Product>| && lwa_data-ProductLongText && |</Product>| &&
                   |<OprnDtl>| && '' && |</OprnDtl>| &&
                   |<DrgNo>| && lwa_data-DRGno && |</DrgNo>| &&
                   |<RMSpecification>| && lwa_data-RM_Specification && |</RMSpecification>| &&
                   |<OperatorName>| && lwa_data-OperatorName && |</OperatorName>| &&
                   |<Inspector>| && lwa_data-Inspection && |</Inspector>| &&
                   |<PartNo>| && lwa_data-PartNo && |</PartNo>| &&
                   |<PreviousOperation>| && lwa_data-previousopt && |</PreviousOperation>| &&
                   |<NextOperation>| && lwa_data-nextopt && |</NextOperation>| &&
                   |<RawMaterial>| && lwa_data-rawmaterial && |</RawMaterial>| &&
                   |<SubtoQATimebyProdTime>| && lwa_data-prodtime && |</SubtoQATimebyProdTime>| &&
                   |<SubtoProdTimebyQATime>| && lwa_data-qatime && |</SubtoProdTimebyQATime>| &&
                   |<FivePieceApprovalStatus>| && lwa_data-checkbox && |</FivePieceApprovalStatus>| &&
                   |<Approved>| && lwa_data-approved && |</Approved>| &&
                   |<PokayokeChecked>| && lwa_data-pokayokechecked && |</PokayokeChecked>| &&
                   |<ChutecleobsbyOperator>| && lwa_data-obseropera && |</ChutecleobsbyOperator>| &&
                   |<Cleaned>| && lwa_data-cleaned && |</Cleaned>| &&
                   |<NoofPieceinChute>| && lwa_data-nopiecchute && |</NoofPieceinChute>| &&
                   |<MachClerouobsbyinspe>| && lwa_data-obseinspector  && |</MachClerouobsbyinspe>| &&
                   |<MachineCleaned>| && lwa_data-checkbox2 && |</MachineCleaned>| &&
                   |<NoofPieceinaroundMach>| && lwa_data-nopiecesaroundmachine && |</NoofPieceinaroundMach>| &&
                   |<InstrumentCodeNos>| && '' && |</InstrumentCodeNos>| &&
                   |<VCD>| && lwa_data-vcd && |</VCD>| &&
                   |<DIAL>| && lwa_data-dial && |</DIAL>| &&
                   |<PP>| && lwa_data-pp && |</PP>| &&
                   |<DPMT>| && lwa_data-dpmt && |</DPMT>| &&
                   |<GaugeNo>| && lwa_data-gaugenogo && |</GaugeNo>| &&
                   |<Other>| && lwa_data-nogo && |</Other>| &&
                   |<Shift>| && lwa_data-Shift && |</Shift>| &&
                   |<AR1>| && lwa_data-ar1 && |</AR1>| &&
                   |<AR2>| && lwa_data-ar2 && |</AR2>| &&
                   |<AR3>| && lwa_data-ar3 && |</AR3>| &&
                   |<AR4>| && lwa_data-ar4 && |</AR4>| &&
                   |<AR5>| && lwa_data-ar5 && |</AR5>| &&
                   |<AR6>| && lwa_data-ar6 && |</AR6>| &&
                   |<AR7>| && lwa_data-ar7 && |</AR7>| &&
                   |<AR8>| && lwa_data-ar8 && |</AR8>| &&
                   |<AR9>| && lwa_data-ar9 && |</AR9>| &&
                   |<AR10>| && lwa_data-ar10 && |</AR10>| &&
                   |<AR11>| && lwa_data-ar11 && |</AR11>| &&
                   |<Item>|.

    DATA: lv_count TYPE i.
    LOOP AT im_data_i INTO DATA(lwa_data_i).
      REPLACE ALL OCCURRENCES OF '-' IN lwa_data_i-InspSpecLowerLimit WITH ' '.
      REPLACE ALL OCCURRENCES OF '-' IN lwa_data_i-InspSpecUpperLimit WITH ' '.
      lv_count = lv_count + 1.
      lv_xml2 =       lv_xml2 &&
                      |<ItemData>| &&
                      |<SrNo>| && lv_count && |</SrNo>| &&
                      |<Parameter>| && lwa_data_i-Specification1 && |</Parameter>| &&
                      |<Specification>| && lwa_data_i-SelectedCodeSetText1 && |</Specification>| &&
                      |<Min>| && lwa_data_i-InspSpecLowerLimit  && |</Min>| &&
                      |<Max>| && lwa_data_i-InspSpecUpperLimit && |</Max>| &&
                      |<Result1>| && lwa_data_i-Resval1 && |</Result1>| &&
                      |<Result2>| &&  lwa_data_i-Resval2 && |</Result2>| &&
                      |<Result3>| &&  lwa_data_i-Resval3 && |</Result3>| &&
                      |<Result4>| &&  lwa_data_i-Resval4 && |</Result4>| &&
                      |<Result5>| &&  lwa_data_i-Resval5 && |</Result5>| &&
                      |<Result6>| &&  lwa_data_i-Resval6 && |</Result6>| &&
                      |<Result7>| &&  lwa_data_i-Resval7 && |</Result7>| &&
                      |<Result8>| &&  lwa_data_i-Resval8 && |</Result8>| &&
                      |<Result9>| &&  lwa_data_i-Resval9 && |</Result9>| &&
                      |<Result10>| &&  lwa_data_i-Resval10 && |</Result10>| &&
                      |<Result11>| &&  lwa_data_i-Resval11 && |</Result11>| &&
                      |</ItemData>|.

    ENDLOOP.

    DATA(lv_xml) =  lv_xml1 && lv_xml2 &&
                    |</Item>| &&
                    |</FivePiece>| &&
                    |</Form>|.

    REPLACE '&' WITH '&#38;' INTO lv_xml. "TO replace & from String
    ex_base_64 = cl_web_http_utility=>encode_base64( unencoded = lv_xml ).

  ENDMETHOD.
ENDCLASS.
