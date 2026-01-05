CLASS zbp_qm_i_line_insp_new DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zqm_i_line_insp_new.
TYPES: ltt_data_h TYPE TABLE OF ZQM_I_line_insp_NEW


.
  TYPES: ltt_data_i TYPE TABLE OF ZQM_I_line_insp_item_NEW


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



CLASS ZBP_QM_I_LINE_INSP_NEW IMPLEMENTATION.


METHOD    get_pdf_xml.
    DATA: lwa_data   TYPE ZQM_I_line_insp_NEW,
          lv_subject TYPE string,
          lv_xml2    TYPE string.
    DATA(lv_time) = CONV t( xco_cp=>sy->time( xco_cp_time=>time_zone->user )->as( xco_cp_time=>format->abap )->value )..

    lwa_data = VALUE #( im_data_h[ 1 ] OPTIONAL ).




***    DATA(lv_createdatetime) = |{ lwa_data-Lotcreate }{ lwa_insptime-InspectionLotCreatedOnTime }|.


    DATA(lv_xml1) =
      |<?xml version="1.0" encoding="UTF-8"?>| &&

      |<Root>| &&

      |<Date>| && lwa_data-CreatedOn && |</Date>| &&
      |<Shift>| && lwa_data-Shift && |</Shift>| &&
      |<LotNo>| && lwa_data-Batch && |</LotNo>| &&
      |<CoilNo>| && space && |</CoilNo>| &&
      |<DocumentNo>| && lwa_data-Inspectionlot && |</DocumentNo>| &&
      |<DocDate>| && space && |</DocDate>| &&
      |<Product>| && lwa_data-Material && |</Product>| &&
      |<MachineName>| && lwa_data-Workcentertext && |</MachineName>| &&
      |<PartNo>| && lwa_data-Partno && |</PartNo>| &&
      |<OperatorName>| && lwa_data-Operatorname && |</OperatorName>| &&
      |<DrgNo>| && lwa_data-Drgno && |</DrgNo>| &&
      |<RMSpecification>| && lwa_data-RmSpecification && |</RMSpecification>| &&
      |<OperationNo>| && space && |</OperationNo>| &&
      |<OperationDate>| && space && |</OperationDate>| &&
      |<Inspector>| && space && |</Inspector>| &&

      |<RawMaterialCoilCondition>| && space && |</RawMaterialCoilCondition>| &&
      |<Remarks>| && space && |</Remarks>| &&

      |<DMT>| && lwa_data-Dmt && |</DMT>| &&
      |<VCD>| && lwa_data-Vcd && |</VCD>| &&
      |<DIAL>| && lwa_data-dial && |</DIAL>| &&
      |<PP>| && lwa_data-Pp && |</PP>| &&
      |<DPMT>| && lwa_data-Dpmt && |</DPMT>| &&
      |<GaugeNo>| && lwa_data-Gaugenogo && |</GaugeNo>| &&
      |<Other>| && lwa_data-Other && |</Other>| &&

      |<Opt1>| && space && |</Opt1>| &&
      |<Opt2>| && space && |</Opt2>| &&
      |<Opt3>| && space && |</Opt3>| &&
      |<Opt4>| && space && |</Opt4>| &&
      |<Opt5>| && space && |</Opt5>| &&
      |<Opt6>| && space && |</Opt6>| &&
      |<Opt7>| && space && |</Opt7>| &&
      |<Opt8>| && space && |</Opt8>| &&
      |<Opt9>| && space && |</Opt9>| &&
      |<Opt10>| && space && |</Opt10>| &&
      |<Opt11>| && space && |</Opt11>| &&

      |<Obs1Time>| && space && |</Obs1Time>| &&
      |<Obs2Time>| && space && |</Obs2Time>| &&
      |<Obs3Time>| && space && |</Obs3Time>| &&
      |<Obs4Time>| && space && |</Obs4Time>| &&
      |<Obs5Time>| && space && |</Obs5Time>| &&
      |<Obs6Time>| && space && |</Obs6Time>| &&
      |<Obs7Time>| && space && |</Obs7Time>| &&
      |<Obs8Time>| && space && |</Obs8Time>| &&
      |<Obs9Time>| && space && |</Obs9Time>| &&
      |<Obs10Time>| && space && |</Obs10Time>| &&
      |<Obs11Time>| && space && |</Obs11Time>| &&

      |<Table>| .


DATA: lv_count TYPE i.
lv_count = 1.
DATA(lft_data) = im_data_i.
**** sort lft_data by Itemno ASCENDING.

DATA(lft_machine) = lft_data[].
* sort lft_machine by machine ASCENDING.
* delete lft_machine where machine is INITIAL.
* delete ADJACENT DUPLICATES FROM lft_machine COMPARING machine.

LOOP AT im_data_i INTO DATA(lfs_item).

  lv_xml1 = lv_xml1 &&
            |<Item>| &&

            |<Sr>| && lv_count && |</Sr>| &&
            |<Characteristics>| && space && |</Characteristics>| &&
            |<Specifications>| && lfs_item-InspectionSpecification && |</Specifications>| &&
            |<Min>| && lfs_item-InspSpecLowerLimit && |</Min>| &&
            |<Max>| && lfs_item-InspSpecUpperLimit && |</Max>| &&
            |<LeastCount>| && space && |</LeastCount>| &&

            |<Obs1>| && lfs_item-Result1 && |</Obs1>| &&
            |<Obs2>| && lfs_item-Result2 && |</Obs2>| &&
            |<Obs3>| && lfs_item-Result3 && |</Obs3>| &&
            |<Obs4>| && lfs_item-Result4 && |</Obs4>| &&
            |<Obs5>| && lfs_item-Result5 && |</Obs5>| &&
            |<Obs6>| && lfs_item-Result6 && |</Obs6>| &&
            |<Obs7>| && lfs_item-Result7 && |</Obs7>| &&
            |<Obs8>| && lfs_item-Result8 && |</Obs8>| &&
            |<Obs9>| && lfs_item-Result9 && |</Obs9>| &&
            |<Obs10>| && lfs_item-Result10 && |</Obs10>| &&
            |<Obs11>| && lfs_item-Result10 && |</Obs11>| &&

            |</Item>|.

            lv_count += 1.

ENDLOOP.

DATA(lv_xml) =
      lv_xml1 && lv_xml2 &&
      |</Table>| &&
      |</Root>|.


    REPLACE '&' WITH '&#38;' INTO lv_xml. "TO replace & from String
    ex_base_64 = cl_web_http_utility=>encode_base64( unencoded = lv_xml ).


  ENDMETHOD.
ENDCLASS.
