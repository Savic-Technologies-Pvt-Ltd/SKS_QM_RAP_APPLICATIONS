CLASS zbp_qm_i_pdirheader_new DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zqm_i_pdirheader_new.
 TYPES: ltt_data_h TYPE TABLE OF ZQM_BA_PDIRHeader.
  TYPES: ltt_data_i TYPE TABLE OF zqm_pdir_specification_list.
  PUBLIC SECTION.
    CLASS-DATA gv_ins_lot TYPE c LENGTH 12.

    CLASS-METHODS get_pdf_xml
      IMPORTING
        im_data_h  TYPE ltt_data_h
        im_data_i  TYPE  ltt_data_i
      EXPORTING
        ex_base_64 TYPE   string.
ENDCLASS.



CLASS ZBP_QM_I_PDIRHEADER_NEW IMPLEMENTATION.


 METHOD    get_pdf_xml.
    DATA: lwa_data   TYPE ZQM_BA_PDIRHeader,
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

                   |<PDIR>| &&
                   |<Header>| &&
                     |<PART_NAME>| && lwa_data-MaterialDescription && |</PART_NAME>| &&
  |<CUSTOMER>| && lwa_data-CustomerName && |</CUSTOMER>| &&
  |<PART_NO>| && lwa_data-partno && |</PART_NO>| &&
  |<CERTIFICATE_NO>| && lwa_data-Inspectionlot && |</CERTIFICATE_NO>| &&
  |<LOT_NO>| && lwa_data-batch && |</LOT_NO>| &&
  |<INV_NO>| && lwa_data-inv_no && |</INV_NO>| &&
  |<PO_NO>| && lwa_data-po_no && |</PO_NO>| &&
  |<SKS_DRAWING_NO>| && lwa_data-drgno && |</SKS_DRAWING_NO>| &&
  |<QTY_CHKD>| && lwa_data-qty_chkd && |</QTY_CHKD>| &&
  |<INV_DATE>| && lwa_data-inv_date && |</INV_DATE>| &&


  |<CUSTOMER_DRAWING_REV_NO>| && lwa_data-cust_draw && |</CUSTOMER_DRAWING_REV_NO>| &&
  |<BASED_ON>| && lwa_data-basedon && |</BASED_ON>| &&
  |<INV_QTY>| && lwa_data-inv_qty && |</INV_QTY>| &&
  |<SKS_DRAWING_REV_NO_G>| && lwa_data-sks_draw && |</SKS_DRAWING_REV_NO_G>| &&

                   |</Header>| &&
                   |<Items>|.

    DATA: lv_count TYPE i.
    LOOP AT im_data_i INTO DATA(lwa_data_i).
      REPLACE ALL OCCURRENCES OF '-' IN lwa_data_i-InspSpecLowerLimit WITH ' '.
      REPLACE ALL OCCURRENCES OF '-' IN lwa_data_i-InspSpecUpperLimit WITH ' '.
      lv_count = lv_count + 1.
      lv_xml2 =       lv_xml2 &&
                      |<Item>| &&
                      |<SR_NO>| && lv_count && |</SR_NO>| &&
                      |<CHARACTERISTICS>| && lwa_data_i-InspectionSpecification && |</CHARACTERISTICS>| &&

                      |<MIN>|      && lwa_data_i-InspSpecLowerLimit   && |</MIN>| &&
   |<MAX>|      && lwa_data_i-InspSpecUpperLimit   && |</MAX>| &&
   |<OBS1>|     && lwa_data_i-Result1  && |</OBS1>| &&
   |<OBS2>|     && lwa_data_i-Result2  && |</OBS2>| &&
   |<OBS3>|     && lwa_data_i-Result3  && |</OBS3>| &&
   |<OBS4>|     && lwa_data_i-Result4  && |</OBS4>| &&
   |<OBS5>|     && lwa_data_i-Result5  && |</OBS5>| &&
   |<OBS6>|     && lwa_data_i-Result6 && |</OBS6>| &&
   |<OBS7>|     && lwa_data_i-Result7  && |</OBS7>| &&
   |<OBS8>|     && lwa_data_i-Result8  && |</OBS8>| &&
   |<OBS9>|     && lwa_data_i-Result9  && |</OBS9>| &&
   |<OBS10>|    && lwa_data_i-Result10 && |</OBS10>| &&
   |<OBS11>|    && lwa_data_i-Result11 && |</OBS11>| &&
   |<OBS12>|    && lwa_data_i-Result12 && |</OBS12>| &&
   |<OBS13>|    && lwa_data_i-Result13 && |</OBS13>| &&
   |<OBS14>|    && lwa_data_i-Result14 && |</OBS14>| &&
   |<OBS15>|    && lwa_data_i-Result15 && |</OBS15>| &&
   |<OBS16>|    && lwa_data_i-Result16 && |</OBS16>| &&
   |<REMARK>|   && lwa_data_i-remark && |</REMARK>| &&

                      |</Item>|.

    ENDLOOP.

    DATA(lv_xml) =  lv_xml1 && lv_xml2 &&
                    |</Items>| &&
                    |<Footer>| &&
                    |<VISUAL_CHECK>|     && lwa_data-checked_visually     && |</VISUAL_CHECK>| &&
   |<VCD>|              && lwa_data-vcd              && |</VCD>| &&
   |<DMT>|              && lwa_data-dmt              && |</DMT>| &&
   |<DPMT>|             && lwa_data-dpmt             && |</DPMT>| &&
   |<OIM>|              && lwa_data-Other             && |</OIM>| &&
   |<GO>|               && lwa_data-Gaugenogo             && |</GO>| &&
   |<NO_GO>|            && lwa_data-Nogo          && |</NO_GO>| &&
   |<PROFILE_PROJECTOR>| && lwa_data-pp && |</PROFILE_PROJECTOR>| &&
   |<PLUNGER>|          && lwa_data-dial          && |</PLUNGER>| &&
   |<LEVER>|            && lwa_data-lever           && |</LEVER>| &&
   |<REMARKS>|          && lwa_data-remark          && |</REMARKS>| &&
   |<MFG_DATE>|             && lwa_data-lotcreate             && |</MFG_DATE>| &&
   |<PREPARED_BY>|      && lwa_data-reported_by     && |</PREPARED_BY>| &&
   |<APPROVED_BY>|      && lwa_data-approved_by     && |</APPROVED_BY>| &&
                    |</Footer>| &&
                    |</PDIR>|.

    REPLACE '&' WITH '&#38;' INTO lv_xml. "TO replace & from String
    ex_base_64 = cl_web_http_utility=>encode_base64( unencoded = lv_xml ).

  ENDMETHOD.
ENDCLASS.
