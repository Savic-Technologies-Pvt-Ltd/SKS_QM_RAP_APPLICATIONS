CLASS zbp_qm_i_inprocess_new DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zqm_i_inprocess_new.


TYPES: ltt_data_h TYPE TABLE OF ZQM_I_Inprocess_NEW
.
  TYPES: ltt_data_i TYPE TABLE OF ZQM_I_Inprocess_item_NEW
.

TYPES: ltt_data_c TYPE TABLE OF ZQM_i_Inprocess_cHEM_NEW

.
  PUBLIC SECTION.
    CLASS-DATA gv_ins_lot TYPE c LENGTH 12.

    CLASS-METHODS get_pdf_xml
      IMPORTING
        im_data_h  TYPE ltt_data_h
        im_data_i  TYPE  ltt_data_i
        im_data_c  TYPE  ltt_data_c
      EXPORTING
        ex_base_64 TYPE   string.
ENDCLASS.



CLASS ZBP_QM_I_INPROCESS_NEW IMPLEMENTATION.


 METHOD    get_pdf_xml.
    DATA: lwa_data   TYPE ZQM_I_Inprocess_NEW
,
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


    lv_xml2 =  |<?xml version="1.0" encoding="UTF-8"?>| &&

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
    LOOP AT im_data_c INTO DATA(lwa_data_c).
      REPLACE ALL OCCURRENCES OF '-' IN lwa_data_c-MinValue WITH ' '.
      REPLACE ALL OCCURRENCES OF '-' IN lwa_data_c-MaxValue WITH ' '.
      lv_count = lv_count + 1.
      lv_xml2 =       lv_xml2 &&
                      |<Item>| &&
                      |<Element>| && lwa_data_c-element && |</Element>| &&
                      |<Min>| && lwa_data_c-MinValue && |</Min>| &&
                      |<Max>| && lwa_data_c-MaxValue && |</Max>| &&
                      |<ActualReading>| && lwa_data_c-Actual && |</ActualReading>| &&


                      |</Item>|.

    ENDLOOP.

    lv_xml2 =  lv_xml2 &&
                    |</Characteristic>| &&

                    |<Measurement>|.

    DATA: lv_count1 TYPE i.
    LOOP AT im_data_i INTO DATA(lwa_data_i).
      REPLACE ALL OCCURRENCES OF '-' IN lwa_data_i-InspSpecLowerLimit WITH ' '.
      REPLACE ALL OCCURRENCES OF '-' IN lwa_data_i-InspSpecUpperLimit WITH ' '.
      lv_count1 = lv_count1 + 1.
      lv_xml2 = lv_xml2 &&
                      |<Item>| &&
                      |<NatureOfTest>| && lwa_data_i-InspectionSpecification && |</NatureOfTest>| &&
                      |<EvaluationMeasurementTechnique>| && lwa_data_i-Specification && |</EvaluationMeasurementTechnique>| &&
                      |<Specified>| && lwa_data_i-InspSpecTargetValue && |</Specified>| &&
                      |<Sample_Qty>| && lwa_data_i-samples && |</Sample_Qty>| &&
                      |<Observed>| && lwa_data_i-observed && |</Observed>| &&
                      |</Item>|.

    ENDLOOP.

    lv_xml2 = lv_xml2 &&
                    |</Measurement>| &&


                    |<Footer>| &&
                    |<PreparedBy>|     && space     && |</PreparedBy>| &&
    |<ApprovedBy>|     && space     && |</ApprovedBy>| &&
                    |</Footer>| &&
                    |</Header>|.

    REPLACE '&' WITH '&#38;' INTO lv_xml2. "TO replace & from String
    ex_base_64 = cl_web_http_utility=>encode_base64( unencoded = lv_xml2 ).

  ENDMETHOD.
ENDCLASS.
