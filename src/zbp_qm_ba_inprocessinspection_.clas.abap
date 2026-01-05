CLASS zbp_qm_ba_inprocessinspection_ DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zqm_ba_inprocessinspection_1.

TYPES: ltt_data_h TYPE TABLE OF ZQM_BA_InprocessInspection_1.
  TYPES: ltt_data_i TYPE TABLE OF ZQM_BA_InprocessInspection_3.
  PUBLIC SECTION.
    CLASS-DATA gv_ins_lot TYPE c LENGTH 12.

    CLASS-METHODS get_pdf_xml
      IMPORTING
        im_data_h  TYPE ltt_data_h
        im_data_i  TYPE  ltt_data_i
      EXPORTING
        ex_base_64 TYPE   string.
ENDCLASS.



CLASS ZBP_QM_BA_INPROCESSINSPECTION_ IMPLEMENTATION.


  METHOD    get_pdf_xml.
    DATA: lwa_data   TYPE ZQM_BA_InprocessInspection_1,
          lv_subject TYPE string,
          lv_xml2    TYPE string.
    DATA(lv_time) = CONV t( xco_cp=>sy->time( xco_cp_time=>time_zone->user )->as( xco_cp_time=>format->abap )->value )..

    lwa_data = VALUE #( im_data_h[ 1 ] OPTIONAL ).
****
****    SELECT  SINGLE
****        i_inspectionlot~inspectionlot,
****       i_inspectionlot~inspectionlotcreatedontime
****     FROM
****      i_inspectionlot
****      WHERE inspectionlot = @lwa_data-inspectionlot
****      INTO @DATA(lwa_insptime).    SELECT SINGLE a~workcenterinternalid,
****    b~workcenter
****    FROM I_WorkCenterText  AS a
****    INNER JOIN I_WorkCenter AS b
****    ON a~WorkCenterInternalID = b~WorkCenterInternalID
****    AND Language = @sy-langu
****    WHERE a~WorkCenterText = @lwa_data-workcentertext
****    INTO @DATA(lwa_textid).


*****    DATA(lv_createdatetime) = |{ lwa_data-Lotcreate }{ lwa_insptime-InspectionLotCreatedOnTime }|.


    DATA(lv_xml1) =  |<?xml version="1.0" encoding="UTF-8"?>| &&

                   |<Header>| &&
                   |<Header>| &&
                    |<Print_Date>| && space && |</Print_Date>| &&
|<Print_time>| && space && |</Print_time>| &&
|<Customer>| && lwa_data-CustomerName && |</Customer>| &&
|<CertificateNo>| && lwa_data-inspectionlot && |</CertificateNo>| &&
|<Cert_No_Date>| && space && |</Cert_No_Date>| &&
|<Product>| && space && |</Product>| &&
|<Po_No>| && lwa_data-manufacturingorder && |</Po_No>| &&
|<Coo>| && space && |</Coo>| &&
|<Customer_Drawing_Rev_No>| && space && |</Customer_Drawing_Rev_No>| &&
|<Mfg_Date>| && lwa_data-Lotcreate && |</Mfg_Date>| &&
|<InvNo>| && space && |</InvNo>| &&
|<InvDate>| && space && |</InvDate>| &&
|<PartNo>| && lwa_data-PartNo && |</PartNo>| &&
|<InvQty>| && space && |</InvQty>| &&
|<FastenerClass>| && space && |</FastenerClass>| &&
|<RMGrade>| && space && |</RMGrade>| &&
|<MagnaflexTest>| && space && |</MagnaflexTest>| &&
|<LotBatchNo>| && lwa_data-batch && |</LotBatchNo>| &&




                   |</Header>| &&
                   |<Characteristic>|.

    DATA: lv_count TYPE i.
    LOOP AT im_data_i INTO DATA(lwa_data_i).
      REPLACE ALL OCCURRENCES OF '-' IN lwa_data_i-InspSpecLowerLimit WITH ' '.
      REPLACE ALL OCCURRENCES OF '-' IN lwa_data_i-InspSpecUpperLimit WITH ' '.
      lv_count = lv_count + 1.
      lv_xml2 =       lv_xml2 &&
                      |<Item>| &&
                      |<Element>| && lv_count && |</Element>| &&
                      |<Min>| && lv_count && |</Min>| &&
                      |<Max>| && lv_count && |</Max>| &&
                      |<ActualReading>| && lv_count && |</ActualReading>| &&


                      |</Item>|.

    ENDLOOP.

    DATA(lv_xml) =  lv_xml1 && lv_xml2 &&
                    |</Characteristic>| &&
                    |<Footer>| &&
                    |<PreparedBy>|     && space     && |</PreparedBy>| &&
    |<ApprovedBy>|     && space     && |</ApprovedBy>| &&
                    |</Footer>| &&
                    |</Header>|.

    REPLACE '&' WITH '&#38;' INTO lv_xml. "TO replace & from String
    ex_base_64 = cl_web_http_utility=>encode_base64( unencoded = lv_xml ).

  ENDMETHOD.
ENDCLASS.
