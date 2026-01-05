CLASS zbp_qm_ba_linsp_hdr1 DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zqm_ba_linsp_hdr.

 TYPES: ltt_data_h TYPE TABLE OF ZR_MACH_PL_HD

.
  TYPES: ltt_data_i TYPE TABLE OF ZR_MACH_PL_IT

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



CLASS ZBP_QM_BA_LINSP_HDR1 IMPLEMENTATION.


METHOD    get_pdf_xml.
    DATA: lwa_data   TYPE ZR_MACH_PL_HD,
          lv_subject TYPE string,
          lv_xml2    TYPE string.
    DATA(lv_time) = CONV t( xco_cp=>sy->time( xco_cp_time=>time_zone->user )->as( xco_cp_time=>format->abap )->value )..

    lwa_data = VALUE #( im_data_h[ 1 ] OPTIONAL ).




***    DATA(lv_createdatetime) = |{ lwa_data-Lotcreate }{ lwa_insptime-InspectionLotCreatedOnTime }|.


    DATA(lv_xml1) =  |<?xml version="1.0" encoding="UTF-8"?>| &&

                   |<Root>| &&

                    |<Date>| && lwa_data-CreatedOn && |</Date>| &&
                                    |<Table1>| .


    DATA: lv_count TYPE i.
    data(lft_data) = im_data_i.
****    sort lft_data by Itemno ASCENDING.
data(lft_machine) = lft_data[].
sort lft_machine by machine ASCENDING.
delete lft_machine where machine is INITIAL.
delete ADJACENT DUPLICATES FROM lft_machine COMPARING machine.
    LOOP AT lft_machine INTO DATA(lfs_machine).

      lv_count = lv_count + 1.
      lv_xml2 =       lv_xml2 &&
                      |<Row>| &&
                      |<MachineCode>| && lfs_machine-machine && |</MachineCode>| &&
                        |<Name>| && lfs_machine-machine && |</Name>| &&
                         |<Table2>| .
                      loop at    lft_data into data(lfs_data) WHERE machine = lfs_machine-machine.

                        lv_xml2 =       lv_xml2 &&
                      |<Row>| &&
                      |<SrNo>| && lfs_data-Itemno && |</SrNo>| &&
        |<WorkOrder>| && lfs_data-workorder && |</WorkOrder>| &&
         |<DistributionChannel>| && lfs_data-distributionchannel && |</DistributionChannel>| &&
         |<HardnessSpec>| && lfs_data-hardness && |</HardnessSpec>| &&
         |<CatalogCode>| && lfs_data-catalogcode && |</CatalogCode>| &&
         |<Description>| && lfs_data-description && |</Description>| &&
         |<CustomerName>| && lfs_data-customer_name && |</CustomerName>| &&
         |<ToolLayout>| && lfs_data-toollayout && |</ToolLayout>| &&
         |<SksDrgNo>| && lfs_data-sksdrgno && |</SksDrgNo>| &&
         |<RmGradeSize>| && lfs_data-rmgrade && |</RmGradeSize>| &&
***** |<Qty_Nos>| && lfs_data-qty_nos && |</Qty_Nos>| &&
*****         |<Qty_Kgs>| && lfs_data-qty_kgs && |</Qty_Kgs>| &&
         |<Speed_PPM>| && lfs_data-speed && |</Speed_PPM>| &&
                         |</Row>|.

                      ENDLOOP..


            lv_xml2 = lv_xml2 &&  |</Table2>| &&
                      |</Row>|.

    ENDLOOP.

    DATA(lv_xml) =  lv_xml1 && lv_xml2 &&
                    |</Table1>| &&

                    |</Root>|.

    REPLACE '&' WITH '&#38;' INTO lv_xml. "TO replace & from String
    ex_base_64 = cl_web_http_utility=>encode_base64( unencoded = lv_xml ).


  ENDMETHOD.
ENDCLASS.
