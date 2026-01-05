CLASS lsc_zr_mmgate_head DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS adjust_numbers REDEFINITION.
    METHODS save_modified REDEFINITION.


ENDCLASS.

CLASS lsc_zr_mmgate_head IMPLEMENTATION.

  METHOD adjust_numbers.


   LOOP AT mapped-zrmmgatehead ASSIGNING FIELD-SYMBOL(<ls_mapped>).
read ENTITIES OF ZR_MMGATE_HEAD IN LOCAL MODE
ENTITY ZrMmgateHead ALL FIELDS WITH  value #( ( Gatenumber =  <ls_mapped>-%key-Gatenumber
plant =  <ls_mapped>-%key-plant
%pid = <ls_mapped>-%pid


) )


RESULT data(lft_header).

if lft_header is not INITIAL.
data(lfs_header) = value #( lft_header[ 1 ] OPTIONAL ).
endif.
    DATA: nr_number     TYPE cl_numberrange_runtime=>nr_number.
      DATA: LV_JO TYPE zd_mm_gate_number .

*        DATA: lv_object    TYPE CHAR10.
* changed by Lokesh
         DATA: lv_object    TYPE C length 10.

        lv_object = 'ZMM_GATE'.
TRY.
      CALL METHOD cl_numberrange_runtime=>number_get  "// generating number
        EXPORTING
*         ignore_buffer     =
          nr_range_nr = '01'
          object      = lv_object  "//object name
"          quantity    = 00000000000000000001
*         subobject   =
*         toyear      =
        IMPORTING
          number      = nr_number.


  CATCH cx_number_ranges INTO DATA(lx_nr).
*     returncode        =
*     returned_quantity =

*    CATCH cx_nr_object_not_found.
*    CATCH cx_root into data(lx_root).
*   CATCH cx_number_ranges.

  ENDTRY.
  "      <ls_mapped>-%cid-gatenumber = <ls_mapped>-%tmp-nr_number.
  shift nr_number LEFT DELETING LEADING '0'.

        <ls_mapped>-%key-gatenumber = <ls_mapped>-%tmp-plant  && '-' && lfs_header-gatetype && '-' && sy-datum+0(4) && '-'  && nr_number.
        <ls_mapped>-%key-plant = <ls_mapped>-%tmp-plant.

   "     <ls_mapped>-%id-gatenumber  = nr_number.



  ENDLOOP.

  loop at mapped-zr_mmgate_item  ASSIGNING FIELD-SYMBOL(<ls_mapped_item>).

 " <ls_mapped_item>-%key-Gatenumber = <ls_mapped_item>-%tmp-plant.
  <ls_mapped_item>-%key-Item = <ls_mapped_item>-%tmp-Item.
  <ls_mapped_item>-%key-doc_num = <ls_mapped_item>-%tmp-doc_num.
  ENDLOOP.

    loop at mapped-zr_mmgate_doc_hd  ASSIGNING FIELD-SYMBOL(<ls_zr_mmgate_doc_hd>).

 " <ls_mapped_item>-%key-Gatenumber = <ls_mapped_item>-%tmp-plant.
  <ls_zr_mmgate_doc_hd>-%key-doc_num = <ls_zr_mmgate_doc_hd>-%tmp-doc_num.
  ENDLOOP.

  ENDMETHOD.

  METHOD save_modified.

  if create-zr_mmgate_item is NOT INITIAL.


*  DATA: lv_object    TYPE CHAR10.
DATA: lv_object    TYPE C length 10.
    DATA: nr_number     TYPE cl_numberrange_runtime=>nr_number.
        lv_object = 'ZMM_COIL'.


    data lfs_zmm_gate_coil type zmm_gate_coil.
    data lft_zmm_gate_coil type table of zmm_gate_coil.

data lv_coilCount type int4.
data lv_received_qty type menge_d.
data lv_qty type menge_d.
    loop at create-zr_mmgate_item ASSIGNING FIELD-SYMBOL(<lfs_item>).
        lfs_zmm_gate_coil-gatenumber = <lfs_item>-Gatenumber.
                lfs_zmm_gate_coil-plant = <lfs_item>-plant .
                        lfs_zmm_gate_coil-item =  <lfs_item>-Item .

                                        lfs_zmm_gate_coil-doc_num =  <lfs_item>-doc_num .
                                        lv_received_qty  = <lfs_item>-receivedqty.
lv_coilCount = <lfs_item>-Coilno .

if <lfs_item>-Coilno is not INITIAL.
lv_qty = lv_received_qty / <lfs_item>-Coilno.
endif.

do lv_coilCount TIMES.

TRY.
      CALL METHOD cl_numberrange_runtime=>number_get  "// generating number
        EXPORTING
*         ignore_buffer     =
          nr_range_nr = '01'
          object      = lv_object  "//object name
"          quantity    = 00000000000000000001
*         subobject   =
*         toyear      =
        IMPORTING
          number      = nr_number.
*     returncode        =
*     returned_quantity =

    CATCH cx_nr_object_not_found.
    CATCH cx_number_ranges.
  ENDTRY.
SHIFT nr_number LEFT DELETING LEADING '0'.

lfs_zmm_gate_coil-coilno = 'COIL-SNO-' && nr_number.
lfs_zmm_gate_coil-qty = lv_qty.
lfs_zmm_gate_coil-meins = <lfs_item>-Meins.
  append lfs_zmm_gate_coil to lft_zmm_gate_coil.
ENDDO.


    ENDLOOP.

    modify  zmm_gate_coil from table @lft_zmm_gate_coil.



  endif.

  if  update-coil is NOT INITIAL.

    loop at update-coil into data(lfs_update_coil).

select single * from zmm_gate_coil  where
gatenumber = @lfs_update_coil-Gatenumber and
plant = @lfs_update_coil-Plant and
item = @lfs_update_coil-Item and
doc_num = @lfs_update_coil-doc_num and
coilno  = @lfs_update_coil-Coilno into @data(lfs_coil_db).

    "MOVE-CORRESPONDING lfs_update_coil to lfs_zmm_gate_coil.
*    lfs_zmm_gate_coil-gatenumber = lfs_coil_db-gatenumber.
*        lfs_zmm_gate_coil-plant = lfs_coil_db-plant.
*        lfs_zmm_gate_coil-item = lfs_coil_db-item.
*            lfs_zmm_gate_coil-doc_num = lfs_coil_db-doc_num.
*            lfs_zmm_gate_coil-coilno = lfs_coil_db-coilno.

            MOVE-CORRESPONDING lfs_coil_db to lfs_zmm_gate_coil.
            if lfs_update_coil-qty <> lfs_coil_db-qty and lfs_update_coil-qty is NOT initial.
                lfs_zmm_gate_coil-qty = lfs_update_coil-qty.

            endif.

            if lfs_update_coil-meins <> lfs_coil_db-meins  and lfs_update_coil-meins is NOT initial.
            lfs_zmm_gate_coil-meins = lfs_update_coil-meins.
            endif.


 append lfs_zmm_gate_coil to lft_zmm_gate_coil.
    clear lfs_update_coil.
        clear lfs_zmm_gate_coil.
    ENDLOOP.

    modify  zmm_gate_coil from table @lft_zmm_gate_coil.

  endif.


if update-zr_mmgate_item is NOT INITIAL.

endif.


  ENDMETHOD.

ENDCLASS.

CLASS lhc_zr_mmgate_item DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS getPoItem FOR MODIFY
      IMPORTING keys FOR ACTION ZR_MMGATE_ITEM~getPoItem.

ENDCLASS.

CLASS lhc_zr_mmgate_item IMPLEMENTATION.

  METHOD getPoItem.


  ENDMETHOD.

ENDCLASS.

CLASS LHC_ZR_MMGATE_HEAD DEFINITION INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.
  PRIVATE SECTION.
    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
           REQUEST requested_authorizations FOR ZrMmgateHead
        RESULT result,
      updateHeaderDetails FOR DETERMINE ON MODIFY
            IMPORTING keys FOR ZrMmgateHead~updateHeaderDetails,
      getItem FOR MODIFY
            IMPORTING keys FOR ACTION ZrMmgateHead~getItem
            ,
      getpdf FOR MODIFY
            IMPORTING keys FOR ACTION ZrMmgateHead~getpdf RESULT result,
      postGoods FOR MODIFY
            IMPORTING keys FOR ACTION ZrMmgateHead~postGoods RESULT result,
      createGoods FOR DETERMINE ON SAVE
            IMPORTING keys FOR ZrMmgateHead~createGoods.
ENDCLASS.

CLASS LHC_ZR_MMGATE_HEAD IMPLEMENTATION.
  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.
  METHOD updateHeaderDetails .


****    READ ENTITIES OF zr_mmgate_head IN LOCAL MODE
****    ENTITY ZrMmgateHead
****    FIELDS (  ebeln ) WITH CORRESPONDING #( keys )
****    RESULT data(lft_data).
****
****
****    loop at lft_data into data(lfs_data).
****SELECT SINGLE   PurchaseOrder,
****                    CompanyCode,
****                    PurchasingGroup,
****                    PurchaseOrderDate,
****                    PurchasingOrganization,
****                    Supplier  FROM I_PURCHASEORDERAPI01 WHERE PurchaseOrder = @LFS_DATA-ebeln
****    INTO @DATA(LFS_EKKO) .
****   " LFS_EKKO-CompanyCode = '1100'.
*****LFS_EKKO-PurchasingOrganization = '1100'.
*****LFS_EKKO-PurchasingGroup = '110'.
*****LFS_EKKO-Supplier = '100001'.
*****LFS_EKKO-PurchaseOrderDate = '20250903'.
****    MODIFY ENTITIES OF zr_mmgate_head IN LOCAL MODE
****    ENTITY ZrMmgateHead
****    UPDATE
****    FIELDS (
****
****    ekorg
****    ekgrp
****    bukrs
****    lifnr
****    vendorname ) WITH VALUE #( ( %tky =  lfs_data-%tky
****                                 %is_draft = LFS_DATA-%is_draft
****
****                                 ekorg =  LFS_EKKO-PurchasingOrganization
****                                 ekgrp =  LFS_EKKO-PurchasingGroup
****                                 bukrs =  LFS_EKKO-CompanyCode
****                                 lifnr =  LFS_EKKO-Supplier
****                                 podate = LFS_EKKO-PurchaseOrderDate
****                                 vendorname = 'Vendor Name'
****    %control = VALUE #( vendorname = if_abap_behv=>mk-on )  ) )
****    REPORTED DATA(LFT_REPORTED).
****
****
****    reported = CORRESPONDING #( DEEP  LFT_REPORTED ).
****
****
****
****    endloop.



  ENDMETHOD.

  METHOD getItem.

  data lv_ebeln type ebeln.

    data lv_mblnr type mblnr.
    data lv_werks type werks_d.

     data lv_gateentry(40) type c.
        data lv_ManufacturingOrder type I_ManufacturingOrder-ManufacturingOrder.

data lv_inwardtype type c length 2.

 READ ENTITIES OF zr_mmgate_head IN LOCAL MODE
    ENTITY ZrMmgateHead
    FIELDS (  ebeln inwardtype ) WITH CORRESPONDING #( keys )
    RESULT data(lft_data).
lv_ebeln = value #( lft_data[ 1 ]-ebeln optional ).
lv_mblnr = value #( lft_data[ 1 ]-ebeln optional ).
lv_ManufacturingOrder = value #( lft_data[ 1 ]-ebeln optional ).
lv_inwardtype = value #( lft_data[ 1 ]-inwardtype optional ).
lv_gateentry =  value #( lft_data[ 1 ]-ebeln optional ).
lv_werks =  value #( lft_data[ 1 ]-plant optional ).


if lv_inwardtype is INITIAL.

APPEND VALUE #(
  %tky = keys[ 1 ]-%tky
  %msg = new_message_with_text(
    severity = if_abap_behv_message=>severity-error
    text     = |Inward Type Cannot be empty|
  )
) TO reported-zrmmgatehead.

else.
if lv_inwardtype = '01'.
SELECT    a~PurchaseOrder,
                    a~PurchaseOrderItem,
                    a~Material,
                    a~PurchaseOrderQuantityUnit,
                    a~NetPriceQuantity ,
                    a~OrderQuantity,
                    b~ProductDescription,
                    c~PurchaseOrderDate,
                    c~Supplier,
                    d~SupplierName
                    FROM I_PurchaseOrderItemAPI01 as a

                    left OUTER join I_ProductDescription as b on b~Product = a~Material
                                                             and b~Language = 'E'
                             left OUTER join   I_PurchaseOrderAPI01 as c on c~PurchaseOrder = a~PurchaseOrder
                               left OUTER join   I_Supplier as d on d~Supplier = c~Supplier
                     WHERE a~PurchaseOrder = @lv_ebeln
                     and c~PurchaseOrderType not in ( 'ZSUB'  , 'ZSER' )
    INTO table @DATA(LFt_EKKO) .
if sy-subrc = 0.

    data(LFt_EKKO_unique) = LFt_EKKO[].
    SORT LFT_EKKO_UNIQUE BY PURCHASEORDER.
    delete ADJACENT DUPLICATES FROM LFt_EKKO_unique COMPARING PurchaseOrder.
  MODIFY ENTITY IN LOCAL MODE zr_mmgate_head
    CREATE BY \_item
    AUTO FILL CID
    FIELDS ( Item doc_num Qty matnr maktx Meins )
    WITH VALUE #(
      FOR key IN keys
        ( %is_draft = if_abap_behv=>mk-on
          %key      = key-%key          " only parent key!
          %pid = key-%pid
          %target =

          value #( for LFs_EKKO in LFt_EKKO (  %is_draft = if_abap_behv=>mk-on
%cid = LFs_EKKO-PurchaseOrderItem && 'C11'

            Item = |{   LFs_EKKO-PurchaseOrderItem alpha = out }|
            doc_num = LFs_EKKO-PurchaseOrder
              Qty   = LFs_EKKO-OrderQuantity
              Meins =  LFs_EKKO-PurchaseOrderQuantityUnit
              matnr =   LFs_EKKO-Material
              maktx = LFs_EKKO-ProductDescription

           ) )
        )
    )


    CREATE BY \_docHeader
        AUTO FILL CID

    FIELDS ( doc_num doc_date Vendor Vendorname inwardtype )
    WITH VALUE #(
    FOR key in keys
    (
     %is_draft = if_abap_behv=>mk-on
          %key      = key-%key          " only parent key!
          %pid = key-%pid
          %target =
    value #( for LFs_EKKO_unique in LFt_EKKO_unique (  %is_draft = if_abap_behv=>mk-on
            %cid = LFs_EKKO_unique-PurchaseOrderItem && 'C12'

            doc_num = LFs_EKKO_unique-PurchaseOrder
            doc_date = LFs_EKKO_unique-PurchaseOrderDate
                       Vendor = LFs_EKKO_unique-Supplier
Vendorname = LFs_EKKO_unique-SupplierName
inwardtype = '01'

           )
           )

    )



     )


    REPORTED reported FAILED failed MAPPED mapped.




endif.


elseif lv_inwardtype = '02'.

select MaterialDocument,
MaterialDocumentItem,
Material,
I_MATERIALDOCUMENTITEM_2~Plant,
PostingDate,
QuantityInBaseUnit,
MaterialBaseUnit,
IssuingOrReceivingPlant,
DocumentDate,
                    b~ProductDescription,
                    c~PlantName
                     from I_MATERIALDOCUMENTITEM_2



 left OUTER join I_ProductDescription as b on b~Product = I_MATERIALDOCUMENTITEM_2~Material
 left OUTER join I_Plant as c on c~Plant = I_MATERIALDOCUMENTITEM_2~Plant
                                                             and b~Language = 'E'

                                                              where MaterialDocument = @lv_mblnr
                                                                and DebitCreditCode = 'H'
                                                                and GoodsMovementType = '301' into table @data(lft_matdoc) .
if sy-subrc = 0.

    data(lft_matdoc_unique) = lft_matdoc[].
    SORT LFT_MATDOC_UNIQUE BY MATERIALDOCUMENT.
    delete ADJACENT DUPLICATES FROM lft_matdoc_unique COMPARING MaterialDocument.
  MODIFY ENTITY IN LOCAL MODE zr_mmgate_head
    CREATE BY \_item
    AUTO FILL CID
    FIELDS ( Item doc_num Qty matnr maktx Meins )
    WITH VALUE #(
      FOR key IN keys
        ( %is_draft = if_abap_behv=>mk-on
          %key      = key-%key          " only parent key!
          %pid = key-%pid
          %target =

          value #( for lfs_matdoc in lft_matdoc (  %is_draft = if_abap_behv=>mk-on
%cid = lfs_matdoc-MaterialDocumentItem && 'C11'

            Item = |{   lfs_matdoc-MaterialDocumentItem alpha = out }|
            doc_num = lfs_matdoc-MaterialDocument
              Qty   = lfs_matdoc-QuantityInBaseUnit
              Meins =  lfs_matdoc-MaterialBaseUnit
              matnr =   lfs_matdoc-Material
              maktx = lfs_matdoc-ProductDescription
           ) )
        )
    )


    CREATE BY \_docHeader
        AUTO FILL CID

    FIELDS ( doc_num doc_date Vendor Vendorname inwardtype )
    WITH VALUE #(
    FOR key in keys
    (
     %is_draft = if_abap_behv=>mk-on
          %key      = key-%key          " only parent key!
          %pid = key-%pid
          %target =
    value #( for lfs_matdoc_unique in lft_matdoc_unique (  %is_draft = if_abap_behv=>mk-on
            %cid = lfs_matdoc_unique-MaterialDocumentItem && 'C12'

            doc_num = lfs_matdoc_unique-MaterialDocument
doc_date = lfs_matdoc_unique-DocumentDate
           Vendor = lfs_matdoc_unique-Plant
Vendorname = lfs_matdoc_unique-PlantName
inwardtype = '02'

           )
           )

    )



     )



    REPORTED reported FAILED failed MAPPED mapped.



endif.


elseif lv_inwardtype = '04'.
SELECT    a~PurchaseOrder,
                    a~PurchaseOrderItem,
                    a~Material,
                    a~PurchaseOrderQuantityUnit,
                    a~NetPriceQuantity ,

                    b~ProductDescription,
                    c~PurchaseOrderDate,
                    c~Supplier,
                    d~SupplierName
                    FROM I_PurchaseOrderItemAPI01 as a

                    left OUTER join I_ProductDescription as b on b~Product = a~Material
                                                             and b~Language = 'E'
                             left OUTER join   I_PurchaseOrderAPI01 as c on c~PurchaseOrder = a~PurchaseOrder
                                left OUTER join   I_Supplier as d on d~Supplier = c~Supplier
                     WHERE a~PurchaseOrder = @lv_ebeln
                     and c~PurchaseOrderType in ( 'ZSUB'  , 'ZSER' )
    INTO table @DATA(LFt_EKKO_sub) .
if sy-subrc = 0.

    data(LFt_EKKO_sub_unique) = LFt_EKKO_sub[].
    SORT LFT_EKKO_SUB_UNIQUE BY PURCHASEORDER.
    delete ADJACENT DUPLICATES FROM LFt_EKKO_sub_unique COMPARING PurchaseOrder.
  MODIFY ENTITY IN LOCAL MODE zr_mmgate_head
    CREATE BY \_item
    AUTO FILL CID
    FIELDS ( Item doc_num Qty matnr maktx Meins )
    WITH VALUE #(
      FOR key IN keys
        ( %is_draft = if_abap_behv=>mk-on
          %key      = key-%key          " only parent key!
          %pid = key-%pid
          %target =

          value #( for LFs_EKKO_sub in LFt_EKKO_sub (  %is_draft = if_abap_behv=>mk-on
%cid = LFs_EKKO_sub-PurchaseOrderItem && 'C11'

            Item = |{   LFs_EKKO_sub-PurchaseOrderItem alpha = out }|
            doc_num = LFs_EKKO_sub-PurchaseOrder
              Qty   = LFs_EKKO_sub-NetPriceQuantity
              Meins =  LFs_EKKO_sub-PurchaseOrderQuantityUnit
              matnr =   LFs_EKKO_sub-Material
              maktx = LFs_EKKO_sub-ProductDescription

           ) )
        )
    )


    CREATE BY \_docHeader
        AUTO FILL CID

    FIELDS ( doc_num doc_date Vendor Vendorname inwardtype )
    WITH VALUE #(
    FOR key in keys
    (
     %is_draft = if_abap_behv=>mk-on
          %key      = key-%key          " only parent key!
          %pid = key-%pid
          %target =
    value #( for LFs_EKKO_sub_unique in LFt_EKKO_sub_unique (  %is_draft = if_abap_behv=>mk-on
            %cid = LFs_EKKO_sub_unique-PurchaseOrderItem && 'C12'

            doc_num = LFs_EKKO_sub_unique-PurchaseOrder
            doc_date = LFs_EKKO_sub_unique-PurchaseOrderDate
            Vendor = LFs_EKKO_sub_unique-Supplier
Vendorname = LFs_EKKO_sub_unique-SupplierName
inwardtype = '04'
           )
           )

    )



     )


    REPORTED reported FAILED failed MAPPED mapped.



endif.

elseif lv_inwardtype = '05'.


SELECT    a~Gatenumber,
                    a~Item,
                    a~matnr,
                    a~Qty,
                    a~Meins ,

                    b~ProductDescription,
                    c~CreatDat
                    FROM ZR_MMGATE_ITEM as a
                    INNER join ZR_MMGATE_head as c on c~Gatenumber = a~Gatenumber

                    left OUTER join I_ProductDescription as b on b~Product = a~matnr
                                                             and b~Language = 'E'


                     WHERE a~Gatenumber = @lv_gateentry
    INTO table @DATA(LFt_EKKO_gate) .
if sy-subrc = 0.

    data(LFt_EKKO_gate_uni) = LFt_EKKO_gate[].
    SORT LFT_EKKO_GATE_UNI BY GATENUMBER.
    delete ADJACENT DUPLICATES FROM LFt_EKKO_gate_uni COMPARING Gatenumber.
  MODIFY ENTITY IN LOCAL MODE zr_mmgate_head
    CREATE BY \_item
    AUTO FILL CID
    FIELDS ( Item doc_num Qty matnr maktx Meins )
    WITH VALUE #(
      FOR key IN keys
        ( %is_draft = if_abap_behv=>mk-on
          %key      = key-%key          " only parent key!
          %pid = key-%pid
          %target =

          value #( for LFs_EKKO_gate in LFt_EKKO_gate (  %is_draft = if_abap_behv=>mk-on
%cid = LFs_EKKO_gate-Item && 'C11'

            Item = |{   LFs_EKKO_gate-Item alpha = out }|
            doc_num = LFs_EKKO_gate-Gatenumber
              Qty   = LFs_EKKO_gate-Qty
              Meins =  LFs_EKKO_gate-Meins
              matnr =   LFs_EKKO_gate-matnr
              maktx = LFs_EKKO_gate-ProductDescription

           ) )
        )
    )


    CREATE BY \_docHeader
        AUTO FILL CID

    FIELDS ( doc_num doc_date  inwardtype )
    WITH VALUE #(
    FOR key in keys
    (
     %is_draft = if_abap_behv=>mk-on
          %key      = key-%key          " only parent key!
          %pid = key-%pid
          %target =
    value #( for LFs_EKKO_gate_uni in LFt_EKKO_gate_uni (  %is_draft = if_abap_behv=>mk-on
            %cid = LFs_EKKO_gate_uni-Item && 'C12'

            doc_num = LFs_EKKO_gate_uni-Gatenumber
***            doc_date = LFs_EKKO_gate_uni-CreatDat

inwardtype = '05'
           )
           )
    )



     )


    REPORTED reported FAILED failed MAPPED mapped.
endif.



elseif lv_inwardtype = '06'.

DATA lt_man_ord TYPE RANGE OF I_ManufacturingOrder-ManufacturingOrder .

lv_ManufacturingOrder = |{  lv_ManufacturingOrder alpha = in  }|.

if lv_ManufacturingOrder is not INITIAL.
    APPEND VALUE #( sign = 'I' option = 'EQ' low = lv_ManufacturingOrder ) TO lt_man_ord.
endif.
select ManufacturingOrder,
ManufacturingOrderItem,
Material,
I_ManufacturingOrder~ProductionPlant,
CreationDate,
MfgOrderPlannedTotalQty,
ProductionUnit,
                    b~ProductDescription,
                    c~PlantName
                     from I_ManufacturingOrder



 left OUTER join I_ProductDescription as b on b~Product = I_ManufacturingOrder~Material
 left OUTER join I_Plant as c on c~Plant = I_ManufacturingOrder~ProductionPlant
                                                             and b~Language = 'E'

                                                              where ManufacturingOrder in @lt_man_ord
                                                                into table @data(lft_manufacturingorder) .
if sy-subrc = 0.

    data(lft_manufacturingorder_uni) = lft_manufacturingorder[].
    SORT LFT_MANUFACTURINGORDER_UNI BY MANUFACTURINGORDER.
    delete ADJACENT DUPLICATES FROM lft_manufacturingorder_uni COMPARING ManufacturingOrder.


    select a~ManufacturingOrder,
a~ManufacturingOrderItem,
a~Material,
a~ProductionPlant,
a~CreationDate,
a~MfgOrderPlannedTotalQty,
a~ProductionUnit,
a~ProductDescription,
a~PlantName,
b~ConfirmationYieldQuantity
 from @lft_manufacturingorder as a inner join I_PRODUCTIONORDERCONFIRMATION  as b on
b~ProductionOrder = a~ManufacturingOrder and
b~Plant = @lv_werks

into TABLE @data(lft_confirmed).


  MODIFY ENTITY IN LOCAL MODE zr_mmgate_head
    CREATE BY \_item
    AUTO FILL CID
    FIELDS ( Item doc_num Qty matnr maktx Meins )
    WITH VALUE #(
      FOR key IN keys
        ( %is_draft = if_abap_behv=>mk-on
          %key      = key-%key          " only parent key!
          %pid = key-%pid
          %target =

          value #( for lfs_manufacturingorder in lft_confirmed INDEX INTO lv_index (  %is_draft = if_abap_behv=>mk-on
%cid = lv_index && 'C11'

            Item = lv_index
            doc_num = |{   lfs_manufacturingorder-ManufacturingOrder alpha = out }|
              Qty   = lfs_manufacturingorder-ConfirmationYieldQuantity
              Meins =  lfs_manufacturingorder-ProductionUnit
              matnr =   lfs_manufacturingorder-Material
              maktx = lfs_manufacturingorder-ProductDescription
           ) )
        )
    )


    CREATE BY \_docHeader
        AUTO FILL CID

    FIELDS ( doc_num doc_date  inwardtype )
    WITH VALUE #(
    FOR key in keys
    (
     %is_draft = if_abap_behv=>mk-on
          %key      = key-%key          " only parent key!
          %pid = key-%pid
          %target =
    value #( for lfs_manufacturingorder_uni in lft_manufacturingorder_uni (  %is_draft = if_abap_behv=>mk-on
            %cid = lfs_manufacturingorder_uni-ManufacturingOrderItem && 'C12'

            doc_num = |{ lfs_manufacturingorder_uni-ManufacturingOrder alpha = out }|
doc_date = lfs_manufacturingorder_uni-CreationDate

inwardtype = '06'
           )
           )

    )



     )



    REPORTED reported FAILED failed MAPPED mapped.

endif.

endif.
endif.

  ENDMETHOD.

  METHOD getpdf.


data lfs_header type ZR_MMGATE_HEAD.
data lft_header type table of ZR_MMGATE_HEAD.
data lv_token       TYPE string.
data lv_message       TYPE string.
data lfs_item type ZR_MMGATE_item.
data lft_item type table of ZR_MMGATE_item.
data lv_base64      TYPE string.
    READ ENTITIES OF ZR_MMGATE_HEAD
      IN LOCAL MODE


      ENTITY ZrMmgateHead
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lit_header_data)


****      ENTITY zr_mmgate_item
****      ALL FIELDS WITH CORRESPONDING #( keys )
****      RESULT DATA(lit_item_data)



      FAILED DATA(lit_failed).





    MOVE-CORRESPONDING lit_header_data TO lft_header.
****    MOVE-CORRESPONDING lit_item_data TO lft_item.

    zcl_btp_adobe_form=>get_ouath_token(
      EXPORTING
        im_oauth_url    = 'ADS_OAUTH_URL'
        im_clientid     = 'ADS_CLIENTID'
        im_clientsecret = 'ADS_CLIENTSECRET'
      IMPORTING
        ex_token        = lv_token
        ex_message      = lv_message
    ).

    ZBP_R_MMGATE_HEAD=>get_pdf_xml(
      EXPORTING
*       im_data    = lit_data
        im_data_h  = lft_header
        im_data_i  = lft_item
      IMPORTING
        ex_base_64 = lv_base64
    ).


    data lv_form_name type string.
lv_form_name = 'ZGATE_APP/ZDELIVERY_CHALLAN'.
****    CASE lfs_header-formtype.
****  WHEN 'Standard'.
****    lv_form_name = 'ZPDIR/Standard_Template'.
****    WHEN 'Boll Hoff'.
****    lv_form_name = 'ZPDIR/BollHoff_Template'.
****    WHEN 'Eastern'.
****    lv_form_name = 'ZPDIR/Eastern_Template'.
****    WHEN 'Fastnal Before'.
****    lv_form_name = 'ZPDIR/Fastnal_Template'.
****    WHEN 'JCB'.
****    lv_form_name = 'ZPDIR/JCB_Template'.
****    WHEN 'Spicer'.
****    lv_form_name = 'ZPDIR/Spicer_Template'.
****ENDCASE.




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


****    DATA(lwa_data1) = VALUE #( lit_item_data[ 1 ] OPTIONAL ).

    MODIFY ENTITIES OF ZR_MMGATE_HEAD IN LOCAL MODE
      ENTITY ZrMmgateHead
      UPDATE FIELDS (  Attachments filename mimetype  )
      WITH VALUE #( FOR lwa_header IN lit_header_data ( %tky        = lwa_header-%tky
                                                        Attachments = lv_base64_decode
                                                        filename    = 'Form'
                                                        mimetype    = 'application/pdf'
                    ) )
    FAILED failed
    REPORTED reported.

    READ ENTITIES OF  ZR_MMGATE_HEAD IN LOCAL MODE
****          ENTITY zr_mmgate_item
****          ALL FIELDS WITH CORRESPONDING #( keys )
****          RESULT DATA(lit_updateditem)
          ENTITY ZrMmgateHead
          ALL FIELDS WITH CORRESPONDING #( keys )
          RESULT DATA(lit_updatedheader).

    " set the action result parameter
    result = VALUE #( FOR lwa_updatedheader IN lit_updatedheader ( %tky   = lwa_updatedheader-%tky
                                                                   %param = lwa_updatedheader ) ).


  ENDMETHOD.

  METHOD postGoods.

*****MODIFY ENTITIES OF i_materialdocumenttp
*****             ENTITY MaterialDocument
*****             CREATE FROM VALUE #( ( %cid                          = 'CID_001'
*****                                    goodsmovementcode             = '01'
*****                                    postingdate                   = '20251020'
*****                                    documentdate                  = '20251020'
*****                                    %control-goodsmovementcode                    = cl_abap_behv=>flag_changed
*****                                    %control-postingdate                          = cl_abap_behv=>flag_changed
*****                                    %control-documentdate                         = cl_abap_behv=>flag_changed
*****                                ) )
*****             ENTITY MaterialDocument
*****             CREATE BY \_MaterialDocumentItem
*****             FROM VALUE #( (
*****                             %cid_ref = 'CID_001'
*****                             %target = VALUE #( ( %cid                           = 'CID_ITM_001'
*****                                                  plant                          = 'MHU2'
*****                                                  material                       = 'FG0000000000000001'
*****                                                  GoodsMovementType              = '561'
*****                                                  storagelocation                = 'U2GN'
*****                                                  QuantityInEntryUnit            = 1
*****                                                  entryunit                      = 'ST'
*****                                                  %control-plant                 = cl_abap_behv=>flag_changed
*****                                                  %control-material              = cl_abap_behv=>flag_changed
*****                                                  %control-GoodsMovementType     = cl_abap_behv=>flag_changed
*****                                                  %control-storagelocation       = cl_abap_behv=>flag_changed
*****                                                  %control-QuantityInEntryUnit   = cl_abap_behv=>flag_changed
*****                                                  %control-entryunit             = cl_abap_behv=>flag_changed
*****                                              ) )
*****
*****
*****                         ) )
*****             MAPPED   DATA(ls_create_mapped)
*****             FAILED   DATA(ls_create_failed)
*****             REPORTED DATA(ls_create_reported).


              MODIFY ENTITIES OF i_materialdocumenttp
 ENTITY MaterialDocument
 CREATE FROM VALUE #( ( %cid = 'CID_001'
 goodsmovementcode = '04'
 postingdate = '20251020'
 documentdate = '20251020'
 %control-goodsmovementcode = cl_abap_behv=>flag_changed
 %control-postingdate = cl_abap_behv=>flag_changed
 %control-documentdate = cl_abap_behv=>flag_changed
 ) )
 ENTITY MaterialDocument
 CREATE BY \_MaterialDocumentItem
 FROM VALUE #( (
 %cid_ref = 'CID_001'
 %target = VALUE #( ( %cid = 'CID_ITM_001'
 plant = 'MHU2'
 material = 'FG0000000000000001'
 GoodsMovementType = '301'
 storagelocation = 'U2GN'
 IssuingOrReceivingPlant = 'MHU3'
 IssuingOrReceivingStorageLoc = 'U3GN'

 QuantityInEntryUnit = 1
 entryunit = 'NOS'
 %control-plant = cl_abap_behv=>flag_changed
 %control-material = cl_abap_behv=>flag_changed
 %control-GoodsMovementType = cl_abap_behv=>flag_changed
 %control-storagelocation = cl_abap_behv=>flag_changed
 %control-QuantityInEntryUnit = cl_abap_behv=>flag_changed
 %control-entryunit = cl_abap_behv=>flag_changed
  %control-IssuingOrReceivingPlant = cl_abap_behv=>flag_changed

  %control-IssuingOrReceivingStorageLoc = cl_abap_behv=>flag_changed

 ) )


 ) )
 MAPPED DATA(ls_create_mapped)
 FAILED DATA(ls_create_failed)
 REPORTED DATA(ls_create_reported).



  ENDMETHOD.

  METHOD createGoods.


  ENDMETHOD.

ENDCLASS.
