class ZBP_R_MMGATE_HEAD definition

  public

  abstract
  final
  for behavior of ZR_MMGATE_HEAD .

public section.
 TYPES: ltt_data_h TYPE TABLE OF ZR_MMGATE_HEAD.
  TYPES: ltt_data_i TYPE TABLE OF ZR_MMGATE_item.
  CLASS-METHODS get_pdf_xml
      IMPORTING
        im_data_h  TYPE ltt_data_h
        im_data_i  TYPE  ltt_data_i
      EXPORTING
        ex_base_64 TYPE   string.
protected section.
private section.




ENDCLASS.



CLASS ZBP_R_MMGATE_HEAD IMPLEMENTATION.


  METHOD    get_pdf_xml.
    DATA: lwa_data   TYPE ZR_MMGATE_HEAD,
          lv_subject TYPE string,
          lv_xml2    TYPE string.
    DATA(lv_time) = CONV t( xco_cp=>sy->time( xco_cp_time=>time_zone->user )->as( xco_cp_time=>format->abap )->value )..

    lwa_data = VALUE #( im_data_h[ 1 ] OPTIONAL ).




****    DATA(lv_createdatetime) = |{ lwa_data-Lotcreate }{ lwa_insptime-InspectionLotCreatedOnTime }|.


    DATA(lv_xml1) =  |<?xml version="1.0" encoding="UTF-8"?>| &&

                   |<Invoice>| &&
                   |<Header>| &&
|<PlantName>|        && space && |</PlantName>|        &&
|<PlantAddress>|     && space && |</PlantAddress>|     &&
|<ReceiverName>|     && space && |</ReceiverName>|     &&
|<ReceiverAddress>|  && space && |</ReceiverAddress>|  &&
|<ReceiverGSTIN>|    && space && |</ReceiverGSTIN>|    &&
|<InvoiceNo>|        && space && |</InvoiceNo>|        &&
|<InvoiceDate>|      && space && |</InvoiceDate>|      &&
|<VehicleNo>|        && space && |</VehicleNo>|        &&
|<ShippingDate>|     && space && |</ShippingDate>|     &&


                   |</Header>| &&
                   |<ItemTable>|.

    DATA: lv_count TYPE i.
    LOOP AT im_data_i INTO DATA(lwa_data_i).

      lv_count = lv_count + 1.
      lv_xml2 =       lv_xml2 &&
                      |<Item>| &&
                      |<SR_NO>| && lv_count && |</SR_NO>| &&

                      |<SrNo>|          && space && |</SrNo>|          &&
|<LotNo>|         && space && |</LotNo>|         &&
|<Description>|   && space && |</Description>|   &&
|<NoOfPackets>|   && space && |</NoOfPackets>|   &&
|<Quantity>|      && space && |</Quantity>|      &&
|<Weight>|        && space && |</Weight>|        &&
|<Rate>|          && space && |</Rate>|          &&
|<Value>|         && space && |</Value>|         &&


                      |</Item>|.

    ENDLOOP.

    DATA(lv_xml) =  lv_xml1 && lv_xml2 &&
                    |</ItemTable>| &&
                    |<Footer>| &&
                   |<PreparedBy>|   && space && |</PreparedBy>|   &&
|<CIN_No>|       && space && |</CIN_No>|       &&
|<GSTIN>|        && space && |</GSTIN>|        &&


                    |</Footer>| &&
                    |</Invoice>|.

    REPLACE '&' WITH '&#38;' INTO lv_xml. "TO replace & from String
    ex_base_64 = cl_web_http_utility=>encode_base64( unencoded = lv_xml ).

  ENDMETHOD.
ENDCLASS.
