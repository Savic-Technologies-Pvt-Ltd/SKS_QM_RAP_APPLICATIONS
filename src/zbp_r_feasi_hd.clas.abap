CLASS zbp_r_feasi_hd DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zr_feasi_hd.

  TYPES: ltt_data_h TYPE TABLE OF ZR_FEASI_HD.
  TYPES: ltt_data_i TYPE TABLE OF ZR_FEASI_IT."iTEM
  TYPES: ltt_data_op TYPE TABLE OF ZR_FEASI_OP"Operation
.
  TYPES: ltt_data_rs TYPE TABLE OF ZR_FEASI_RS." High ,low, medium
  PUBLIC SECTION.
    CLASS-DATA gv_ins_lot TYPE c LENGTH 12.

    CLASS-METHODS get_pdf_xml
      IMPORTING
        im_data_h  TYPE ltt_data_h
        im_data_i  TYPE  ltt_data_i
        im_data_op  TYPE  ltt_data_op
        im_data_rs  TYPE  ltt_data_rs

      EXPORTING
        ex_base_64 TYPE   string.


ENDCLASS.



CLASS ZBP_R_FEASI_HD IMPLEMENTATION.


METHOD    get_pdf_xml.
    DATA: lwa_data   TYPE ZR_FEASI_HD,
          lv_subject TYPE string,
          lv_xml2    TYPE string.
    DATA(lv_time) = CONV t( xco_cp=>sy->time( xco_cp_time=>time_zone->user )->as( xco_cp_time=>format->abap )->value )..

    lwa_data = VALUE #( im_data_h[ 1 ] OPTIONAL ).




***    DATA(lv_createdatetime) = |{ lwa_data-Lotcreate }{ lwa_insptime-InspectionLotCreatedOnTime }|.


    DATA(lv_xml1) =  |<?xml version="1.0" encoding="UTF-8"?>| &&
    |<FeasibilityReview>| &&



                    |<feas_no>| && lwa_data-Feasibilityno && |</feas_no>|
             && |<rev_no>| && space && |</rev_no>|
             && |<feas_date>| && lwa_data-CreatedOn && |</feas_date>|
             && |<enq_no>| && lwa_data-enquiry_no && |</enq_no>|
             && |<customer>| && lwa_data-customer && |</customer>|
             && |<part_desc>| && lwa_data-part_description && |</part_desc>|
             && |<part_no>| && lwa_data-part_no && |</part_no>|
             && |<grade>| && lwa_data-grade && |</grade>|
             && |<surface_finish>| && lwa_data-surface_finish && |</surface_finish>|
             && |<vol_per_month>| && lwa_data-volume && |</vol_per_month>|
             && |<cust_input>| && lwa_data-provided_by && |</cust_input>|
             && |<application>| && lwa_data-application && |</application>|
             && |<other_info>| && lwa_data-other && |</other_info>|
             && |<review_date>| && lwa_data-ChangedOn && |</review_date>|
             && |<sales_coord>| && lwa_data-sales_coord_name && |</sales_coord>|
             && |<gauge_req>| && lwa_data-req_of_new_guage && |</gauge_req>|
                && |<raw_material>| && lwa_data-raw_material && |</raw_material>|
                && |<wire_dia>| && lwa_data-wire_dia && |</wire_dia>|
                && |<surface_area>| && lwa_data-surface_area && |</surface_area>|
                && |<input_wt>| && lwa_data-input_weight && |</input_wt>|
                && |<finish_wt>| && lwa_data-finish_weight && |</finish_wt>|
                && |<eng_name>| && lwa_data-engg_name && |</eng_name>|
                && |<sales_name>| && lwa_data-sales_mem_name && |</sales_name>| &&



    |<yes_no_1>|  && value #( im_data_i[ Itemno =  1 ]-yes_no optional )  && |</yes_no_1>| &&
    |<yes_no_2>|  && value #( im_data_i[ Itemno = 2 ]-yes_no optional )  && |</yes_no_2>| &&
    |<yes_no_3>|  && value #( im_data_i[ Itemno = 3 ]-yes_no optional )  && |</yes_no_3>| &&
    |<yes_no_4>|  && value #( im_data_i[ Itemno = 4 ]-yes_no optional )  && |</yes_no_4>| &&
    |<yes_no_5>|  && value #( im_data_i[ Itemno = 5 ]-yes_no optional )  && |</yes_no_5>| &&
    |<ifyes_5>|   && value #( im_data_i[ Itemno = 6 ]-yes_no optional )  && |</ifyes_5>| &&
    |<yes_no_6>|  && value #( im_data_i[ Itemno =  7 ]-yes_no optional )   && |</yes_no_6>| &&
    |<yes_no_7>|  && value #( im_data_i[ Itemno = 8 ]-yes_no optional )  && |</yes_no_7>| &&
    |<yes_no_8>|  && value #( im_data_i[ Itemno = 9 ]-yes_no optional )  && |</yes_no_8>| &&
    |<yes_no_9>|  && value #( im_data_i[ Itemno = 10 ]-yes_no optional )  && |</yes_no_9>| &&
    |<yes_no_10>| && value #( im_data_i[ Itemno = 11 ]-yes_no optional ) && |</yes_no_10>| &&
    |<yes_no_11>| && value #( im_data_i[ Itemno = 12 ]-yes_no optional ) && |</yes_no_11>| &&
    |<yes_no_12>| && value #( im_data_i[ Itemno = 13 ]-yes_no optional ) && |</yes_no_12>| &&
    |<yes_no_13>| && value #( im_data_i[ Itemno = 14 ]-yes_no optional ) && |</yes_no_13>| &&
    |<yes_no_14>| && value #( im_data_i[ Itemno = 15 ]-yes_no optional ) && |</yes_no_14>| &&
    |<ifyes_14>|  && value #( im_data_i[ Itemno = 15 ]-yes_no optional )  && |</ifyes_14>| &&
    |<yes_no_15>| && value #( im_data_i[ Itemno = 16 ]-yes_no optional ) && |</yes_no_15>| &&
    |<yes_no_16>| && value #( im_data_i[ Itemno = 17 ]-yes_no optional ) && |</yes_no_16>| &&
    |<yes_no_17>| && value #( im_data_i[ Itemno = 18 ]-yes_no optional ) && |</yes_no_17>| &&

|<clarification>| && lwa_data-clarificationfield && |</clarification>|.

IF  lwa_data-conclusion  = 'Feasibile'.
    lv_xml1 = lv_xml1 && |<feasibile>| && '1' && |</feasibile>|.
ENDIF.
IF  lwa_data-conclusion  = 'Feasibile w.r.t clarification'.
    lv_xml1 = lv_xml1 && |<feasibile_clarify>| && '1' && |</feasibile_clarify>|.
ENDIF.
IF  lwa_data-conclusion  = 'Not Feasibile'.
    lv_xml1 = lv_xml1 && |<not_feasibile>| && '1' && |</not_feasibile>|.
ENDIF.


* &&
*
*        |<machine_18_1>|  && value #( im_data_op[ Itemno = 1 ]-Machine optional )  && |</machine_18_1>| &&
*|<remark_18_1>|  && value #( im_data_op[ Itemno = 1 ]-Remarks optional )  && |</remark_18_1>| &&
*
*|<machine_18_2>|  && value #( im_data_op[ Itemno = 2 ]-Machine optional )  && |</machine_18_2>| &&
*|<remark_18_2>|  && value #( im_data_op[ Itemno = 2 ]-Remarks optional )  && |</remark_18_2>| &&
*
*|<machine_18_3>|  && value #( im_data_op[ Itemno = 3 ]-Machine optional )  && |</machine_18_3>| &&
*|<remark_18_3>|  && value #( im_data_op[ Itemno = 3 ]-Remarks optional )  && |</remark_18_3>| &&
*
*|<machine_18_4>|  && value #( im_data_op[ Itemno = 4 ]-Machine optional )  && |</machine_18_4>| &&
*|<remark_18_4>|  && value #( im_data_op[ Itemno = 4 ]-Remarks optional )  && |</remark_18_4>| &&
*
*|<machine_18_5>|  && value #( im_data_op[ Itemno = 5 ]-Machine optional )  && |</machine_18_5>| &&
*|<remark_18_5>|  && value #( im_data_op[ Itemno = 5 ]-Remarks optional )  && |</remark_18_5>| &&
*
*|<machine_18_6>|  && value #( im_data_op[ Itemno = 6 ]-Machine optional )  && |</machine_18_6>| &&
*|<remark_18_6>|  && value #( im_data_op[ Itemno = 6 ]-Remarks optional )  && |</remark_18_6>| .

lv_xml1 = lv_xml1 && |<process_details>| .
data(lft_im_data_op) = im_data_op.
sort lft_im_data_op by itemnumber ASCENDING.
LOOP AT lft_im_data_op INTO DATA(LFS_data_op).
lv_xml1 = lv_xml1 && |<process_row>| .




    lv_xml1 = lv_xml1 && |<sr_no>| && |{  LFS_data_op-itemnumber ALPHA = out }| && |</sr_no>|.
    lv_xml1 = lv_xml1 && |<operation_sequence>| && LFS_data_op-operation && |</operation_sequence>|.
    lv_xml1 = lv_xml1 && |<machine>| && LFS_data_op-Machine && |</machine>|.
    lv_xml1 = lv_xml1 && |<remark>| && LFS_data_op-Remarks && |</remark>|.


    lv_xml1 = lv_xml1 && |</process_row>| .
    CLEAR:LFS_data_op.
ENDLOOP.
lv_xml1 = lv_xml1 && |</process_details>| .
IF to_upper( value #( im_data_rs[ Itemno = 1 ]-high_value OPTIONAL ) ) = 'X'.
    lv_xml1 = lv_xml1 && |<proc_risk>| && 'High' && |</proc_risk>|.
ENDIF.
IF to_upper( value #( im_data_rs[ Itemno = 1 ]-medium_value OPTIONAL ) ) = 'X'.
    lv_xml1 = lv_xml1 && |<proc_risk>| && 'Medium' && |</proc_risk>|.
ENDIF.
IF to_upper( value #( im_data_rs[ Itemno = 1 ]-low_value OPTIONAL ) ) = 'X'.
    lv_xml1 = lv_xml1 && |<proc_risk>| && 'Low' && |</proc_risk>|.
ENDIF.

IF to_upper( value #( im_data_rs[ Itemno = 2 ]-high_value OPTIONAL ) ) = 'X'.
    lv_xml1 = lv_xml1 && |<prod_cat>| && 'High' && |</prod_cat>|.
ENDIF.
IF to_upper( value #( im_data_rs[ Itemno = 2 ]-medium_value OPTIONAL ) ) = 'X'.
    lv_xml1 = lv_xml1 && |<prod_cat>| && 'Medium' && |</prod_cat>|.
ENDIF.
IF to_upper( value #( im_data_rs[ Itemno = 2 ]-low_value OPTIONAL ) ) = 'X'.
    lv_xml1 = lv_xml1 && |<prod_cat>| && 'Low' && |</prod_cat>|.
ENDIF.

IF to_upper( value #( im_data_rs[ Itemno = 3 ]-high_value OPTIONAL ) ) = 'X'.
    lv_xml1 = lv_xml1 && |<meas_risk>| && 'High' && |</meas_risk>|.
ENDIF.
IF to_upper( value #( im_data_rs[ Itemno = 3 ]-medium_value OPTIONAL ) ) = 'X'.
    lv_xml1 = lv_xml1 && |<meas_risk>| && 'Medium' && |</meas_risk>|.
ENDIF.
IF to_upper( value #( im_data_rs[ Itemno = 3 ]-low_value OPTIONAL ) ) = 'X'.
    lv_xml1 = lv_xml1 && |<meas_risk>| && 'Low' && |</meas_risk>|.
ENDIF.

IF to_upper( value #( im_data_rs[ Itemno = 4 ]-high_value OPTIONAL ) ) = 'X'.
    lv_xml1 = lv_xml1 && |<invest_add>| && 'High' && |</invest_add>|.
ENDIF.
IF to_upper( value #( im_data_rs[ Itemno = 4 ]-medium_value OPTIONAL ) ) = 'X'.
    lv_xml1 = lv_xml1 && |<invest_add>| && 'Medium' && |</invest_add>|.
ENDIF.
IF to_upper( value #( im_data_rs[ Itemno = 4 ]-low_value OPTIONAL ) ) = 'X'.
    lv_xml1 = lv_xml1 && |<invest_add>| && 'Low' && |</invest_add>|.
ENDIF.

IF to_upper( value #( im_data_rs[ Itemno = 5 ]-high_value OPTIONAL ) ) = 'X'.
    lv_xml1 = lv_xml1 && |<tool_invest>| && 'High' && |</tool_invest>|.
ENDIF.
IF to_upper( value #( im_data_rs[ Itemno = 5 ]-medium_value OPTIONAL ) ) = 'X'.
    lv_xml1 = lv_xml1 && |<tool_invest>| && 'Medium' && |</tool_invest>|.
ENDIF.
IF to_upper( value #( im_data_rs[ Itemno = 5 ]-low_value OPTIONAL ) ) = 'X'.
    lv_xml1 = lv_xml1 && |<tool_invest>| && 'Low' && |</tool_invest>|.
ENDIF.

IF to_upper( value #( im_data_rs[ Itemno = 6 ]-high_value OPTIONAL ) ) = 'X'.
    lv_xml1 = lv_xml1 && |<compliance_req>| && 'High' && |</compliance_req>|.
ENDIF.
IF to_upper( value #( im_data_rs[ Itemno = 6 ]-medium_value OPTIONAL ) ) = 'X'.
    lv_xml1 = lv_xml1 && |<compliance_req>| && 'Medium' && |</compliance_req>|.
ENDIF.
IF to_upper( value #( im_data_rs[ Itemno = 6 ]-low_value OPTIONAL ) ) = 'X'.
    lv_xml1 = lv_xml1 && |<compliance_req>| && 'Low' && |</compliance_req>|.
ENDIF.

IF to_upper( value #( im_data_rs[ Itemno = 7 ]-high OPTIONAL ) ) = 'X'.
    lv_xml1 = lv_xml1 && |<price_pressure>| && 'High' && |</price_pressure>|.
ENDIF.
IF to_upper( value #( im_data_rs[ Itemno = 7 ]-medium_value OPTIONAL ) ) = 'X'.
    lv_xml1 = lv_xml1 && |<price_pressure>| && 'Medium' && |</price_pressure>|.
ENDIF.
IF to_upper( value #( im_data_rs[ Itemno = 7 ]-low_value OPTIONAL ) ) = 'X'.
    lv_xml1 = lv_xml1 && |<price_pressure>| && 'Low' && |</price_pressure>|.
ENDIF.


*|<prod_cat>|  && value #( im_data_rs[ 1 ]-High optional )  && |</prod_cat>| &&
*|<meas_risk>|  && value #( im_data_rs[ 1 ]-High optional )  && |</meas_risk>| &&
*|<invest_add>|  && value #( im_data_rs[ 1 ]-High optional )  && |</invest_add>| &&
*|<tool_invest>|  && value #( im_data_rs[ 1 ]-High optional )  && |</tool_invest>| &&
*|<compliance_req>|  && value #( im_data_rs[ 1 ]-High optional )  && |</compliance_req>| &&
*|<price_pressure>|  && value #( im_data_rs[ 1 ]-High optional )  && |</price_pressure>| .



    DATA: lv_count TYPE i.
    data(lft_data) = im_data_i.
****    sort lft_data by Itemno ASCENDING.




    DATA(lv_xml) =  lv_xml1 &&
    |</FeasibilityReview>| .
    REPLACE '&' WITH '&#38;' INTO lv_xml. "TO replace & from String
    ex_base_64 = cl_web_http_utility=>encode_base64( unencoded = lv_xml ).


  ENDMETHOD.
ENDCLASS.
