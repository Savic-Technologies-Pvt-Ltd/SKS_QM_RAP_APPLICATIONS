CLASS lhc_zqm_i_pdiritem_new DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR ZQM_I_PDIRITEM_NEW RESULT result.

    METHODS field_readonly FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZQM_I_PDIRITEM_NEW~field_readonly.

ENDCLASS.

CLASS lhc_zqm_i_pdiritem_new IMPLEMENTATION.

  METHOD get_instance_features.

  READ ENTITIES OF ZQM_I_PDIRHeader_NEW
 IN LOCAL MODE
    ENTITY ZQM_I_PDIRHeader_NEW

    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lit_mat_data).

    READ ENTITY IN LOCAL MODE ZQM_I_PDIRITEM_NEW

      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lit_item) .
    DATA(lwa_mat_data) = VALUE #( lit_mat_data[ 1 ] OPTIONAL  ).

    result = VALUE #( FOR row IN lit_item ( %tky = row-%tky
            %features-%field-Result1  = COND #( WHEN row-ResMark1Ind  IS NOT INITIAL OR row-Result1  IS NOT INITIAL THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
            %features-%field-Result2  = COND #( WHEN row-ResMark2Ind  IS NOT INITIAL OR row-Result2  IS NOT INITIAL THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
            %features-%field-Result3  = COND #( WHEN row-ResMark3Ind  IS NOT INITIAL OR row-Result3  IS NOT INITIAL THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
            %features-%field-Result4  = COND #( WHEN row-ResMark4Ind  IS NOT INITIAL OR row-Result4  IS NOT INITIAL THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
            %features-%field-Result5  = COND #( WHEN row-ResMark5Ind  IS NOT INITIAL OR row-Result5  IS NOT INITIAL THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
            %features-%field-Result6  = COND #( WHEN row-ResMark6Ind  IS NOT INITIAL OR row-Result6  IS NOT INITIAL THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
            %features-%field-Result7  = COND #( WHEN row-ResMark7Ind  IS NOT INITIAL OR row-Result7  IS NOT INITIAL THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
            %features-%field-Result8  = COND #( WHEN row-ResMark8Ind  IS NOT INITIAL OR row-Result8  IS NOT INITIAL THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
            %features-%field-Result9  = COND #( WHEN row-ResMark9Ind  IS NOT INITIAL OR row-Result9  IS NOT INITIAL THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
            %features-%field-Result10 = COND #( WHEN row-ResMark10Ind IS NOT INITIAL OR row-Result10 IS NOT INITIAL THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
            %features-%field-Result11 = COND #( WHEN row-ResMark11Ind IS NOT INITIAL OR row-Result11 IS NOT INITIAL THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
            %features-%field-Remark = COND #( WHEN row-Remark IS NOT INITIAL  THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )

                                                        ) ).



  ENDMETHOD.

  METHOD field_readonly.

*   READ ENTITY IN LOCAL MODE ZQM_I_PDIRITEM_NEW
*
*    ALL FIELDS WITH CORRESPONDING #( keys )
*    RESULT DATA(lit_item) .
*    DATA(lwa_mat_data) = VALUE #( lit_item[ 1 ] OPTIONAL  ).
*
*    DATA : ind TYPE c.
*
*    ind = lwa_mat_data-ResMark1.
*    DATA(ind1) = lwa_mat_data-ResMark2.
*    DATA(ind2) = lwa_mat_data-ResMark3.
*    DATA(ind3) = lwa_mat_data-ResMark4.
*    DATA(ind4) = lwa_mat_data-ResMark5.
*    DATA(ind5) = lwa_mat_data-ResMark6.
*    DATA(ind6) = lwa_mat_data-ResMark7.
*    DATA(ind7) = lwa_mat_data-ResMark8.
*    DATA(ind8) = lwa_mat_data-ResMark9.
*    DATA(ind9) = lwa_mat_data-ResMark10.
*    IF lwa_mat_data-ResMark1 IS INITIAL AND lwa_mat_data-Result1 IS NOT INITIAL.
*      ind = 'X'.
*    endif.
*
*
*    MODIFY ENTITIES OF ZQM_I_PDIRHeader_NEW
*
* IN LOCAL MODE
*                  ENTITY ZQM_I_PDIRITEM_NEW
*
*
*                   UPDATE FIELDS ( ResMark1Ind  )
*       WITH VALUE #( FOR key IN keys
*                     ( %cid_ref                = ''
*                       %is_draft               = lwa_mat_data-%is_draft
*                       %key-cuuid              = key-cuuid
*                       %key-InspectionLot      = key-InspectionLot
*                       %key-Inspectionlotitem        = key-Inspectionlotitem
*
*                        %key-BOOOperationInternalID = key-Boooperationinternalid
*
*                          %key-BOOCharacteristicVersion = key-Boocharacteristicversion
*    %key-InspectionPlanGroup = key-Inspectionplangroup
*
*
*
*                       ResMark1Ind           = ind
*
*                       %control-ResMark1Ind  = if_abap_behv=>mk-on
*
*                     ) )
*
*       FAILED DATA(fal)
*             REPORTED DATA(rep)
*             MAPPED DATA(map).

  ENDMETHOD.

ENDCLASS.

CLASS lsc_zqm_i_pdirheader_new DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

ENDCLASS.

CLASS lsc_zqm_i_pdirheader_new IMPLEMENTATION.

  METHOD save_modified.


    DATA : lt_item_ins TYPE STANDARD TABLE OF zqm_t_pdir_IT
,
 ls_item_upd TYPE  zqm_t_pdir_IT,
           lt_item_upd TYPE STANDARD TABLE OF zqm_t_pdir_IT
,
           lt_item_del TYPE STANDARD TABLE OF zqm_t_pdir_IT
.
 IF create-zqm_i_pdiritem_new IS NOT INITIAL.

      lt_item_ins = CORRESPONDING #( create-zqm_i_pdiritem_new
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
        IF zbp_qm_i_pdirheader_new=>gv_ins_lot IS NOT INITIAL.
          <ls_item>-inspectionlot = zbp_qm_i_pdirheader_new=>gv_ins_lot.
        ENDIF.
      ENDLOOP.

      INSERT zqm_t_pdir_IT
 FROM TABLE @lt_item_ins.

    ENDIF.


DATA: ls_diff TYPE zqm_t_pdir_it.   "Structure holding only changed fields

DATA(lo_struct_descr) = CAST cl_abap_structdescr(
                            cl_abap_typedescr=>describe_by_data( ls_item_upd ) ).

DATA(lt_components) = lo_struct_descr->get_components( ).

FIELD-SYMBOLS: <lv_old> TYPE any,
               <lv_new> TYPE any,
               <lv_diff> TYPE any.


    IF update-zqm_i_pdiritem_new IS NOT INITIAL.
      loop at update-zqm_i_pdiritem_new into data(lfs_item_db).
        select single * from zqm_t_pdir_IT
         where cuuid = @lfs_item_db-cuuid
      AND boooperationinternalid = @lfs_item_db-boooperationinternalid
      AND inspectionlotitem = @lfs_item_db-inspectionlotitem
      into CORRESPONDING FIELDS OF @ls_item_upd.
        if sy-subrc = 0.
       IF lfs_item_db-%control-result1 = '01'.
          ls_item_upd-result1 = lfs_item_db-result1.
        ENDIF.

        IF lfs_item_db-%control-result2 = '01'.
          ls_item_upd-result2 = lfs_item_db-result2.
        ENDIF.

        IF lfs_item_db-%control-result3 = '01'.
          ls_item_upd-result3 = lfs_item_db-result3.
        ENDIF.

        IF lfs_item_db-%control-result4 = '01'.
          ls_item_upd-result4 = lfs_item_db-result4.
        ENDIF.

        IF lfs_item_db-%control-result5 = '01'.
          ls_item_upd-result5 = lfs_item_db-result5.
        ENDIF.

        IF lfs_item_db-%control-result6 = '01'.
          ls_item_upd-result6 = lfs_item_db-result6.
        ENDIF.

        IF lfs_item_db-%control-result7 = '01'.
          ls_item_upd-result7 = lfs_item_db-result7.
        ENDIF.

        IF lfs_item_db-%control-result8 = '01'.
          ls_item_upd-result8 = lfs_item_db-result8.
        ENDIF.

        IF lfs_item_db-%control-result9 = '01'.
          ls_item_upd-result9 = lfs_item_db-result9.
        ENDIF.

        IF lfs_item_db-%control-result10 = '01'.
          ls_item_upd-result10 = lfs_item_db-result10.
        ENDIF.

        IF lfs_item_db-%control-result11 = '01'.
          ls_item_upd-result11 = lfs_item_db-result11.
        ENDIF.

        IF lfs_item_db-%control-result12 = '01'.
          ls_item_upd-result12 = lfs_item_db-result12.
        ENDIF.

        IF lfs_item_db-%control-result13 = '01'.
          ls_item_upd-result13 = lfs_item_db-result13.
        ENDIF.

        IF lfs_item_db-%control-result14 = '01'.
          ls_item_upd-result14 = lfs_item_db-result14.
        ENDIF.

        IF lfs_item_db-%control-result15 = '01'.
          ls_item_upd-result15 = lfs_item_db-result15.
        ENDIF.

        IF lfs_item_db-%control-result16 = '01'.
          ls_item_upd-result16 = lfs_item_db-result16.
        ENDIF.

 MODIFY zqm_t_pdir_IT FROM  @ls_item_upd.
        clear :lfs_item_db.
    else.

    ls_item_upd = CORRESPONDING #( lfs_item_db ) .
    MODIFY zqm_t_pdir_IT FROM  @ls_item_upd.
        clear :lfs_item_db.

    endif.



      ENDLOOP..



      lt_item_upd = CORRESPONDING #( update-zqm_i_pdiritem_new ).
      " Update items by key

    ENDIF.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_zqm_i_pdirheader_new DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zqm_i_pdirheader_new RESULT result.
    METHODS createinsplot FOR DETERMINE ON SAVE
      IMPORTING keys FOR zqm_i_pdirheader_new~createinsplot.
    METHODS getpdf FOR MODIFY
      IMPORTING keys FOR ACTION zqm_i_pdirheader_new~getpdf RESULT result.

    METHODS updateheaderdetails FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zqm_i_pdirheader_new~updateheaderdetails.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zqm_i_pdirheader_new RESULT result.

ENDCLASS.

CLASS lhc_zqm_i_pdirheader_new IMPLEMENTATION.

  METHOD get_instance_authorizations.


  ENDMETHOD.

  METHOD createinsplot.

     READ ENTITIES OF ZQM_I_PDIRHeader_NEW
 IN LOCAL MODE
     ENTITY ZQM_I_PDIRHeader_NEW
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

zbp_qm_i_pdirheader_new=>gv_ins_lot = VALUE #( mapped1-inspectionlot[ 1 ]-InspectionLot OPTIONAL ).
*      SELECT * FROM I_InspectionLot
*      WHERE InspectionLot = @lv_ins_lot
*      INTO TABLE @DATA(lt_inspection).

      READ ENTITIES OF I_InspectionLotTP_2 PRIVILEGED
      ENTITY InspectionOperation
      ALL FIELDS WITH VALUE #( ( InspectionLot = lv_ins_lot ) )
      RESULT DATA(lt_insp_result).


*     READ ENTITIES OF I_ProductTP_2 PRIVILEGED
*      ENTITY ProductBasicText
*      ALL FIELDS WITH VALUE #( ( %key-Product        = lv_mat
*                                 %key-TextObjectType = 'GRUN'
*                                 %key-Language       = 'E' ) )
*
*      RESULT DATA(lit_prodtext)
*      REPORTED DATA(lit_reported).
*    DATA(lwa_prodtext) = VALUE #( lit_prodtext[ 1 ] OPTIONAL ).


*      SELECT SINGLE SalesOrder FROM I_ProductionOrder
*      WHERE ProductionOrder = @ls_mat_data-manufacturingorder
*      INTO @DATA(LV_SALESORDER) .
*
*      SELECT SINGLE SoldToParty FROM I_SalesOrder
*      WHERE SalesOrder = @LV_SALESORDER
*      INTO @DATA(LV_SoldToParty) .

      MODIFY ENTITIES OF ZQM_I_PDIRHeader_NEW
 IN LOCAL MODE
      ENTITY ZQM_I_PDIRHeader_NEW
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
                   "   materiallongtxt       = lwa_prodtext-ProductLongText
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


    READ ENTITIES OF ZQM_I_PDIRHeader_NEW

      IN LOCAL MODE


      ENTITY ZQM_I_PDIRHeader_NEW
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lit_header_data)


      ENTITY ZQM_I_PDIRHeader_NEW by \_Item
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lit_item_data_OPR)



      FAILED DATA(lit_failed).

data(lfs_lit_item_data_OPR) = value #(  lit_item_data_OPR[ 1 ]  ).
data(lfs_header) = value #(  lit_header_data[ 1 ]  ).

select InspectionLotItem , BOOCharacteristicVersion from zqm_t_pdir_IT

where cuuid = @lfs_lit_item_data_OPR-Cuuid and
inspectionplangroup = @lfs_lit_item_data_OPR-InspectionPlanGroup and
boooperationinternalid = @lfs_lit_item_data_OPR-BOOOperationInternalID
into TABLE @data(lft_zqm_t_pdir_spcd)
.


 READ ENTITY IN LOCAL MODE ZQM_I_PDIRITEM_NEW

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

    zbp_qm_i_pdirheader_new=>get_pdf_xml(
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

    MODIFY ENTITIES OF ZQM_I_PDIRHeader_NEW
 IN LOCAL MODE
      ENTITY ZQM_I_PDIRHeader_NEW
      UPDATE FIELDS (  Attachments filename mimetype  )
      WITH VALUE #( FOR lwa_header IN lit_header_data ( %tky        = lwa_header-%tky
                                                        Attachments = lv_base64_decode
                                                        filename    = 'Form'
                                                        mimetype    = 'application/pdf'
                    ) )
    FAILED failed
    REPORTED reported.

    READ ENTITIES OF  ZQM_I_PDIRHeader_NEW
 IN LOCAL MODE
          ENTITY zqm_i_pdiritem_new
          ALL FIELDS WITH CORRESPONDING #( keys )
          RESULT DATA(lit_updateditem)
          ENTITY ZQM_I_PDIRHeader_NEW
          ALL FIELDS WITH CORRESPONDING #( keys )
          RESULT DATA(lit_updatedheader).

    " set the action result parameter
    result = VALUE #( FOR lwa_updatedheader IN lit_updatedheader ( %tky   = lwa_updatedheader-%tky
                                                                   %param = lwa_updatedheader ) ).
  ENDMETHOD.

  METHOD updateHeaderDetails.

    DATA lv_ins_lot TYPE I_InspectionLot-InspectionLot.

    READ ENTITIES OF ZQM_I_PDIRHeader_NEW
 IN LOCAL MODE
     ENTITY ZQM_I_PDIRHeader_NEW
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_mat_data).

data(ls_mat_data) = value #( lt_mat_data[ 1 ] OPTIONAL ).
        lv_ins_lot = VALUE #( lt_mat_data[ 1 ]-manufacturingorder OPTIONAL ).

        lv_ins_lot = |{  lv_ins_lot ALPHA = IN }|.
      SELECT SINGLE SalesOrder , BillOfOperationsMaterial,ProductionPlant FROM I_ProductionOrder
      WHERE ProductionOrder = @lv_ins_lot
      INTO  (  @DATA(LV_SALESORDER) , @data(lv_Material) , @data(lv_ProductionPlant) ) .

      SELECT SINGLE SoldToParty FROM I_SalesOrder
      WHERE SalesOrder = @LV_SALESORDER
      INTO @DATA(LV_SoldToParty) .


      select single ProductName from I_ProductText  where Product = @lv_Material and Language = 'E'
      into @data(lv_Material_desc).

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
data(lv_RAW_MATERIAL_GRADE) = value #( lft_char_value[ Characteristic = 'RAW_MATERIAL_GRADE' ]-CharcValue OPTIONAL  ).
data(lv_DRAWING_REVISION_NO) = value #( lft_char_value[ Characteristic = 'DRAWING_REVISION_NO' ]-CharcValue OPTIONAL  ).
data(lv_Grade) = value #( lft_char_value[ Characteristic = 'ITEM_GRADE' ]-CharcValue OPTIONAL  ).
data(lv_RmSpecification) = value #( lft_char_value[ Characteristic = '0000000823' ]-CharcValue OPTIONAL  ).
data(lv_PartNo) = value #( lft_char_value[ Characteristic = 'ITEM_CODE' ]-CharcValue OPTIONAL  ).



       loop at lt_mat_data into data(lfs_data).
       MODIFY ENTITIES OF ZQM_I_PDIRHeader_NEW
        IN LOCAL MODE
    ENTITY ZQM_I_PDIRHeader_NEW
    UPDATE
    FIELDS (

    salesorder
    customer
    CustomerName
    materiallongtxt
    drgno
    partno
    Material
    Plant
    Rawmaterial
    SksDraw
    Materialdescription


    ) WITH VALUE #( (  %tky =  lfs_data-%tky
                                 %is_draft = LFS_DATA-%is_draft
                                 salesorder             = LV_SALESORDER
                                 customer               = LV_SoldToParty
                                 CustomerName = LV_CustomerName
                                 materiallongtxt = LV_PRO_LONG_TXT
                                 drgno = lv_drgno
                                 partno = lv_PartNo
                                 Material = lv_Material
                                 Plant = lv_ProductionPlant
                                 Rawmaterial = lv_RAW_MATERIAL_GRADE
                                 SksDraw = lv_DRAWING_REVISION_NO
                                 Materialdescription = lv_Material_desc
     ) )
    REPORTED DATA(LFT_REPORTED).

ENDLOOP.
*    reported = CORRESPONDING #( DEEP  LFT_REPORTED ).

  ENDMETHOD.

  METHOD get_instance_features.

   READ ENTITY IN LOCAL MODE ZQM_I_PDIRHeader_NEW

              ALL FIELDS WITH CORRESPONDING #( keys )
              RESULT DATA(lt_header).

    SELECT * FROM zqm_t_pdir_IT

    WHERE Cuuid = @( VALUE #( lt_header[ 1 ]-Cuuid ) )
    INTO TABLE @DATA(lt_item).
    IF sy-subrc = 0.
      DATA(ls_item) = VALUE #( lt_item[ 1 ] OPTIONAL ).
    ENDIF.


    result = VALUE #( FOR ls_header IN lt_header ( %tky = ls_header-%tky
        %features-%field-inspectionlot      =
                                                           if_abap_behv=>fc-f-read_only

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

                                                      ) ).

  ENDMETHOD.

ENDCLASS.
