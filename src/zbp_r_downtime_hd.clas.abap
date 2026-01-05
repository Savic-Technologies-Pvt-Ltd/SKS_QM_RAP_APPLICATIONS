CLASS zbp_r_downtime_hd DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zr_downtime_hd.

  TYPES: ltt_data_h TYPE TABLE OF ZR_DOWNTIME_HD.
  TYPES: ltt_data_i TYPE TABLE OF ZR_DOWNTIME_IT.
  TYPES: ltt_data_i_i TYPE TABLE OF ZR_DOWNTIME_RE.
  PUBLIC SECTION.
    CLASS-DATA gv_ins_lot TYPE c LENGTH 12.

    CLASS-METHODS get_pdf_xml
      IMPORTING
        im_data_h  TYPE ltt_data_h
        im_data_i  TYPE  ltt_data_i
                ltt_data_i_i  TYPE  ltt_data_i_i

      EXPORTING
        ex_base_64 TYPE   string.
ENDCLASS.



CLASS ZBP_R_DOWNTIME_HD IMPLEMENTATION.


METHOD    get_pdf_xml.
  DATA: lwa_data   TYPE ZR_DOWNTIME_HD,
          lv_subject TYPE string,
          lv_xml2    TYPE string.
    DATA(lv_time) = CONV t( xco_cp=>sy->time( xco_cp_time=>time_zone->user )->as( xco_cp_time=>format->abap )->value )..

    lwa_data = VALUE #( im_data_h[ 1 ] OPTIONAL ).




***    DATA(lv_createdatetime) = |{ lwa_data-Lotcreate }{ lwa_insptime-InspectionLotCreatedOnTime }|.


select single PlantName from I_Plant where plant = @lwa_data-Plant into @data(lv_plant_name) .

    DATA(lv_xml1) =  |<?xml version="1.0" encoding="UTF-8"?>| &&

                   |<Root>| &&

                    |<RunDate>| && sy-datum && |</RunDate>| &&
                                        |<RunTime>| && sy-datum && |</RunTime>| &&
                                        |<FromTime>| && sy-datum && |</FromTime>| &&
                                        |<Plant>| && lwa_data-Plant && '-' && lv_plant_name && |</Plant>| &&

                                    |<Table1>| .


    DATA: lv_count TYPE i.
    data(lft_data) = im_data_i.
    data(lft_data_remarks) = im_data_i.
    sort lft_data by Workcenter ASCENDING.
    delete ADJACENT DUPLICATES FROM lft_data COMPARING workcenter.
    LOOP AT lft_data INTO DATA(lfs_machine).

      lv_count = lv_count + 1.
      lv_xml2 =       lv_xml2 &&
                      |<Row>| &&
                      |<MachineCode>| && lfs_machine-Workcenter && |</MachineCode>| &&
                        |<Name>| && lfs_machine-Workcentername && |</Name>| &&
                        |<TotalNPTime>| && lfs_machine-ztotalnonprodmin  && |</TotalNPTime>| &&
                        |<TotalAvlTime>| && lfs_machine-totalprodmin  && |</TotalAvlTime>| &&

                         |<Table2>| .
        loop at ltt_data_i_i into data(lfs_data_remarks) where Workcenter = lfs_machine-Workcenter.

        DATA: lv_time1 TYPE sy-uzeit ,  " 08:30:00
      lv_time2 TYPE sy-uzeit ,  " 10:45:15
      lv_diff  TYPE i.                    " Difference in seconds
lv_time1 = lfs_data_remarks-endtime.
lv_time2 = lfs_data_remarks-starttime.
" Convert both times to seconds
DATA(lv_sec1) = ( lv_time1+0(2) * 3600 ) + ( lv_time1+2(2) * 60 ) + lv_time1+4(2).
DATA(lv_sec2) = ( lv_time2+0(2) * 3600 ) + ( lv_time2+2(2) * 60 ) + lv_time2+4(2).

" Calculate difference (absolute)
lv_diff = abs( lv_sec2 - lv_sec1 ).

if lv_diff <> 0.
lv_diff = lv_diff / 60.
endif.
 lv_xml2 =       lv_xml2 &&
                      |<Row>| &&
                      |<DelayCode>| && lfs_data_remarks-remarksid && |</DelayCode>| &&
                                            |<Description>| && lfs_data_remarks-Remarksdesc && |</Description>| &&
                                            |<NpTime>| && lv_diff  && |</NpTime>| &&
                                            |<AvlTime>| && lv_diff  && |</AvlTime>| &&
                          |</Row>| .
*****lfs_data_remarks-endtime - lfs_data_remarks-starttime
ENDLOOP..

            lv_xml2 = lv_xml2 &&  |</Table2>| &&
                      |</Row>|.

    ENDLOOP.

    DATA(lv_xml) =  lv_xml1 && lv_xml2 &&
                    |</Table1>| &&

                    |</Root>|.

    REPLACE '&' WITH '&#38;' INTO lv_xml. "TO replace & from String
    ex_base_64 = cl_web_http_utility=>encode_base64( unencoded = lv_xml ).
endmethod.
ENDCLASS.
