CLASS lhc_ZQM_BA_LINSP_HDR DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS createlineinsplot FOR DETERMINE ON SAVE
      IMPORTING keys FOR zqm_ba_linsp_hdr~createlineinsplot.
    METHODS getpdf FOR MODIFY
      IMPORTING keys FOR ACTION zqm_ba_linsp_hdr~getpdf RESULT result.

ENDCLASS.

CLASS lhc_ZQM_BA_LINSP_HDR IMPLEMENTATION.

  METHOD createlineinsplot.

    " --- defensive checks ---
    IF keys IS INITIAL.
      RETURN.
    ENDIF.

*    TRY.
    " read header rows for keys (local read)
    READ ENTITIES OF zqm_ba_linsp_hdr IN LOCAL MODE
      ENTITY zqm_ba_linsp_hdr
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_header_ins).

    IF lt_header_ins IS INITIAL.
      RETURN.
    ENDIF.

    DATA(ls_header) = VALUE #( lt_header_ins[ 1 ] OPTIONAL ).

    " create inspection lot in external service
    MODIFY ENTITIES OF I_InspectionLotTP_2 PRIVILEGED
      ENTITY InspectionLot
      CREATE FIELDS ( material plant inspectionlottype inspectionlotquantity )
      WITH VALUE #( (
                    %cid                  = 'CID_001'
                    material              = ls_header-Material
                    plant                 = ls_header-Plant
                    inspectionlottype     = '89'
                    inspectionlotquantity = 5
                    ) )
      MAPPED DATA(mapped_ilot)
      REPORTED DATA(reported_ilot)
      FAILED DATA(failed_ilot).

    DATA(lv_inslot) = VALUE #( mapped_ilot-inspectionlot[ 1 ]-InspectionLot OPTIONAL ).
*
    " Now update back the header
    MODIFY ENTITIES OF zqm_ba_linsp_hdr IN LOCAL MODE
      ENTITY zqm_ba_linsp_hdr
      UPDATE FIELDS ( Inspectionlot Material Plant Productionorder )
      WITH VALUE #( (
                    Cuuid                    = ls_header-Cuuid
                    Inspectionlot            = lv_inslot
                    Material                 = ls_header-Material
                    Plant                    = ls_header-Plant
                    Productionorder          = ls_header-Productionorder
                    %control-InspectionLot   = if_abap_behv=>mk-on
                    %control-Material        = if_abap_behv=>mk-on
                    %control-Plant           = if_abap_behv=>mk-on
                    %control-Productionorder = if_abap_behv=>mk-on
                    ) )
         FAILED DATA(faliled_h)
         REPORTED DATA(reported_h)
         MAPPED DATA(mapped_h).

  ENDMETHOD.

  METHOD getpdf.



****    data : lv_base64      TYPE string,
****       lv_token       TYPE string,
****           lv_message     TYPE string.
****data lfs_header type ZR_MACH_PL_HD.
****data lft_header type              table of ZR_MACH_PL_HD.
****
****
****data lfs_item type ZR_MACH_PL_IT
****.
****data lft_item type table of ZR_MACH_PL_IT
****.
****    READ ENTITIES OF ZR_MACH_PL_HD
****
****
****      IN LOCAL MODE
****
****
****      ENTITY zr_mach_pl_hd
****      ALL FIELDS WITH CORRESPONDING #( keys )
****      RESULT DATA(lit_header_data)
****
****
****
****
****
****      FAILED DATA(lit_failed).
****
****data(lfs_header_run) = value #(  lit_header_data[ 1 ]  ).
****
****select * from ZQM_MACH_PL_IT
****
****
****where cuuid = @lfs_header_run-Cuuid
****into TABLE @data(lft_item_db)
****.
****
****
****
****    MOVE-CORRESPONDING lit_header_data TO lft_header.
****    MOVE-CORRESPONDING lft_item_db TO lft_item.
****
****    zcl_btp_adobe_form=>get_ouath_token(
****      EXPORTING
****        im_oauth_url    = 'ADS_OAUTH_URL'
****        im_clientid     = 'ADS_CLIENTID'
****        im_clientsecret = 'ADS_CLIENTSECRET'
****      IMPORTING
****        ex_token        = lv_token
****        ex_message      = lv_message
****    ).
****
****    ZBP_QM_BA_LINSP_HDR1=>get_pdf_xml(
****      EXPORTING
*****       im_data    = lit_data
****        im_data_h  = lft_header
****        im_data_i  = lft_item
****      IMPORTING
****        ex_base_64 = lv_base64
****    ).
****
****
****    data lv_form_name type string.
****
****lv_form_name = 'ZMACHINE_PLAN/Machine_Plan_Template'.
********    CASE lfs_header-formtype.
********  WHEN 'Standard'.
********    lv_form_name = 'ZPDIR/Standard_Template'.
********    WHEN 'Boll Hoff'.
********    lv_form_name = 'ZPDIR/BollHoff_Template'.
********    WHEN 'Eastern'.
********    lv_form_name = 'ZPDIR/Eastern_Template'.
********    WHEN 'Fastnal Before'.
********    lv_form_name = 'ZPDIR/Fastnal_Template'.
********    WHEN 'JCB'.
********    lv_form_name = 'ZPDIR/JCB_Template'.
********    WHEN 'Spicer'.
********    lv_form_name = 'ZPDIR/Spicer_Template'.
********ENDCASE.
****
****
****
****
****    zcl_btp_adobe_form=>get_pdf_api(
****      EXPORTING
****        im_url           = 'ADS_URL'
****        im_url_path      = '/v1/adsRender/pdf?TraceLevel=2&templateSource=storageName'
****        im_clientid      = 'ADS_CLIENTID'
****        im_clientsecret  = 'ADS_CLIENTSECRET'
****        im_token         = lv_token
****        im_base64_encode = lv_base64
****        im_xdp_template  = lv_form_name
****      IMPORTING
****        ex_base64_decode = DATA(lv_base64_decode)
****        ex_message       = lv_message
****    ).
****
****
****
****
****    MODIFY ENTITIES OF ZR_MACH_PL_HD
****
**** IN LOCAL MODE
****      ENTITY zr_mach_pl_hd
****      UPDATE FIELDS (  attachments filename mimetype  )
****      WITH VALUE #( FOR lwa_header IN lit_header_data ( %tky        = lwa_header-%tky
****                                                        Attachments = lv_base64_decode
****                                                        filename    = 'Form'
****                                                        mimetype    = 'application/pdf'
****                    ) )
****    FAILED failed
****    REPORTED reported.
****
****    READ ENTITIES OF  ZR_MACH_PL_HD
****
**** IN LOCAL MODE
****
****          ENTITY zr_mach_pl_hd
****
****          ALL FIELDS WITH CORRESPONDING #( keys )
****          RESULT DATA(lit_updatedheader).
****
****    " set the action result parameter
****    result = VALUE #( FOR lwa_updatedheader IN lit_updatedheader ( %tky   = lwa_updatedheader-%tky
****                                                                   %param = lwa_updatedheader ) ).
  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZQM_BA_LINSP_SPC DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS resulttxt FOR DETERMINE ON SAVE
      IMPORTING keys FOR zqm_ba_linsp_spc~resulttxt.

ENDCLASS.

CLASS lhc_ZQM_BA_LINSP_SPC IMPLEMENTATION.

  METHOD resulttxt.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZQM_BA_LINSP_RES DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR zqm_ba_linsp_res RESULT result.
    METHODS update_features FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zqm_ba_linsp_res~update_features.

ENDCLASS.

CLASS lhc_ZQM_BA_LINSP_RES IMPLEMENTATION.

  METHOD get_instance_features.

    READ ENTITY IN LOCAL MODE zqm_ba_linsp_res
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_res).

    result = VALUE #(
      FOR row IN lt_res (
        %tky = row-%tky

        " Dynamically enable or disable all 12 result fields based on RecordingDateTime
        %features-%field-Result1  = COND #( WHEN row-RecordingDateTime IS INITIAL THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
        %features-%field-Result2  = COND #( WHEN row-RecordingDateTime IS INITIAL THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
        %features-%field-Result3  = COND #( WHEN row-RecordingDateTime IS INITIAL THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
        %features-%field-Result4  = COND #( WHEN row-RecordingDateTime IS INITIAL THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
        %features-%field-Result5  = COND #( WHEN row-RecordingDateTime IS INITIAL THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
        %features-%field-Result6  = COND #( WHEN row-RecordingDateTime IS INITIAL THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
        %features-%field-Result7  = COND #( WHEN row-RecordingDateTime IS INITIAL THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
        %features-%field-Result8  = COND #( WHEN row-RecordingDateTime IS INITIAL THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
        %features-%field-Result9  = COND #( WHEN row-RecordingDateTime IS INITIAL THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
        %features-%field-Result10 = COND #( WHEN row-RecordingDateTime IS INITIAL THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
        %features-%field-Result11 = COND #( WHEN row-RecordingDateTime IS INITIAL THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
        %features-%field-Result12 = COND #( WHEN row-RecordingDateTime IS INITIAL THEN if_abap_behv=>fc-f-read_only ELSE if_abap_behv=>fc-f-unrestricted )
      )
    ).


  ENDMETHOD.

  METHOD update_features.

  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZQM_BA_LINSP_HDR DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZQM_BA_LINSP_HDR IMPLEMENTATION.

  METHOD save_modified.

  data lfs_zqm_t_linsp_res type zqm_t_linsp_res.
  data lft_zqm_t_linsp_res type table of zqm_t_linsp_res.

    if update-zqm_ba_linsp_spc is not INITIAL.


        loop at update-zqm_ba_linsp_spc into data(lfs_spc).


        SELECT SINGLE * FROM zqm_t_linsp_spc  WHERE  cuuid = @lfs_spc-Cuuid AND
           cuuiddate  = @lfs_spc-cuuiddate AND
        boooperationinternalid = @lfs_spc-BOOOperationInternalID AND
        inspectionlotitem = @lfs_spc-InspectionLotItem AND
        inspectionlot = @lfs_spc-Inspectionlot AND
        boocharacteristicversion = @lfs_spc-BOOCharacteristicVersion AND
        inspectionplangroup  = @lfs_spc-InspectionPlanGroup

        INTO @DATA(lfs_db_data).



        TRANSLATE lfs_spc-spc TO UPPER CASE.
        TRANSLATE lfs_db_data-SPC TO UPPER CASE.
        if lfs_spc-spc = 'SPC' AND lfs_db_data-SPC <> 'SPC'.
        DO 5 TIMES.
            DATA(lv_cuuid) = cl_system_uuid=>create_uuid_x16_static( ).

            lfs_zqm_t_linsp_res-cuuid = lfs_spc-Cuuid.
            lfs_zqm_t_linsp_res-Cuuiddate = lfs_spc-cuuiddate.
            lfs_zqm_t_linsp_res-Cuuidresult = lv_cuuid.
            lfs_zqm_t_linsp_res-Boooperationinternalid = lfs_spc-BOOOperationInternalID.
            lfs_zqm_t_linsp_res-Inspectionlotitem = lfs_spc-InspectionLotItem.
            lfs_zqm_t_linsp_res-Inspectionlot = lfs_spc-Inspectionlot.
            lfs_zqm_t_linsp_res-Boocharacteristicversion = lfs_spc-BOOCharacteristicVersion.
            lfs_zqm_t_linsp_res-Inspectionplangroup = lfs_spc-InspectionPlanGroup.

            append lfs_zqm_t_linsp_res to lft_zqm_t_linsp_res.
            ENDDO.
          endif.

          IF lfs_db_data is INITIAL.
            MOVE-CORRESPONDING lfs_spc TO lfs_db_data.
        ENDIF.



            if lfs_spc-%control-result1 = '01'.
        lfs_db_data-result1 = lfs_spc-result1.
    endif.

    if lfs_spc-%control-result2 = '01'.
        lfs_db_data-result2 = lfs_spc-result2.
    endif.

    if lfs_spc-%control-result3 = '01'.
        lfs_db_data-result3 = lfs_spc-result3.
    endif.

    if lfs_spc-%control-result4 = '01'.
        lfs_db_data-result4 = lfs_spc-result4.
    endif.

    if lfs_spc-%control-result5 = '01'.
        lfs_db_data-result5 = lfs_spc-result5.
    endif.

    if lfs_spc-%control-result6 = '01'.
        lfs_db_data-result6 = lfs_spc-result6.
    endif.

     if lfs_spc-%control-result7 = '01'.
        lfs_db_data-result7 = lfs_spc-result7.
    endif.

     if lfs_spc-%control-result8 = '01'.
        lfs_db_data-result8 = lfs_spc-result8.
    endif.

     if lfs_spc-%control-result9 = '01'.
        lfs_db_data-result9 = lfs_spc-result9.
    endif.

     if lfs_spc-%control-result10 = '01'.
        lfs_db_data-result10 = lfs_spc-result10.
    endif.

     if lfs_spc-%control-result11 = '01'.
        lfs_db_data-result11 = lfs_spc-result11.
    endif.

     if lfs_spc-%control-result12 = '01'.
        lfs_db_data-result12 = lfs_spc-result12.
    endif.

     if lfs_spc-%control-spc = '01'.
        lfs_db_data-spc = lfs_spc-spc.
    endif.





*****    lt_item_upd_opr = CORRESPONDING #( update-zqm_pdir_opertion_list ).
      " Update items by key
      MODIFY zqm_t_linsp_spc
 FROM  @lfs_db_data.

      .

         clear:lfs_spc,lfs_zqm_t_linsp_res.


        ENDLOOP.

        modify zqm_t_linsp_res from table @lft_zqm_t_linsp_res.


    endif.










  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
