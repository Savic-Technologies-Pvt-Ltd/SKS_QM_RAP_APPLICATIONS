CLASS zbp_r_setup_app_head DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zr_setup_app_head.

  TYPES: ltt_data_h TYPE TABLE OF ZR_SETUP_APP_HEAD
.
  TYPES: ltt_data_i TYPE TABLE OF ZR_SETUP_APP_ITEM
.
  PUBLIC SECTION.
    CLASS-DATA gv_ins_lot TYPE c LENGTH 12.

    CLASS-METHODS get_pdf_xml
      IMPORTING
        im_data_h  TYPE ltt_data_h
        im_data_i  TYPE  ltt_data_i
      EXPORTING
        ex_base_64 TYPE   string.

ENDCLASS.



CLASS ZBP_R_SETUP_APP_HEAD IMPLEMENTATION.


METHOD    get_pdf_xml.
    DATA: lwa_data   TYPE ZR_SETUP_APP_HEAD,
          lv_subject TYPE string,
          lv_xml2    TYPE string.
    DATA(lv_time) = CONV t( xco_cp=>sy->time( xco_cp_time=>time_zone->user )->as( xco_cp_time=>format->abap )->value )..

    lwa_data = VALUE #( im_data_h[ 1 ] OPTIONAL ).




***    DATA(lv_createdatetime) = |{ lwa_data-Lotcreate }{ lwa_insptime-InspectionLotCreatedOnTime }|.


    DATA(lv_xml1) =  |<?xml version="1.0" encoding="UTF-8"?>| &&

                   |<PPSetup>| &&
                   |<Header>| &&
                    |<Date>| && lwa_data-zdate && |</Date>| &&
|<Shift>| && lwa_data-dateshift && |</Shift>| &&
|<Machine>| && lwa_data-machine && |</Machine>| &&
|<PartNo>| && lwa_data-Partno && |</PartNo>| &&
|<PartDescription>| && lwa_data-partdesc && |</PartDescription>| &&
|<SKSDrgNo>| && lwa_data-Drgno && |</SKSDrgNo>| &&
|<RawMaterialSpec>| && lwa_data-rawmatspec && |</RawMaterialSpec>| &&
|<LotNo>| && lwa_data-Batch && |</LotNo>| &&
|<Operator>| && lwa_data-operator && |</Operator>| &&
|<CurrentOperationNumber>| && lwa_data-currentoperationno && |</CurrentOperationNumber>| &&
|<OperationDetails>| && lwa_data-operationdetails && |</OperationDetails>| &&
|<Inspector>| && lwa_data-inspector && |</Inspector>| &&
|<PreviousOperation>| && lwa_data-previousoperation && |</PreviousOperation>| &&
|<NextOperation>| && lwa_data-nextoperation && |</NextOperation>| &&


                   |</Header>| &&
                   |<Items>| .

    DATA: lv_count TYPE i.
    data(lft_data) = im_data_i.
    sort lft_data by Itemno ASCENDING.
    LOOP AT lft_data INTO DATA(lwa_data_i).

      lv_count = lv_count + 1.
      lv_xml2 =       lv_xml2 &&
                      |<Item>| &&
                      |<SrNo>| && lv_count && |</SrNo>| &&
                      |<Parameter>| && lwa_data_i-Parameters && |</Parameter>| &&
                      |<Specification>| && lwa_data_i-Specifications && |</Specification>| &&
                                            |<MMR>| && lwa_data_i-Mmr && |</MMR>| &&


|<Observation1>| && lwa_data_i-Obs1_T && |</Observation1>| &&
|<Observation2>| && lwa_data_i-Obs2_T && |</Observation2>| &&
|<Observation3>| && lwa_data_i-Obs3_T && |</Observation3>| &&
|<Observation4>| && lwa_data_i-Obs4_T && |</Observation4>| &&
|<Observation5>| && lwa_data_i-Obs5_T && |</Observation5>| &&



                      |</Item>|.

    ENDLOOP.

    DATA(lv_xml) =  lv_xml1 && lv_xml2 &&
                    |</Items>| &&
                    |<Footer>| &&
                    |<QAToProd>| &&  lwa_data-submittedtoprd && |</QAToProd>| &&
                    |<QATime>| && lwa_data-submittedtoprd_time && |</QATime>| &&
                    |<ProdToQA>| &&  lwa_data-submittedtoqa && |</ProdToQA>| &&
                    |<ProdTime>| &&  lwa_data-submittedtoqa_time && |</ProdTime>| &&
                    |<Remarks>| && lwa_data-remarks && |</Remarks>| &&
                    |<InspectBy>| && lwa_data-inspectby && |</InspectBy>| &&
                    |</Footer>| &&
                    |</PPSetup>|.

    REPLACE '&' WITH '&#38;' INTO lv_xml. "TO replace & from String
    ex_base_64 = cl_web_http_utility=>encode_base64( unencoded = lv_xml ).


  ENDMETHOD.
ENDCLASS.
