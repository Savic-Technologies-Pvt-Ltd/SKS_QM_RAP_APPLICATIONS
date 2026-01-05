CLASS lhc_Header DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PUBLIC SECTION.
    DATA : lt_3_keys TYPE TABLE FOR READ IMPORT zqm_ba_inprocessinspection_3.

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

    READ ENTITIES OF ZQM_BA_InprocessInspection_1 IN LOCAL MODE
    ENTITY Header
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lit_mat_data).

    READ ENTITY IN LOCAL MODE ZQM_BA_InprocessInspection_1
            ALL FIELDS WITH CORRESPONDING #( keys )
            RESULT DATA(resi).

    lt_3_keys = VALUE #( FOR ls_res IN resi
                         ( Cuuid = ls_res-cuuid ) ).

    SELECT * FROM ZQM_BA_InprocessInspection_3
    WHERE Cuuid = @( VALUE #( lt_3_keys[ 1 ]-Cuuid ) )
    INTO TABLE @DATA(lt_item).

*    READ ENTITY IN LOCAL MODE ZQM_BA_InprocessInspection_3
*            ALL FIELDS WITH lt_3_keys
*            RESULT DATA(lt_item).

    result = VALUE #( FOR row IN resi ( %tky = row-%tky
        %features-%field-inspectionlot      = COND #( WHEN row-inspectionlot IS NOT INITIAL
                                                           THEN if_abap_behv=>fc-f-read_only
                                                      ELSE if_abap_behv=>fc-f-unrestricted )
        %features-%field-manufacturingorder = COND #( WHEN row-manufacturingorder IS NOT INITIAL
                                                           THEN if_abap_behv=>fc-f-read_only
                                                      ELSE if_abap_behv=>fc-f-unrestricted )
        %features-%field-Material           = COND #( WHEN row-Material IS NOT INITIAL
                                                           THEN if_abap_behv=>fc-f-read_only
                                                      ELSE if_abap_behv=>fc-f-unrestricted )
        %features-%field-Plant              = COND #( WHEN row-Plant IS NOT INITIAL
                                                           THEN if_abap_behv=>fc-f-read_only
                                                      ELSE if_abap_behv=>fc-f-unrestricted )
        %features-%field-Batch              = COND #( WHEN row-Batch IS NOT INITIAL
                                                           THEN if_abap_behv=>fc-f-read_only
                                                      ELSE if_abap_behv=>fc-f-unrestricted )

        %features-%field-Qcstatus           = COND #( WHEN lt_item IS NOT INITIAL
                                                       AND lt_item[ 1 ]-Res1 IS NOT INITIAL
                                                       AND lt_item[ 1 ]-Res2 IS NOT INITIAL
                                                       AND lt_item[ 1 ]-Res3 IS NOT INITIAL
                                                      THEN  if_abap_behv=>fc-f-unrestricted
                                                      ELSE  if_abap_behv=>fc-f-read_only )
                                                      ) ).


  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD getpdf.

  DATA: lit_create TYPE TABLE FOR CREATE ZQM_BA_InprocessInspection_1,
          lwa_create LIKE LINE OF lit_create.

    DATA : lit_data       TYPE TABLE OF ZQM_BA_InprocessInspection_1,
           lwa_data       TYPE ZQM_BA_InprocessInspection_1,
           lit_data_i     TYPE TABLE OF ZQM_BA_InprocessInspection_3,
           lv_base64      TYPE string,
           lit_header_upd TYPE TABLE FOR UPDATE ZQM_BA_InprocessInspection_1,
           lwa_header_upd LIKE LINE OF lit_header_upd,
           lv_token       TYPE string,
           lv_message     TYPE string,

           lit_itemdata   TYPE TABLE OF ZQM_BA_InprocessInspection_3,
           lwa_itemdata   TYPE ZQM_BA_InprocessInspection_3.


    READ ENTITIES OF ZQM_BA_InprocessInspection_1
      IN LOCAL MODE


      ENTITY Header
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lit_header_data)


      ENTITY Header by \_item_operation
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lit_item_data_OPR)



      FAILED DATA(lit_failed).

data(lfs_lit_item_data_OPR) = value #(  lit_item_data_OPR[ 1 ]  ).
data(lfs_header) = value #(  lit_header_data[ 1 ]  ).

select insp_lot_item ,BOOCharacteristicVersion from zqm_t_inpr_ins_3
where cuuid = @lfs_lit_item_data_OPR-Cuuid
into TABLE @data(lft_zqm_t_pdir_spcd)
.


 READ ENTITY IN LOCAL MODE ZQM_BA_InprocessInspection_3
    ALL FIELDS WITH value #(
    for lfs_zqm_t_pdir_spcd in lft_zqm_t_pdir_spcd

    (   %key-Cuuid = lfs_lit_item_data_OPR-Cuuid
    %key-Inspectionlot = lfs_lit_item_data_OPR-Inspectionlot
    %key-InspectionPlanGroup = lfs_lit_item_data_OPR-InspectionPlanGroup
    %key-BOOOperationInternalID = lfs_lit_item_data_OPR-BOOOperationInternalID
 %key-InspLotItem =  lfs_zqm_t_pdir_spcd-insp_lot_item " '0010'
 %key-BOOCharacteristicVersion = lfs_zqm_t_pdir_spcd-BOOCharacteristicVersion
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

    ZBP_QM_BA_INPROCESSINSPECTION_=>get_pdf_xml(
      EXPORTING
*       im_data    = lit_data
        im_data_h  = lit_data
        im_data_i  = lit_data_i
      IMPORTING
        ex_base_64 = lv_base64
    ).


    data lv_form_name type string.

    CASE lfs_header-formtype.
  WHEN 'Cust 1'.
    lv_form_name = 'ZINPROCESS_INSPECTION/QC_Cust1_Template'.
  WHEN 'Cust 2'.
    lv_form_name = 'ZINPROCESS_INSPECTION/QC_Cust2_Template'.
  WHEN 'Default'.
    lv_form_name = 'ZINPROCESS_INSPECTION/QC_Default_Template'.
  WHEN 'Earnest'.
    lv_form_name = 'ZINPROCESS_INSPECTION/Earnest_Template'.
  WHEN 'Fastenal'.
    lv_form_name = 'ZINPROCESS_INSPECTION/Fastenal_Template'.
  WHEN 'JD'.
    lv_form_name = 'ZINPROCESS_INSPECTION/JD_TEMPLATE'.
  WHEN 'Meritor'.
    lv_form_name = 'ZINPROCESS_INSPECTION/Meritor_Template'.
  WHEN 'Optimus'.
    lv_form_name = 'ZINPROCESS_INSPECTION/Optimus_Template'.
  WHEN 'WLOT'.
    lv_form_name = 'ZINPROCESS_INSPECTION/WLOT_Template'.
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


****    DATA(lwa_data1) = VALUE #( lit_item_data[ 1 ] OPTIONAL ).

    MODIFY ENTITIES OF ZQM_BA_InprocessInspection_1 IN LOCAL MODE
      ENTITY Header
      UPDATE FIELDS (  Attachments filename mimetype  )
      WITH VALUE #( FOR lwa_header IN lit_header_data ( %tky        = lwa_header-%tky
                                                        Attachments = lv_base64_decode
                                                        filename    = 'Form'
                                                        mimetype    = 'application/pdf'
                    ) )
    FAILED failed
    REPORTED reported.
*****
    READ ENTITIES OF  ZQM_BA_InprocessInspection_1 IN LOCAL MODE
****          ENTITY zqm_pdir_specification_list
****          ALL FIELDS WITH CORRESPONDING #( keys )
****          RESULT DATA(lit_updateditem)
          ENTITY Header
          ALL FIELDS WITH CORRESPONDING #( keys )
          RESULT DATA(lit_updatedheader).

    " set the action result parameter
    result = VALUE #( FOR lwa_updatedheader IN lit_updatedheader ( %tky   = lwa_updatedheader-%tky
                                                                   %param = lwa_updatedheader ) ).
  ENDMETHOD.

  METHOD createinsplot.

    READ ENTITIES OF ZQM_BA_InprocessInspection_1 IN LOCAL MODE
       ENTITY Header
       ALL FIELDS WITH CORRESPONDING #( keys )
       RESULT DATA(lit_mat_data).

    DATA(lwa_mat_data) = VALUE #( lit_mat_data[ 1 ] OPTIONAL ).


    MODIFY ENTITIES OF I_InspectionLotTP_2 PRIVILEGED "IN LOCAL MODE
    ENTITY InspectionLot
        CREATE FIELDS ( material plant inspectionlottype inspectionlotquantity  )
            WITH VALUE #( (
                          %cid                  = 'CID_001'
                          material              = lwa_mat_data-Material
                          plant                 = lwa_mat_data-Plant
                          inspectionlottype     = '89'
                          inspectionlotquantity = 1
*                          ManufacturingOrder    = '001100000003'
                          ) )
        MAPPED DATA(mapped1)
        REPORTED DATA(reported1)
        FAILED DATA(failed).

    DATA(lv_ins_lot) = VALUE #( mapped1-inspectionlot[ 1 ]-InspectionLot OPTIONAL ).
zbp_qm_ba_inprocessinspection_=>gv_ins_lot = VALUE #( mapped1-inspectionlot[ 1 ]-InspectionLot OPTIONAL ).


    MODIFY ENTITIES OF  ZQM_BA_InprocessInspection_1 IN LOCAL MODE
                  ENTITY Header
                   UPDATE FIELDS ( InspectionLot Material Plant ManufacturingOrder )
       WITH VALUE #( FOR key IN keys
                     ( %cid_ref                    = ''
                       %is_draft                   = lwa_mat_data-%is_draft
                       cuuid                       = key-cuuid

                       InspectionLot               = lv_ins_lot  ""mapped1-inspectionlot
                       Material                    = lwa_mat_data-Material
                       Plant                       = lwa_mat_data-Plant
                       ManufacturingOrder          = lwa_mat_data-ManufacturingOrder
                       %control-InspectionLot      = if_abap_behv=>mk-on
                       %control-Material           = if_abap_behv=>mk-on
                       %control-Plant              = if_abap_behv=>mk-on
                       %control-ManufacturingOrder = if_abap_behv=>mk-on
                     ) )

       FAILED DATA(fal)
             REPORTED DATA(rep)
             MAPPED DATA(map).



  ENDMETHOD.

  METHOD updateHeaderDetails.

  READ ENTITIES OF ZQM_BA_InprocessInspection_1 IN LOCAL MODE
     ENTITY Header
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_mat_data).

        DATA(lv_ins_lot) = VALUE #( lt_mat_data[ 1 ]-manufacturingorder OPTIONAL ).


      SELECT SINGLE SalesOrder FROM I_ProductionOrder
      WHERE ProductionOrder = @lv_ins_lot
      INTO @DATA(LV_SALESORDER) .

      SELECT SINGLE SoldToParty FROM I_SalesOrder
      WHERE SalesOrder = @LV_SALESORDER
      INTO @DATA(LV_SoldToParty) .
       loop at lt_mat_data into data(lfs_data).
       MODIFY ENTITIES OF ZQM_BA_InprocessInspection_1 IN LOCAL MODE
    ENTITY Header
    UPDATE
    FIELDS (

    salesorder
    customer ) WITH VALUE #( (  %tky =  lfs_data-%tky
                                 %is_draft = LFS_DATA-%is_draft
                                 salesorder             = LV_SALESORDER
                                 customer               = LV_SoldToParty
     ) )
    REPORTED DATA(LFT_REPORTED).

ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZQM_BA_INPROCESSINSPECTION DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZQM_BA_INPROCESSINSPECTION IMPLEMENTATION.

  METHOD save_modified.

   DATA :  lt_item_ins TYPE STANDARD TABLE OF zqm_t_inpr_ins_2,
           lt_item_upd TYPE STANDARD TABLE OF zqm_t_inpr_ins_2,
           lt_item_del TYPE STANDARD TABLE OF zqm_t_inpr_ins_2.

      DATA : lt_item_ins_opr TYPE STANDARD TABLE OF zqm_t_inpr_ins_1,
           lt_item_upd_opr TYPE STANDARD TABLE OF zqm_t_inpr_ins_1,
           lt_item_del_opr TYPE STANDARD TABLE OF zqm_t_inpr_ins_1.

    " --- Create Items ---
    if update-item_operation is NOT INITIAL.

    lt_item_upd_opr = CORRESPONDING #( update-item_operation ).
      " Update items by key
      MODIFY zqm_t_inpr_ins_1 FROM TABLE @lt_item_upd_opr.
    endif.



      " --- Create Items ---

    IF create-item IS NOT INITIAL.

      lt_item_ins = CORRESPONDING #( create-item
              MAPPING
cuuid = cuuid
**boooperationinternalid = boooperationinternalid
insp_lot_item = InspLotItem
inspectionlot = inspectionlot

***boocharacteristicversion = boocharacteristicversion
***inspectionplangroup = inspectionplangroup

      boocharacteristicversion = BOOCharacteristicVersion
      boooperationinternalid = BOOOperationInternalID
      inspectionplangroup = InspectionPlanGroup
 res1 = Res1
      res2 = Res2
      res3 = Res3
      res4 = Res4
      res5 = Res5

            ).

      LOOP AT lt_item_ins ASSIGNING FIELD-SYMBOL(<ls_item>).
        IF zbp_qm_ba_inprocessinspection_=>gv_ins_lot IS NOT INITIAL.
          <ls_item>-inspectionlot = zbp_qm_ba_inprocessinspection_=>gv_ins_lot.
        ENDIF.
      ENDLOOP.

      INSERT zqm_t_inpr_ins_2 FROM TABLE @lt_item_ins.

    ENDIF.

   if update-item is not INITIAL.

      lt_item_upd = CORRESPONDING #( update-item MAPPING
      inspectionlot = Inspectionlot
      cuuid = Cuuid
      insp_lot_item = InspLotItem
      boocharacteristicversion = BOOCharacteristicVersion
      boooperationinternalid = BOOOperationInternalID
      inspectionplangroup = InspectionPlanGroup
      res1 = Res1
      res2 = Res2
      res3 = Res3
      res4 = Res4
      res5 = Res5
       ).

      " Update items by key
      MODIFY zqm_t_inpr_ins_2 FROM TABLE @lt_item_upd.
    ENDIF.


  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
