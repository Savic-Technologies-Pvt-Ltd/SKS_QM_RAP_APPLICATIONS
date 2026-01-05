CLASS lhc_zr_pallet_f_it DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS calculateNoofBoxes FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZR_PALLET_F_IT~calculateNoofBoxes.
    METHODS calculateGrossWeight FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZR_PALLET_F_IT~calculateGrossWeight.

ENDCLASS.

CLASS lhc_zr_pallet_f_it IMPLEMENTATION.

  METHOD calculateNoofBoxes.
     READ ENTITIES OF zr_pallet_f_hd

 IN LOCAL MODE
      ENTITY zr_pallet_f_it
      FIELDS ( qty qty_box )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_items).

    LOOP AT lt_items INTO DATA(ls_item).

if ls_item-qty_box is not INITIAL and ls_item-qty_box <> 0.
      ls_item-no_of_boxes =
        ls_item-qty / ls_item-qty_box.
    shift ls_item-no_of_boxes LEFT DELETING LEADING space.
      MODIFY ENTITIES OF zr_pallet_f_hd IN LOCAL MODE
        ENTITY zr_pallet_f_it
        UPDATE FIELDS ( no_of_boxes )
        WITH VALUE #(
          ( %tky = ls_item-%tky
            no_of_boxes = ls_item-no_of_boxes )
        ).
endif.
    ENDLOOP.
  ENDMETHOD.

  METHOD calculateGrossWeight.
       READ ENTITIES OF zr_pallet_f_hd

 IN LOCAL MODE
      ENTITY zr_pallet_f_it
      FIELDS ( pallet box_wt gross_wt )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_items).

    LOOP AT lt_items INTO DATA(ls_item).

      ls_item-gross_wt = ls_item-pallet_wt + ls_item-box_wt + ls_item-gross_wt.
      MODIFY ENTITIES OF zr_pallet_f_hd IN LOCAL MODE
        ENTITY zr_pallet_f_it
        UPDATE FIELDS ( gross_wt )
        WITH VALUE #(
          ( %tky = ls_item-%tky
            gross_wt = ls_item-gross_wt )
        ).

    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_zr_pallet_f_hd DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zr_pallet_f_hd RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zr_pallet_f_hd RESULT result.



    METHODS getitem FOR MODIFY
      IMPORTING keys FOR ACTION zr_pallet_f_hd~getitem RESULT result.

    METHODS getpdf FOR MODIFY
      IMPORTING keys FOR ACTION zr_pallet_f_hd~getpdf RESULT result.

    METHODS createbookingformno FOR DETERMINE ON SAVE
      IMPORTING keys FOR zr_pallet_f_hd~createbookingformno.

ENDCLASS.

CLASS lhc_zr_pallet_f_hd IMPLEMENTATION.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.


  METHOD getitem.


  data lv_vbeln type vbeln.
  data lv_posnr type posnr.
   READ ENTITIES OF ZR_PALLET_F_HD
 IN LOCAL MODE ENTITY ZR_PALLET_F_HD
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_hdr).

     lv_vbeln = keys[ 1 ]-%param-vbeln .
     lv_posnr = keys[ 1 ]-%param-posnr .
data(key) = value #(  keys[ 1 ] optional ).
lv_vbeln = |{  lv_vbeln alpha = in }|.
lv_posnr = |{  lv_posnr alpha = in }|.
    select A~DeliveryDocument,
    a~DeliveryDocumentItem,
    a~MATERIAL,
    a~DELIVERYDOCUMENTITEMTEXT,
    a~ACTUALDELIVERYQUANTITY,
    a~BATCH,

    b~SalesDocument,
    b~SalesDocumentItem,
    A~Plant,
    a~ITEMNETWEIGHT,
    a~ITEMGROSSWEIGHT,
    A~REFERENCESDDOCUMENT,
    A~REFERENCESDDOCUMENTITEM,
    B~MATERIALBYCUSTOMER,
    B~YY1_SD_Pallet_Type_SDI,
    B~YY1_SD_Pack_Box_Qty_SDI,
    B~YY1_SD_No_Box_Pallet_SDI,
    c~netweight

    from I_DELIVERYDOCUMENTITEM as a

    LEFT OUTER JOIN I_SALESDOCUMENTITEM AS B ON B~SalesDocument = A~REFERENCESDDOCUMENT AND B~SalesDocumentItem = A~REFERENCESDDOCUMENTITEM
left OUTER join i_product as c on c~product = a~material
    where a~DeliveryDocument = @lv_vbeln and a~DeliveryDocumentItem = @lv_posnr
    into table @data(lft_item).



    DATA(LV_REF_DOC) = VALUE #(  lft_item[ 1 ]-ReferenceSDDocument  OPTIONAL ).


    SELECT A~MATERIAL,
    A~PLANT,
    A~BATCH,
    B~MATLWRHSSTKQTYINMATLBASEUNIT FROM @lft_item AS A INNER JOIN  I_STOCKQUANTITYCURRENTVALUE_2(  P_DisplayCurrency = 'INR' ) AS B ON B~Product = A~MATERIAL
                                        AND A~PLANT = B~PLANT AND A~BATCH = B~BATCH AND B~INVENTORYSTOCKTYPE = '01'
                                       INTO TABLE @DATA(LFT_STOCK).


    SELECT SINGLE PURCHASEORDERBYCUSTOMER FROM I_SalesDocument  WHERE SalesDocument = @LV_REF_DOC
    INTO @DATA(LV_PURCHASEORDERBYCUSTOMER).


        SELECT SINGLE  YY1_SD_Pallet_Type_SDH FROM I_SalesDocument AS A WHERE A~SalesDocument = @LV_REF_DOC
    INTO @DATA(LV_PALLETTYPE).

     MODIFY ENTITY IN LOCAL MODE ZR_PALLET_F_HD

    CREATE BY \_Item
    AUTO FILL CID
    FIELDS (    Delivery Itemno Partno Partdesc Qty Lotno Poqty Pono
                Catcode Stock Pallettype qty_box vbeln vbelp net_wt gross_wt finish_wt )
    WITH VALUE #(

        ( %is_draft = if_abap_behv=>mk-on
          %key      = key-%key          " only parent key!
          Cuuid = key-Cuuid
          %target =

          value #( for lfs_item in lft_item  (  %is_draft = if_abap_behv=>mk-on
            %cid = lfs_item-DeliveryDocumentItem && 'C11'
            Itemno = |{ lfs_item-DeliveryDocumentItem ALPHA = OUT }|
            Delivery  = lfs_item-DeliveryDocument
            Partno  = lfs_item-Material
            Partdesc  = lfs_item-DeliveryDocumentItemText
            Qty  = lfs_item-ActualDeliveryQuantity
            Lotno  = lfs_item-Batch
            Poqty = lfs_item-ActualDeliveryQuantity
            Pono = LV_PURCHASEORDERBYCUSTOMER
            Catcode = lfs_item-MATERIALBYCUSTOMER
            Stock = VALUE #( LFT_STOCK[ MATERIAL = lfs_item-Material PLANT = lfs_item-PLANT BATCH = lfs_item-BATCH ]-MatlWrhsStkQtyInMatlBaseUnit OPTIONAL )
            Pallettype = lfs_item-YY1_SD_Pallet_Type_SDI
            QTY_BOX = lfs_item-YY1_SD_Pack_Box_Qty_SDI
            no_of_boxes = COND #( WHEN lfs_item-YY1_SD_Pack_Box_Qty_SDI IS NOT INITIAL
                                THEN lfs_item-ActualDeliveryQuantity / lfs_item-YY1_SD_Pack_Box_Qty_SDI
                                ELSE 0 )
            pallet =  COND #( WHEN lfs_item-YY1_SD_No_Box_Pallet_SDI IS NOT INITIAL and lfs_item-YY1_SD_Pack_Box_Qty_SDI IS NOT INITIAL
                                THEN ( lfs_item-ActualDeliveryQuantity / lfs_item-YY1_SD_Pack_Box_Qty_SDI ) / lfs_item-YY1_SD_No_Box_Pallet_SDI
                                ELSE 0 )
            net_wt = lfs_item-ItemNetWeight
            gross_wt = lfs_item-ItemGrossWeight
            finish_wt = lfs_item-NetWeight
            vbeln = lfs_item-SalesDocument
            vbelp = lfs_item-SalesDocumentItem

           ) )
        )
    )

    REPORTED reported FAILED failed MAPPED mapped.

result = VALUE #( FOR ls_ord IN lt_hdr
                          (  %tky  = ls_ord-%tky
                           %param = ls_ord ) ).



  ENDMETHOD.

  METHOD getpdf.
  ENDMETHOD.

  METHOD createbookingformno.

   READ ENTITIES OF ZR_PALLET_F_HD


 IN LOCAL MODE
     ENTITY ZR_PALLET_F_HD

     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_mat_data).

    IF lt_mat_data IS NOT INITIAL.

      DATA(ls_mat_data) = VALUE #( lt_mat_data[ 1 ] OPTIONAL ).



       DATA: nr_number     TYPE cl_numberrange_runtime=>nr_number.

        DATA: lv_object    TYPE CHAR10.
DATA LV_SETUP(20) TYPE C.



SELECT count( cuuid  ) FROM ZSD_PALLET_HD



 INTO @DATA(LV_SETUP_OLD).
LV_SETUP = LV_SETUP_OLD + 1.
SHIFT LV_SETUP LEFT DELETING LEADING SPACE.
        MODIFY ENTITIES OF ZR_PALLET_F_HD



 IN LOCAL MODE
      ENTITY ZR_PALLET_F_HD

      UPDATE FIELDS ( Palletform

                       )
      WITH VALUE #( "FOR key IN keys
                    (
  %is_draft              = ls_mat_data-%is_draft
                      Cuuid                  = VALUE #( keys[ 1 ]-Cuuid OPTIONAL )
                      Palletform          = LV_SETUP          ""mapped1-inspectionlot

 %control-Palletform = if_abap_behv=>mk-on



                    ) )

               FAILED DATA(lt_fail)
               REPORTED DATA(lt_reported)
               MAPPED DATA(lt_mapped).

               endif.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_zr_pallet_f_hd DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zr_pallet_f_hd IMPLEMENTATION.

  METHOD save_modified.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
