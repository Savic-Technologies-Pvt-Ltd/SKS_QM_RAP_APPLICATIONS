CLASS zbp_r_booking_f_hd DEFINITION PUBLIC ABSTRACT FINAL FOR BEHAVIOR OF zr_booking_f_hd.

 TYPES: ltt_data_h TYPE TABLE OF ZR_BOOKING_F_HD.
  TYPES: ltt_data_i TYPE TABLE OF ZR_BOOKING_F_IT.
  PUBLIC SECTION.
    CLASS-DATA gv_ins_lot TYPE c LENGTH 12.

    CLASS-METHODS get_pdf_xml
      IMPORTING
        im_data_h  TYPE ltt_data_h
        im_data_i  TYPE  ltt_data_i
      EXPORTING
        ex_base_64 TYPE   string.

ENDCLASS.



CLASS ZBP_R_BOOKING_F_HD IMPLEMENTATION.


METHOD    get_pdf_xml.
    DATA: lwa_data   TYPE ZR_BOOKING_F_HD,
          lv_subject TYPE string,
          lv_xml2    TYPE string.
    DATA(lv_time) = CONV t( xco_cp=>sy->time( xco_cp_time=>time_zone->user )->as( xco_cp_time=>format->abap )->value )..

    lwa_data = VALUE #( im_data_h[ 1 ] OPTIONAL ).

DATA(lv_date) = cl_abap_context_info=>get_system_date( ).
    DATA(lv_xml1) =  |<?xml version="1.0" encoding="UTF-8"?>| &&

                   |<Root>| &&
                    |<Header>| &&
                    "|<Date>| && lwa_data-CreatedOn && |</Date>| &&
                    |<BookingFormNo>| && lwa_data-Bookingform && |</BookingFormNo>| &&
                    |<BookingDate>| && lv_date  && |</BookingDate>| &&
                    |</Header>| &&
                                    |<Items>| .


    DATA: lv_count TYPE i.
    data(lft_data) = im_data_i.

    LOOP AT lft_data INTO DATA(lfs_data).

lv_xml2 = lv_xml2 &&
  |<Item>| &&

  |<ItemNo>| && lfs_data-Itemno && |</ItemNo>| &&
|<SalesOrder>| && lfs_data-salesorder_k && |</SalesOrder>| &&
|<SAPMaterialCode>| && lfs_data-Material && |</SAPMaterialCode>| &&
|<PN>| && lfs_data-partnum && |</PN>| &&
|<PO>| && lfs_data-ponum && |</PO>| &&
|<PartDescription>| && lfs_data-partdesc && |</PartDescription>| &&
|<PalletLength>| && lfs_data-palletlen && |</PalletLength>| &&
|<PalletWidth>| && lfs_data-palletwid && |</PalletWidth>| &&
|<PalletHeightIncludedSideCornerTopCover>| && lfs_data-pallethgt && |</PalletHeightIncludedSideCornerTopCover>| &&
|<QtyCarton>| && lfs_data-qtypercarton && |</QtyCarton>| &&
|<ShipmentQtyInPcs>| && lfs_data-shipqty && |</ShipmentQtyInPcs>| &&
|<GrossWTWithPalletInKGS>| && lfs_data-grosswt && |</GrossWTWithPalletInKGS>| &&
|<LoadingPort>| && lfs_data-loadport && |</LoadingPort>| &&
|<FinishWt>| && lfs_data-finishwt && |</FinishWt>| &&
|<NetWt>| && lfs_data-netwt && |</NetWt>| &&
|<TotalBox>| && lfs_data-totbox && |</TotalBox>| &&
|<SingleBoxWeight>| && lfs_data-boxwt && |</SingleBoxWeight>| &&
|<BoxNetWt>| && lfs_data-boxnetwt && |</BoxNetWt>| &&
|<PalletType>| && lfs_data-pallettype && |</PalletType>| &&
|<TotalPallet>| && lfs_data-totpallet && |</TotalPallet>| &&
|<PalletWt>| && lfs_data-palletwt && |</PalletWt>| &&
|<FNLCode>| && lfs_data-fnlcode && |</FNLCode>| &&


  |</Item>| .



    ENDLOOP.

    DATA(lv_xml) =  lv_xml1 && lv_xml2 &&
                    |</Items>| &&

                    |</Root>|.

    REPLACE '&' WITH '&#38;' INTO lv_xml. "TO replace & from String
    ex_base_64 = cl_web_http_utility=>encode_base64( unencoded = lv_xml ).


  ENDMETHOD.
ENDCLASS.
