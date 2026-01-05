CLASS lhc_zr_booking_f_it DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS calculateFinishWt FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZR_BOOKING_F_IT~calculateFinishWt.
    METHODS calculateTotalBox FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZR_BOOKING_F_IT~calculateTotalBox.
    METHODS calculateBoxWeight FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZR_BOOKING_F_IT~calculateBoxWeight.
    METHODS calculategrossweight FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZR_BOOKING_F_IT~calculategrossweight.
    METHODS calculatevarianceqty FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZR_BOOKING_F_IT~calculatevarianceqty.

ENDCLASS.

CLASS lhc_zr_booking_f_it IMPLEMENTATION.

  METHOD calculateFinishWt.

   READ ENTITIES OF ZR_BOOKING_F_HD

 IN LOCAL MODE
      ENTITY zr_booking_f_it
      FIELDS ( netwt shipqty )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_items).

    LOOP AT lt_items INTO DATA(ls_item).

if ls_item-shipqty is not INITIAL and ls_item-shipqty <> 0.
      ls_item-finishwt =
        ls_item-netwt / ls_item-shipqty.
    shift ls_item-finishwt LEFT DELETING LEADING space.
      MODIFY ENTITIES OF ZR_BOOKING_F_HD IN LOCAL MODE
        ENTITY zr_booking_f_it
        UPDATE FIELDS ( finishwt )
        WITH VALUE #(
          ( %tky = ls_item-%tky
            finishwt = ls_item-finishwt )
        ).
endif.
    ENDLOOP.
  ENDMETHOD.

  METHOD calculateTotalBox.
     READ ENTITIES OF ZR_BOOKING_F_HD

 IN LOCAL MODE
      ENTITY zr_booking_f_it
      FIELDS ( netwt shipqty  qtypercarton )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_items).

    LOOP AT lt_items INTO DATA(ls_item).

    DATA(lv_salesorder) = |{ ls_item-salesorder_k ALPHA = IN }|.
    DATA(lv_salesorderitem) = |{ ls_item-Itemno ALPHA = IN }|.
    select b~YY1_SD_No_Box_Pallet_SDI
    from i_salesorder as a inner join i_salesdocumentitem as b on b~SalesDocument = a~salesorder
    where a~salesorder = @lv_salesorder
    and b~SalesDocumentItem = @lv_salesorderitem
    into @data(ls_box_per_pallet).

    ENDSELECT.

if ls_item-qtypercarton is not INITIAL and ls_item-qtypercarton <> 0.
      ls_item-totbox =
        ls_item-shipqty / ls_item-qtypercarton.

        if ls_box_per_pallet is not INITIAL and ls_box_per_pallet <> 0.
            ls_item-totpallet = ceil( ls_item-totbox / ls_box_per_pallet ).
        endif.

    shift ls_item-finishwt LEFT DELETING LEADING space.
      MODIFY ENTITIES OF ZR_BOOKING_F_HD IN LOCAL MODE
        ENTITY zr_booking_f_it
        UPDATE FIELDS ( totbox totpallet )
        WITH VALUE #(
          ( %tky = ls_item-%tky
            totbox = ls_item-totbox
            totpallet = ls_item-totpallet )
        ).
endif.
    ENDLOOP.

  ENDMETHOD.

  METHOD calculateBoxWeight.
       READ ENTITIES OF ZR_BOOKING_F_HD

 IN LOCAL MODE
      ENTITY zr_booking_f_it
      FIELDS ( netwt shipqty totbox boxwt qtypercarton )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_items).

    LOOP AT lt_items INTO DATA(ls_item).


if ls_item-shipqty is not INITIAL and ls_item-shipqty <> 0.
      ls_item-boxnetwt =
        ls_item-totbox * ls_item-boxwt .

    shift ls_item-finishwt LEFT DELETING LEADING space.
      MODIFY ENTITIES OF ZR_BOOKING_F_HD IN LOCAL MODE
        ENTITY zr_booking_f_it
        UPDATE FIELDS ( boxnetwt   )
        WITH VALUE #(
          ( %tky = ls_item-%tky
            boxnetwt = ls_item-boxnetwt
          )
        ).
endif.
    ENDLOOP.

  ENDMETHOD.

  METHOD calculategrossweight.
           READ ENTITIES OF ZR_BOOKING_F_HD

 IN LOCAL MODE
      ENTITY zr_booking_f_it
      FIELDS ( netwt finishwt palletwt  )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_items).

    LOOP AT lt_items INTO DATA(ls_item).

      ls_item-grosswt =
        ls_item-netwt + ls_item-boxnetwt + ls_item-palletwt.
    shift ls_item-finishwt LEFT DELETING LEADING space.
      MODIFY ENTITIES OF ZR_BOOKING_F_HD IN LOCAL MODE
        ENTITY zr_booking_f_it
        UPDATE FIELDS ( grosswt  )
        WITH VALUE #(
          ( %tky = ls_item-%tky
            grosswt = ls_item-grosswt  )
        ).

    ENDLOOP.

  ENDMETHOD.

  METHOD calculatevarianceqty.
  READ ENTITIES OF ZR_BOOKING_F_HD

 IN LOCAL MODE
      ENTITY zr_booking_f_it
      FIELDS ( shipqty  )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_items).

    LOOP AT lt_items INTO DATA(ls_item).

      ls_item-varqty = ls_item-poqty - ls_item-shipqty.
    shift ls_item-varqty LEFT DELETING LEADING space.
      MODIFY ENTITIES OF ZR_BOOKING_F_HD IN LOCAL MODE
        ENTITY zr_booking_f_it
        UPDATE FIELDS ( varqty )
        WITH VALUE #(
          ( %tky = ls_item-%tky
            varqty = ls_item-varqty  )
        ).

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_zr_booking_f_hd DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zr_booking_f_hd RESULT result.
    METHODS createbookingformno FOR DETERMINE ON SAVE
      IMPORTING keys FOR zr_booking_f_hd~createbookingformno.
    METHODS getheader FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zr_booking_f_hd~getheader.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zr_booking_f_hd RESULT result.

    METHODS getitem FOR MODIFY
      IMPORTING keys FOR ACTION zr_booking_f_hd~getitem RESULT result.
    METHODS getpdf FOR MODIFY
      IMPORTING keys FOR ACTION zr_booking_f_hd~getpdf RESULT result.

ENDCLASS.

CLASS lhc_zr_booking_f_hd IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD createBookingFormNo.

   READ ENTITIES OF ZR_BOOKING_F_HD

 IN LOCAL MODE
     ENTITY zr_booking_f_hd
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_mat_data).

    IF lt_mat_data IS NOT INITIAL.

      DATA(ls_mat_data) = VALUE #( lt_mat_data[ 1 ] OPTIONAL ).



       DATA: nr_number     TYPE cl_numberrange_runtime=>nr_number.

        DATA: lv_object    TYPE CHAR10.
DATA LV_SETUP(20) TYPE C.



SELECT count( cuuid  ) FROM ZSD_BOOK_F_HD


 INTO @DATA(LV_SETUP_OLD).
LV_SETUP = LV_SETUP_OLD + 1.
SHIFT LV_SETUP LEFT DELETING LEADING SPACE.
        MODIFY ENTITIES OF ZR_BOOKING_F_HD


 IN LOCAL MODE
      ENTITY zr_booking_f_hd
      UPDATE FIELDS ( Bookingform

                       )
      WITH VALUE #( "FOR key IN keys
                    (
  %is_draft              = ls_mat_data-%is_draft
                      Cuuid                  = VALUE #( keys[ 1 ]-Cuuid OPTIONAL )
                      Bookingform          = LV_SETUP          ""mapped1-inspectionlot

 %control-Bookingform = if_abap_behv=>mk-on



                    ) )

               FAILED DATA(lt_fail)
               REPORTED DATA(lt_reported)
               MAPPED DATA(lt_mapped).

               endif.
  ENDMETHOD.



  METHOD getHeader.
   READ ENTITIES OF ZR_BOOKING_F_HD
 IN LOCAL MODE
     ENTITY zr_booking_f_hd
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_mat_data).

    IF lt_mat_data IS NOT INITIAL.

      DATA(ls_mat_data) = VALUE #( lt_mat_data[ 1 ] OPTIONAL ).



       DATA: nr_number     TYPE cl_numberrange_runtime=>nr_number.

        DATA: lv_object    TYPE CHAR10.
DATA LV_SETUP(20) TYPE C.


 select  single b~SalesOrder ,
 b~SalesOrganization,
     b~SalesOrderType from  I_SalesOrder  as b
     where b~salesorder = @ls_mat_data-salesorder
     into  @data(lfs_data_so).


        MODIFY ENTITIES OF ZR_BOOKING_F_HD

 IN LOCAL MODE
      ENTITY zr_booking_f_hd
      UPDATE FIELDS (
salesdoctype
company
                       )
      WITH VALUE #( "FOR key IN keys
                    (
  %is_draft              = ls_mat_data-%is_draft
                      Cuuid                  = VALUE #( keys[ 1 ]-Cuuid OPTIONAL )

salesdoctype = lfs_data_so-SalesOrderType
company = lfs_data_so-SalesOrganization

*company
 %control-salesdoctype = if_abap_behv=>mk-on

 %control-company = if_abap_behv=>mk-on

                    ) )

               FAILED DATA(lt_fail)
               REPORTED DATA(lt_reported)
               MAPPED DATA(lt_mapped).

               endif.



  ENDMETHOD.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD getItem.
data lv_vbeln type vbeln.
data lv_posnr type posnr.
   READ ENTITIES OF ZR_BOOKING_F_HD
 IN LOCAL MODE ENTITY zr_booking_f_hd
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).

     lv_vbeln = keys[ 1 ]-%param-vbeln .

          lv_posnr = keys[ 1 ]-%param-posnr .

          lv_vbeln = |{ lv_vbeln alpha = in }|.
          lv_posnr = |{ lv_posnr alpha = in }|.
data(key) = value #(  keys[ 1 ] optional ).
lv_vbeln = |{  lv_vbeln alpha = in }|.
    select A~SalesOrder,
    A~purchaseorderbycustomer,
    b~SalesDocumentItem,
    b~Material,
    A~SalesOrderType,
    A~BillingCompanyCode,
    b~orderquantity,
    b~YY1_SD_Pack_Box_Qty_SDI,
    b~YY1_SD_No_Box_Pallet_SDI,
    b~SalesDocumentItemText,
    b~YY1_SD_Pallet_Type_SDI,
    c~materialbycustomer

    from i_salesorder as a inner join i_salesdocumentitem as b on b~SalesDocument = a~salesorder

    left outer join I_CustomerMaterial_2 as c on c~SalesOrganization = a~SalesOrganization
    and c~DistributionChannel = a~DistributionChannel
    and c~Product = b~Material
    and c~Customer = a~SoldToParty
    where a~salesorder = @lv_vbeln
    and b~SalesDocumentItem = @lv_posnr
    into table @data(lft_item).

     MODIFY ENTITY IN LOCAL MODE ZR_BOOKING_F_HD
    CREATE BY \_Item
    AUTO FILL CID
    FIELDS ( Itemno Material salesorder_k salesdoctype company qtypercarton partdesc poqty partnum loadport pallettype ponum )
    WITH VALUE #(

        ( %is_draft = if_abap_behv=>mk-on
          %key      = key-%key          " only parent key!
          Cuuid = key-Cuuid
          %target =

          value #( for lfs_item in lft_item  (  %is_draft = if_abap_behv=>mk-on
            %cid = lfs_item-SalesDocumentItem && 'C11'
            Itemno = |{ lfs_item-SalesDocumentItem ALPHA = OUT }|
            Material = lfs_item-Material
            salesorder_k = |{ lv_vbeln ALPHA = OUT }|
            salesdoctype = lfs_item-SalesOrderType
            company = lfs_item-BillingCompanyCode
            qtypercarton = lfs_item-YY1_SD_Pack_Box_Qty_SDI
            partdesc = lfs_item-SalesDocumentItemText
            poqty = lfs_item-OrderQuantity
            partnum = lfs_item-materialbycustomer
            pallettype = lfs_item-YY1_SD_Pallet_Type_SDI
            loadport = 'Mumbai'
            ponum = lfs_item-PurchaseOrderByCustomer
           ) )
        )
    )

    REPORTED reported FAILED failed MAPPED mapped.

result = VALUE #( FOR ls_ord IN lt_hdr
                          (  %tky  = ls_ord-%tky
                           %param = ls_ord ) ).

  ENDMETHOD.

  METHOD getpdf.



    data : lv_base64      TYPE string,
       lv_token       TYPE string,
           lv_message     TYPE string.
data lfs_header type ZR_BOOKING_F_HD
.
data lft_header type              table of ZR_BOOKING_F_HD
.


data lfs_item type ZR_BOOKING_F_IT

.
data lft_item type table of ZR_BOOKING_F_IT

.
    READ ENTITIES OF ZR_BOOKING_F_HD
      IN LOCAL MODE
      ENTITY zr_booking_f_hd
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lit_header_data)

      FAILED DATA(lit_failed).

data(lfs_header_run) = value #(  lit_header_data[ 1 ]  ).

select * from ZSD_BOOK_F_IT

where cuuid = @lfs_header_run-Cuuid
into TABLE @data(lft_item_db)
.



    MOVE-CORRESPONDING lit_header_data TO lft_header.
    MOVE-CORRESPONDING lft_item_db TO lft_item.

    zcl_btp_adobe_form=>get_ouath_token(
      EXPORTING
        im_oauth_url    = 'ADS_OAUTH_URL'
        im_clientid     = 'ADS_CLIENTID'
        im_clientsecret = 'ADS_CLIENTSECRET'
      IMPORTING
        ex_token        = lv_token
        ex_message      = lv_message
    ).

    zbp_r_booking_f_hd=>get_pdf_xml(
      EXPORTING
*       im_data    = lit_data
        im_data_h  = lft_header
        im_data_i  = lft_item
      IMPORTING
        ex_base_64 = lv_base64
    ).


    data lv_form_name type string.

lv_form_name = 'ZBOOKINGFORM/Booking_Form_Template'.


    zcl_btp_adobe_form=>get_pdf_api(
      EXPORTING
        im_url           = 'ADS_URL'
        im_url_path      = '/v1/adsRender/pdf?TraceLevel=2&templateSource=storageName'
        im_clientid      = 'ADS_CLIENTID'
        im_clientsecret  = 'ADS_CLIENTSECRET'
        im_token         = lv_token
        im_base64_encode = lv_base64
        im_xdp_template  = lv_form_name
      IMPORTING
        ex_base64_decode = DATA(lv_base64_decode)
        ex_message       = lv_message
    ).




    MODIFY ENTITIES OF ZR_BOOKING_F_HD
 IN LOCAL MODE
      ENTITY zr_booking_f_hd
      UPDATE FIELDS (  attachments filename mimetype  )
      WITH VALUE #( FOR lwa_header IN lit_header_data ( %tky        = lwa_header-%tky
                                                        Attachments = lv_base64_decode
                                                        filename    = 'Form'
                                                        mimetype    = 'application/pdf'
                    ) )
    FAILED failed
    REPORTED reported.

    READ ENTITIES OF  ZR_BOOKING_F_HD

 IN LOCAL MODE

          ENTITY zr_booking_f_hd

          ALL FIELDS WITH CORRESPONDING #( keys )
          RESULT DATA(lit_updatedheader).

    " set the action result parameter
    result = VALUE #( FOR lwa_updatedheader IN lit_updatedheader ( %tky   = lwa_updatedheader-%tky
                                                                   %param = lwa_updatedheader ) ).
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zr_booking_f_hd DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zr_booking_f_hd IMPLEMENTATION.

  METHOD save_modified.
     if create-zr_booking_f_hd is NOT INITIAL.
    data lfs_item type ZSD_BOOK_F_IT

.
    data lft_item type table of ZSD_BOOK_F_IT

.


   DATA LV_VBELN TYPE VBELN.

    DATA(lv_itemno) = 1.
    DATA(lv_Opr) = 1.
    DATA(lv_Risk) = 1.

     loop at create-zr_booking_f_hd ASSIGNING FIELD-SYMBOL(<lfs_head>).
LV_VBELN = <lfs_head>-salesorder.
                  LV_VBELN = |{ LV_VBELN alpha = in }|.

**     select  a~SalesOrderItem ,
**     b~SalesOrderType from I_SalesOrderItem as a
**     inner join I_SalesOrder as b on b~SalesOrder = a~SalesOrder
**     where a~salesorder = @<lfs_head>-salesorder
**     into table @data(lft_data_so).
**loop at lft_data_so into data(lfs_data_so).

APPEND VALUE #( cuuid  = <lfs_head>-cuuid
salesorder_k = LV_VBELN
                ) TO lft_item.
*                clear: lfs_data_so.

                ENDLOOP.

***     ENDLOOP.
endif.
******    modify ZSD_BOOK_F_IT from table  @lft_item.



  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
