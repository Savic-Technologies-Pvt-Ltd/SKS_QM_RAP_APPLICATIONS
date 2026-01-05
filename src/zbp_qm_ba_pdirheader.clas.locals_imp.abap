CLASS lhc_zqm_pdir_specification_lis DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR ZQM_PDIR_SPECIFICATION_LIST RESULT result.


    METHODS resulttxt FOR DETERMINE ON SAVE
      IMPORTING keys FOR ZQM_PDIR_SPECIFICATION_LIST~resulttxt.
    METHODS field_readonly FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZQM_PDIR_SPECIFICATION_LIST~field_readonly.

ENDCLASS.

CLASS lhc_zqm_pdir_specification_lis IMPLEMENTATION.

  METHOD get_instance_features.

*****   READ ENTITIES OF ZQM_BA_PDIRHeader IN LOCAL MODE
*****    ENTITY Header
*****    ALL FIELDS WITH CORRESPONDING #( keys )
*****    RESULT DATA(lit_mat_data).
*****
*****    READ ENTITY IN LOCAL MODE ZQM_PDIR_OPERTION_LIST
*****      ALL FIELDS WITH CORRESPONDING #( keys )
*****      RESULT DATA(lit_item) .
*****
*****
*****      READ ENTITY IN LOCAL MODE ZQM_PDIR_SPECIFICATION_LIST
*****      ALL FIELDS WITH CORRESPONDING #( keys )
*****      RESULT DATA(lit_SPECIFICATION) .
*****
*****
*****    DATA(lwa_mat_data) = VALUE #( lit_item[ 1 ] OPTIONAL  ).

 READ ENTITY IN LOCAL MODE ZQM_PDIR_SPECIFICATION_LIST
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_spec).

  result = VALUE #( FOR row IN lt_spec
                    ( %tky = row-%tky

                      %features-%field-Result1 =
                        COND #( WHEN row-res_mark1_ind IS NOT INITIAL
                                THEN if_abap_behv=>fc-f-read_only
                                ELSE if_abap_behv=>fc-f-unrestricted ) ) ).

  ENDMETHOD.

  METHOD field_readonly.

   READ ENTITY IN LOCAL MODE zqm_pdir_specification_list
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lit_item) .
    DATA(lwa_mat_data) = VALUE #( lit_item[ 1 ] OPTIONAL  ).

    DATA : ind TYPE c.

    ind = lwa_mat_data-result1 .
    DATA(ind1) = lwa_mat_data-result2.
    DATA(ind2) = lwa_mat_data-result3.
    DATA(ind3) = lwa_mat_data-result4.

    IF lwa_mat_data-result1 IS not INITIAL .
      ind = 'X'.
    endif.

***** READ ENTITY IN LOCAL MODE ZQM_PDIR_SPECIFICATION_LIST
*****    ALL FIELDS WITH value #( (   %key-Cuuid = lfs_lit_item_data_OPR-Cuuid
*****    %key-Inspectionlot = lfs_lit_item_data_OPR-Inspectionlot
*****    %key-InspectionPlanGroup = lfs_lit_item_data_OPR-InspectionPlanGroup
*****    %key-BOOOperationInternalID = lfs_lit_item_data_OPR-BOOOperationInternalID
***** %key-InspectionLotItem = '0010'
***** %key-BOOCharacteristicVersion = '00000032'
*****    )
*****     )
*****    RESULT DATA(lit_item_data).


  MODIFY ENTITIES OF ZQM_BA_PDIRHeader  IN LOCAL MODE
   ENTITY zqm_pdir_specification_list

UPDATE FIELDS ( res_mark1_ind )

WITH VALUE #( FOR key IN keys
                     (
%cid_ref                = ''
                       %is_draft               = lwa_mat_data-%is_draft

                       %key-cuuid              = key-cuuid
                       %key-InspectionLot      = key-InspectionLot
                       %key-InspectionLotItem        = key-InspectionLotItem
                       %key-InspectionPlanGroup        = key-InspectionPlanGroup
                       %key-BOOCharacteristicVersion        = key-BOOCharacteristicVersion
                       %key-BOOOperationInternalID        = key-BOOOperationInternalID

                       res_mark1_ind           = ind

                     %control-res_mark1_ind  = if_abap_behv=>mk-on

                     ) )

       FAILED DATA(fal)
             REPORTED DATA(rep)
             MAPPED DATA(map).

 READ ENTITY IN LOCAL MODE zqm_pdir_specification_list
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lit_item_CHECK) .
   reported = CORRESPONDING #( DEEP rep ).

  ENDMETHOD.

  METHOD resulttxt.
  ENDMETHOD.



ENDCLASS.

CLASS lhc_Header DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Header RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Header RESULT result.

    METHODS getpdf FOR MODIFY
      IMPORTING keys FOR ACTION Header~getpdf RESULT result.

    METHODS createinsplot FOR DETERMINE ON SAVE
      IMPORTING keys FOR Header~createinsplot.
    METHODS updateHeaderDetails FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Header~updateHeaderDetails.

ENDCLASS.

CLASS lhc_Header IMPLEMENTATION.

  METHOD get_instance_features.

    READ ENTITY IN LOCAL MODE ZQM_BA_PDIRHeader
              ALL FIELDS WITH CORRESPONDING #( keys )
              RESULT DATA(lt_header).

    SELECT * FROM ZQM_BA_PDIRItem
    WHERE Cuuid = @( VALUE #( lt_header[ 1 ]-Cuuid ) )
    INTO TABLE @DATA(lt_item).
    IF sy-subrc = 0.
      DATA(ls_item) = VALUE #( lt_item[ 1 ] OPTIONAL ).
    ENDIF.


    result = VALUE #( FOR ls_header IN lt_header ( %tky = ls_header-%tky
        %features-%field-inspectionlot      = COND #( WHEN ls_header-inspectionlot IS NOT INITIAL
                                                           THEN if_abap_behv=>fc-f-read_only
                                                      ELSE if_abap_behv=>fc-f-unrestricted )
        %features-%field-manufacturingorder = COND #( WHEN ls_header-manufacturingorder IS NOT INITIAL
                                                           THEN if_abap_behv=>fc-f-read_only
                                                      ELSE if_abap_behv=>fc-f-unrestricted )
        %features-%field-Material           = COND #( WHEN ls_header-Material IS NOT INITIAL
                                                           THEN if_abap_behv=>fc-f-read_only
                                                      ELSE if_abap_behv=>fc-f-unrestricted )
        %features-%field-Plant              = COND #( WHEN ls_header-Plant IS NOT INITIAL
                                                           THEN if_abap_behv=>fc-f-read_only
                                                      ELSE if_abap_behv=>fc-f-unrestricted )
        %features-%field-Batch              = COND #( WHEN ls_header-Batch IS NOT INITIAL
                                                           THEN if_abap_behv=>fc-f-read_only
                                                      ELSE if_abap_behv=>fc-f-unrestricted )
         %features-%field-MaterialDescription              = if_abap_behv=>fc-f-read_only

                   %features-%field-materiallongtxt              = if_abap_behv=>fc-f-read_only

                                                               %features-%field-CustomerName              = if_abap_behv=>fc-f-read_only
        %features-%field-Qcstatus           = COND #( WHEN ls_item-Result1 IS NOT INITIAL
                                                       AND ls_item-Result2 IS NOT INITIAL
                                                       AND ls_item-Result3 IS NOT INITIAL
                                                      THEN  if_abap_behv=>fc-f-unrestricted
                                                      ELSE  if_abap_behv=>fc-f-read_only )
                                                      ) ).


  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD getpdf.

   DATA: lit_create TYPE TABLE FOR CREATE ZQM_BA_PDIRHeader,
          lwa_create LIKE LINE OF lit_create.

    DATA : lit_data       TYPE TABLE OF ZQM_BA_PDIRHeader,
           lwa_data       TYPE zcds_qm_ins_lot_h,
           lit_data_i     TYPE TABLE OF zqm_pdir_specification_list,
           lv_base64      TYPE string,
           lit_header_upd TYPE TABLE FOR UPDATE ZQM_BA_PDIRHeader,
           lwa_header_upd LIKE LINE OF lit_header_upd,
           lv_token       TYPE string,
           lv_message     TYPE string,

           lit_itemdata   TYPE TABLE OF zqm_pdir_specification_list,
           lwa_itemdata   TYPE zqm_pdir_specification_list.


    READ ENTITIES OF ZQM_BA_PDIRHeader
      IN LOCAL MODE


      ENTITY Header
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lit_header_data)


      ENTITY Header by \_OperationItem
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lit_item_data_OPR)



      FAILED DATA(lit_failed).

data(lfs_lit_item_data_OPR) = value #(  lit_item_data_OPR[ 1 ]  ).
data(lfs_header) = value #(  lit_header_data[ 1 ]  ).

select InspectionLotItem , BOOCharacteristicVersion from zqm_t_pdir_spc
where cuuid = @lfs_lit_item_data_OPR-Cuuid and
inspectionplangroup = @lfs_lit_item_data_OPR-InspectionPlanGroup and
boooperationinternalid = @lfs_lit_item_data_OPR-BOOOperationInternalID
into TABLE @data(lft_zqm_t_pdir_spcd)
.


 READ ENTITY IN LOCAL MODE ZQM_PDIR_SPECIFICATION_LIST
    ALL FIELDS WITH value #(
    for lfs_zqm_t_pdir_spcd in lft_zqm_t_pdir_spcd

    (   %key-Cuuid = lfs_lit_item_data_OPR-Cuuid
    %key-Inspectionlot = lfs_lit_item_data_OPR-Inspectionlot
    %key-InspectionPlanGroup = lfs_lit_item_data_OPR-InspectionPlanGroup
    %key-BOOOperationInternalID = lfs_lit_item_data_OPR-BOOOperationInternalID
 %key-InspectionLotItem =  lfs_zqm_t_pdir_spcd-inspectionlotitem " '0010'
 %key-BOOCharacteristicVersion = lfs_zqm_t_pdir_spcd-boocharacteristicversion " '00000032'
    )
     )
    RESULT DATA(lit_item_data).

    MOVE-CORRESPONDING lit_header_data TO lit_data.
    MOVE-CORRESPONDING lit_item_data TO lit_data_i.

    zcl_btp_adobe_form=>get_ouath_token(
      EXPORTING
        im_oauth_url    = 'ADS_OAUTH_URL'
        im_clientid     = 'ADS_CLIENTID'
        im_clientsecret = 'ADS_CLIENTSECRET'
      IMPORTING
        ex_token        = lv_token
        ex_message      = lv_message
    ).

    zbp_qm_ba_pdirheader=>get_pdf_xml(
      EXPORTING
*       im_data    = lit_data
        im_data_h  = lit_data
        im_data_i  = lit_data_i
      IMPORTING
        ex_base_64 = lv_base64
    ).


    data lv_form_name type string.

    CASE lfs_header-formtype.
  WHEN 'Standard'.
    lv_form_name = 'ZPDIR/Standard_Template'.
    WHEN 'Boll Hoff'.
    lv_form_name = 'ZPDIR/BollHoff_Template'.
    WHEN 'Eastern'.
    lv_form_name = 'ZPDIR/Eastern_Template'.
    WHEN 'Fastnal Before'.
    lv_form_name = 'ZPDIR/Fastnal_Template'.
    WHEN 'JCB'.
    lv_form_name = 'ZPDIR/JCB_Template'.
    WHEN 'Spicer'.
    lv_form_name = 'ZPDIR/Spicer_Template'.
ENDCASE.




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


    DATA(lwa_data1) = VALUE #( lit_item_data[ 1 ] OPTIONAL ).

    MODIFY ENTITIES OF ZQM_BA_PDIRHeader IN LOCAL MODE
      ENTITY Header
      UPDATE FIELDS (  Attachments filename mimetype  )
      WITH VALUE #( FOR lwa_header IN lit_header_data ( %tky        = lwa_header-%tky
                                                        Attachments = lv_base64_decode
                                                        filename    = 'Form'
                                                        mimetype    = 'application/pdf'
                    ) )
    FAILED failed
    REPORTED reported.

    READ ENTITIES OF  ZQM_BA_PDIRHeader IN LOCAL MODE
          ENTITY zqm_pdir_specification_list
          ALL FIELDS WITH CORRESPONDING #( keys )
          RESULT DATA(lit_updateditem)
          ENTITY Header
          ALL FIELDS WITH CORRESPONDING #( keys )
          RESULT DATA(lit_updatedheader).

    " set the action result parameter
    result = VALUE #( FOR lwa_updatedheader IN lit_updatedheader ( %tky   = lwa_updatedheader-%tky
                                                                   %param = lwa_updatedheader ) ).

  ENDMETHOD.

  METHOD createinsplot.

    READ ENTITIES OF ZQM_BA_PDIRHeader IN LOCAL MODE
     ENTITY Header
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_mat_data).

    IF lt_mat_data IS NOT INITIAL.

      DATA(ls_mat_data) = VALUE #( lt_mat_data[ 1 ] OPTIONAL ).


      MODIFY ENTITIES OF I_InspectionLotTP_2 PRIVILEGED "IN LOCAL MODE
      ENTITY InspectionLot
          CREATE FIELDS ( Material Plant InspectionLotType InspectionLotQuantity  )
              WITH VALUE #( (
                            %cid                  = 'CID_001'
                            Material              = ls_mat_data-Material
                            Plant                 = ls_mat_data-Plant
                            InspectionLotType     = '89'
                            InspectionLotQuantity = 1
*                            ManufacturingOrder    = ls_mat_data-Manufacturingorder
                            ) )
          MAPPED DATA(mapped1)
          REPORTED DATA(reported1)
          FAILED DATA(failed).

      DATA(lv_ins_lot) = VALUE #( mapped1-inspectionlot[ 1 ]-InspectionLot OPTIONAL ).
      DATA(lv_mat) = ls_mat_data-material .

zbp_qm_ba_pdirheader=>gv_ins_lot = VALUE #( mapped1-inspectionlot[ 1 ]-InspectionLot OPTIONAL ).
*      SELECT * FROM I_InspectionLot
*      WHERE InspectionLot = @lv_ins_lot
*      INTO TABLE @DATA(lt_inspection).

      READ ENTITIES OF I_InspectionLotTP_2 PRIVILEGED
      ENTITY InspectionOperation
      ALL FIELDS WITH VALUE #( ( InspectionLot = lv_ins_lot ) )
      RESULT DATA(lt_insp_result).


     READ ENTITIES OF I_ProductTP_2 PRIVILEGED
      ENTITY ProductBasicText
      ALL FIELDS WITH VALUE #( ( %key-Product        = lv_mat
                                 %key-TextObjectType = 'GRUN'
                                 %key-Language       = 'E' ) )

      RESULT DATA(lit_prodtext)
      REPORTED DATA(lit_reported).
    DATA(lwa_prodtext) = VALUE #( lit_prodtext[ 1 ] OPTIONAL ).


*      SELECT SINGLE SalesOrder FROM I_ProductionOrder
*      WHERE ProductionOrder = @ls_mat_data-manufacturingorder
*      INTO @DATA(LV_SALESORDER) .
*
*      SELECT SINGLE SoldToParty FROM I_SalesOrder
*      WHERE SalesOrder = @LV_SALESORDER
*      INTO @DATA(LV_SoldToParty) .

      MODIFY ENTITIES OF ZQM_BA_PDIRHeader IN LOCAL MODE
      ENTITY Header
      UPDATE FIELDS ( InspectionLot
                      Material
                      Plant
                      ManufacturingOrder
                      salesorder
                      customer
                      materiallongtxt
                       )
      WITH VALUE #( "FOR key IN keys
                    ( %cid_ref               = ''
                      %is_draft              = ls_mat_data-%is_draft
                      Cuuid                  = VALUE #( keys[ 1 ]-cuuid OPTIONAL )
                      InspectionLot          = lv_ins_lot          ""mapped1-inspectionlot
                      Material               = ls_mat_data-Material
                      Plant                  = ls_mat_data-Plant
                      ManufacturingOrder     = ls_mat_data-ManufacturingOrder
                      materiallongtxt       = lwa_prodtext-ProductLongText
*                      salesorder             = LV_SALESORDER
*                      customer               = LV_SoldToParty
                      %control-InspectionLot = if_abap_behv=>mk-on
                      %control-Material      = if_abap_behv=>mk-on
                      %control-Plant         = if_abap_behv=>mk-on
*                      %control-ManufacturingOrder = if_abap_behv=>mk-on
                    ) )

               FAILED DATA(lt_fail)
               REPORTED DATA(lt_reported)
               MAPPED DATA(lt_mapped).

    ENDIF.

  ENDMETHOD.

  METHOD updateHeaderDetails.

   READ ENTITIES OF ZQM_BA_PDIRHeader IN LOCAL MODE
     ENTITY Header
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_mat_data).

data(ls_mat_data) = value #( lt_mat_data[ 1 ] OPTIONAL ).
        DATA(lv_ins_lot) = VALUE #( lt_mat_data[ 1 ]-manufacturingorder OPTIONAL ).


      SELECT SINGLE SalesOrder FROM I_ProductionOrder
      WHERE ProductionOrder = @lv_ins_lot
      INTO @DATA(LV_SALESORDER) .

      SELECT SINGLE SoldToParty FROM I_SalesOrder
      WHERE SalesOrder = @LV_SALESORDER
      INTO @DATA(LV_SoldToParty) .


      SELECT SINGLE CustomerName FROM I_Customer
      WHERE Customer = @LV_SoldToParty
      INTO @DATA(LV_CustomerName) .



SELECT SINGLE YY1_PP_Product_Desc_ORD FROM I_ProductionOrder WHERE ProductionOrder = @ls_mat_data-Manufacturingorder

INTO @DATA(LV_PRO_LONG_TXT).

SELECT SINGLE Material FROM I_productionordercomponent WHERE ProductionOrder = @ls_mat_data-Manufacturingorder

INTO @DATA(LV_raw_mat).



SELECT a~ClfnObjectID,
a~CharcInternalID,
a~CharcValue,
b~Characteristic
  FROM i_clfnobjectcharcvalforkeydate( p_keydate = @sy-datum ) as a
  inner join I_ClfnCharacteristicForKeyDate( p_keydate = @sy-datum ) as b on b~CharcInternalID = a~CharcInternalID
  WHERE ClfnObjectID  = @ls_mat_data-Material
  INTO TABLE @data(lft_char_value).


data(lv_drgno) = value #( lft_char_value[ Characteristic = 'DRAWING_NO' ]-CharcValue OPTIONAL  ).
data(lv_Grade) = value #( lft_char_value[ Characteristic = 'ITEM_GRADE' ]-CharcValue OPTIONAL  ).
data(lv_RmSpecification) = value #( lft_char_value[ Characteristic = '0000000823' ]-CharcValue OPTIONAL  ).
data(lv_PartNo) = value #( lft_char_value[ Characteristic = 'ITEM_CODE' ]-CharcValue OPTIONAL  ).



       loop at lt_mat_data into data(lfs_data).
       MODIFY ENTITIES OF ZQM_BA_PDIRHeader IN LOCAL MODE
    ENTITY Header
    UPDATE
    FIELDS (

    salesorder
    customer
    CustomerName
    materiallongtxt
    drgno
    partno


    ) WITH VALUE #( (  %tky =  lfs_data-%tky
                                 %is_draft = LFS_DATA-%is_draft
                                 salesorder             = LV_SALESORDER
                                 customer               = LV_SoldToParty
                                 CustomerName = LV_CustomerName
                                 materiallongtxt = LV_PRO_LONG_TXT
                                 drgno = lv_drgno
                                 partno = lv_PartNo
     ) )
    REPORTED DATA(LFT_REPORTED).

ENDLOOP.
*    reported = CORRESPONDING #( DEEP  LFT_REPORTED ).



  ENDMETHOD.

ENDCLASS.


CLASS lsc_ZQM_BA_ILOT_H DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZQM_BA_ILOT_H IMPLEMENTATION.

  METHOD save_modified.

    DATA : lt_item_ins TYPE STANDARD TABLE OF zqm_t_pdir_spc,
           lt_item_upd TYPE STANDARD TABLE OF zqm_t_pdir_spc,
           lt_item_del TYPE STANDARD TABLE OF zqm_t_pdir_spc.

      DATA : lt_item_ins_opr TYPE STANDARD TABLE OF zqm_t_pdir_1,
           lt_item_upd_opr TYPE STANDARD TABLE OF zqm_t_pdir_1,
           lt_item_del_opr TYPE STANDARD TABLE OF zqm_t_pdir_1.

    " --- Create Items ---
    if update-zqm_pdir_opertion_list is NOT INITIAL.


    loop at update-zqm_pdir_opertion_list into data(lfs_runtime).
    select single * from zqm_t_pdir_1
    where cuuid = @lfs_runtime-%key-Cuuid and inspectionlot = @lfs_runtime-%key-Inspectionlot
    into  @data(lfs_db_data)
    .

    if lfs_runtime-%control-result1 = '01'.
        lfs_db_data-result1 = lfs_runtime-result1.
    endif.

    if lfs_runtime-%control-result2 = '01'.
        lfs_db_data-result2 = lfs_runtime-result2.
    endif.

    if lfs_runtime-%control-result3 = '01'.
        lfs_db_data-result3 = lfs_runtime-result3.
    endif.

    if lfs_runtime-%control-result4 = '01'.
        lfs_db_data-result4 = lfs_runtime-result4.
    endif.

    if lfs_runtime-%control-result5 = '01'.
        lfs_db_data-result5 = lfs_runtime-result5.
    endif.

    if lfs_runtime-%control-result6 = '01'.
        lfs_db_data-result6 = lfs_runtime-result6.
    endif.

     if lfs_runtime-%control-result7 = '01'.
        lfs_db_data-result7 = lfs_runtime-result7.
    endif.

     if lfs_runtime-%control-result8 = '01'.
        lfs_db_data-result8 = lfs_runtime-result8.
    endif.

     if lfs_runtime-%control-result9 = '01'.
        lfs_db_data-result9 = lfs_runtime-result9.
    endif.

     if lfs_runtime-%control-result10 = '01'.
        lfs_db_data-result10 = lfs_runtime-result10.
    endif.

     if lfs_runtime-%control-result11 = '01'.
        lfs_db_data-result11 = lfs_runtime-result11.
    endif.

     if lfs_runtime-%control-result12 = '01'.
        lfs_db_data-result12 = lfs_runtime-result12.
    endif.


     if lfs_runtime-%control-result13 = '01'.
        lfs_db_data-result13 = lfs_runtime-result13.
    endif.



     if lfs_runtime-%control-result14 = '01'.
        lfs_db_data-result14 = lfs_runtime-result14.
    endif.



     if lfs_runtime-%control-result15 = '01'.
        lfs_db_data-result15 = lfs_runtime-result15.
    endif.



     if lfs_runtime-%control-result16 = '01'.
        lfs_db_data-result16 = lfs_runtime-result16.
    endif.


*****    lt_item_upd_opr = CORRESPONDING #( update-zqm_pdir_opertion_list ).
      " Update items by key
      MODIFY zqm_t_pdir_1 FROM  @lfs_db_data.

        clear :lfs_runtime.
    endloop.


    endif.




    IF create-zqm_pdir_specification_list IS NOT INITIAL.

      lt_item_ins = CORRESPONDING #( create-zqm_pdir_specification_list
              MAPPING
cuuid = cuuid
boooperationinternalid = boooperationinternalid
inspectionlotitem = inspectionlotitem
inspectionlot = inspectionlot

boocharacteristicversion = boocharacteristicversion
inspectionplangroup = inspectionplangroup


                result1  = result1
result2  = result2
result3  = result3
result4  = result4
result5  = result5
result6  = result6
result7  = result7
result8  = result8
result9  = result9
result10  = result10
result11  = result11
result12  = result12
result13  = result13
result14  = result14
result15  = result15
result16  = result16
            ).

      LOOP AT lt_item_ins ASSIGNING FIELD-SYMBOL(<ls_item>).
        IF zbp_qm_ba_pdirheader=>gv_ins_lot IS NOT INITIAL.
          <ls_item>-inspectionlot = zbp_qm_ba_pdirheader=>gv_ins_lot.
        ENDIF.
      ENDLOOP.

      INSERT zqm_t_pdir_spc FROM TABLE @lt_item_ins.

    ENDIF.

    IF update-zqm_pdir_specification_list IS NOT INITIAL.
      lt_item_upd = CORRESPONDING #( update-zqm_pdir_specification_list ).
      " Update items by key
      MODIFY zqm_t_pdir_spc FROM TABLE @lt_item_upd.
    ENDIF.

    " --- Delete Items ---
    IF delete-zqm_pdir_specification_list IS NOT INITIAL.
      lt_item_del = CORRESPONDING #( delete-zqm_pdir_specification_list ).
      " Delete items by key
      DELETE zqm_t_pdir_spc FROM TABLE @lt_item_del.
    ENDIF.

  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
