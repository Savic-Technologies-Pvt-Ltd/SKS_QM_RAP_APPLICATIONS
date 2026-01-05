CLASS lhc_zr_downtime_re DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS updateRemarks FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZR_DOWNTIME_RE~updateRemarks.
    METHODS checkProductionTime FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZR_DOWNTIME_RE~checkProductionTime.

ENDCLASS.

CLASS lhc_zr_downtime_re IMPLEMENTATION.

  METHOD updateRemarks.

****      data(lfs_key) = value #( keys[ 1 ] optional ).
****        select single VALUE from ZC_REMARKS_DOWNTIME
****    where KEYVALUE = @lfs_key-Remarks
****    into @data(lv_RemarksDesc).
****
****MODIFY ENTITIES OF ZR_DOWNTIME_HD IN LOCAL MODE
****    ENTITY zr_downtime_re
****    UPDATE
****    FIELDS (
****
****    Remarksdesc ) WITH VALUE #( (  %tky =  lfs_key-%tky
****                                 %is_draft = lfs_key-%is_draft
****                                 Remarksdesc             = lv_RemarksDesc
****     ) )
****    REPORTED DATA(LFT_REPORTED).
  ENDMETHOD.

  METHOD checkProductionTime.



    if keys is not INITIAL.

    data(ls_pr) = value #( keys[ 1 ] ).

    data lv_tot_downtime type int4.
    lv_tot_downtime = 0.
       select * from ZQM_DOWNTIME_RE

         where cuuid = @ls_pr-Cuuid and workcenter = @ls_pr-Workcenter
         into TABLE @data(lft_db_data).



         loop at lft_db_data into data(lfs_db_data).
            lv_tot_downtime = lv_tot_downtime + ( lfs_db_data-endtime - lfs_db_data-starttime ).
            clear:lfs_db_data.
         ENDLOOP.

         if lft_db_data is INITIAL.

            select * from ZQM_DOWNTME_RE_D


         where cuuid = @ls_pr-Cuuid and workcenter = @ls_pr-Workcenter
         into TABLE @data(lft_db_data_draft).

           loop at lft_db_data_draft into data(lfs_db_data_draft).
            lv_tot_downtime = lv_tot_downtime + ( lfs_db_data_draft-endtime - lfs_db_data_draft-starttime ).
            clear:lfs_db_data.
         ENDLOOP.

          endif.



          select single * from ZQM_DOWNTIME_IT  where cuuid = @ls_pr-Cuuid and workcenter = @ls_pr-Workcenter
           into @data(lfs_ZQM_DOWNTIME_IT).

           if lv_tot_downtime <> 0.
            lv_tot_downtime = lv_tot_downtime / 60.
           endif.
          if lv_tot_downtime > 675.
           APPEND VALUE #(
          %tky = ls_pr-%tky
        ) TO failed-zr_downtime_re.
       APPEND VALUE #(    %tky        = value #( keys[ 1 ]-%tky OPTIONAL  )
        %msg        = new_message(
                        id       = 'Z001'
                        number   = '001'
                        severity = if_abap_behv_message=>severity-error
                        v1       = 'Total Downtime -' && lv_tot_downtime && 'should not exceed Production Time -675'

                      )

      ) TO reported-zr_downtime_re .
          endif.

    endif.


  ENDMETHOD.

ENDCLASS.

CLASS lhc_zr_downtime_it DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS updateWorkcenterName FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZR_DOWNTIME_IT~updateWorkcenterName.
    METHODS updateshifttime FOR DETERMINE ON MODIFY
      IMPORTING keys FOR ZR_DOWNTIME_IT~updateshifttime.
    METHODS checkProductionOrder FOR VALIDATE ON SAVE
      IMPORTING keys FOR ZR_DOWNTIME_IT~checkProductionOrder.

ENDCLASS.

CLASS lhc_zr_downtime_it IMPLEMENTATION.

  METHOD updateWorkcenterName.

    data(lfs_key) = value #( keys[ 1 ] optional ).

    select single WorkCenterText from I_WorkCenterText
    where WorkCenterInternalID = @lfs_key-Workcenter
    into @data(lv_WorkCenterText).

MODIFY ENTITIES OF ZR_DOWNTIME_HD IN LOCAL MODE
    ENTITY zr_downtime_it
    UPDATE
    FIELDS (

    Workcentername ) WITH VALUE #( (  %tky =  lfs_key-%tky
                                 %is_draft = lfs_key-%is_draft
                                 Workcentername             = lv_WorkCenterText
     ) )
    REPORTED DATA(LFT_REPORTED).
  ENDMETHOD.

  METHOD updateshifttime.

data lv_starttime type sy-uzeit.
data lv_endtime type sy-uzeit.

     READ ENTITIES OF ZR_DOWNTIME_HD

 IN LOCAL MODE
     ENTITY zr_downtime_it
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_mat_data).

    IF lt_mat_data IS NOT INITIAL.

    data(lfs_key) = value #( keys[ 1 ] OPTIONAL ).

      DATA(ls_mat_data) = VALUE #( lt_mat_data[ 1 ] OPTIONAL ).
if ls_mat_data-shift = 'Shift-1'.
    lv_starttime = '070000'.
    lv_endtime = '190000'.
endif.

if ls_mat_data-shift = 'Shift-2'.
    lv_starttime = '190000'.
    lv_endtime = '070000'.
endif.


MODIFY ENTITIES OF ZR_DOWNTIME_HD IN LOCAL MODE
    ENTITY zr_downtime_it
    UPDATE
    FIELDS (

    shiftstarttime
    shiftendtime
    totalprodmin
     ) WITH VALUE #( (  %tky =  lfs_key-%tky

                                 %is_draft = lfs_key-%is_draft
                                   shiftstarttime = lv_starttime
    shiftendtime = lv_endtime
    totalprodmin = '675'
     ) )
    REPORTED DATA(LFT_REPORTED).

endif.

  ENDMETHOD.

  METHOD checkProductionOrder.


  READ ENTITIES OF ZR_DOWNTIME_HD
 IN LOCAL MODE
    ENTITY zr_downtime_it
    FIELDS ( productionorder )
    WITH CORRESPONDING #( keys )
    RESULT DATA(lt_pr).

    if lt_pr is not INITIAL.

    data(ls_pr) = value #( lt_pr[ 1 ] ).
    select * from ZQM_DOWNTIME_IT
     where cuuid = @ls_pr-Cuuid
     into TABLE @data(lft_db_data).

     if lft_db_data is INITIAL.

        select * from ZQM_DOWNTME_IT_D

     where cuuid = @ls_pr-Cuuid
     into TABLE @data(lft_db_data_draft).

      endif.

*  LOOP AT lt_pr INTO DATA(ls_pr).


loop at lft_db_data into data(lfs_db_data).
    if lfs_db_data-productionorder = ls_pr-productionorder  and  lfs_db_data-Workcenter <> ls_pr-Workcenter.

    APPEND VALUE #(
          %tky = ls_pr-%tky
        ) TO failed-zr_downtime_it.
       APPEND VALUE #(    %tky        = value #( lt_pr[ 1 ]-%tky OPTIONAL  )
        %msg        = new_message(
                        id       = 'Z001'
                        number   = '001'
                        severity = if_abap_behv_message=>severity-error
                        v1       = 'Production Order should be unique'
                      )
        %element-productionorder = if_abap_behv=>mk-on
      ) TO reported-zr_downtime_it .
    endif.

ENDLOOP.

loop at lft_db_data_draft into data(lfs_db_data_draft).
    if lfs_db_data_draft-productionorder = ls_pr-productionorder and  lfs_db_data_draft-Workcenter <> ls_pr-Workcenter.

    APPEND VALUE #(
          %tky = ls_pr-%tky
        ) TO failed-zr_downtime_it.
       APPEND VALUE #(    %tky        = value #( lt_pr[ 1 ]-%tky OPTIONAL  )
        %msg        = new_message(
                        id       = 'Z001'
                        number   = '001'
                        severity = if_abap_behv_message=>severity-error
                        v1       = 'Production Order should be unique'
                      )
        %element-productionorder = if_abap_behv=>mk-on
      ) TO reported-zr_downtime_it .
    endif.

ENDLOOP.

endif.
*     ENDLOOP.

  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZR_DOWNTIME_HD DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zr_downtime_hd RESULT result.


    METHODS getpdf FOR MODIFY
      IMPORTING keys FOR ACTION zr_downtime_hd~getpdf RESULT result.

    METHODS createDowntime FOR DETERMINE ON SAVE
      IMPORTING keys FOR zr_downtime_hd~createDowntime.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR ZR_DOWNTIME_HD RESULT result.

ENDCLASS.

CLASS lhc_ZR_DOWNTIME_HD IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.


  METHOD getpdf.


    data : lv_base64      TYPE string,
       lv_token       TYPE string,
           lv_message     TYPE string.
data lfs_header type ZR_DOWNTIME_HD.
data lft_header type              table of ZR_DOWNTIME_HD.


data lfs_item type ZR_DOWNTIME_IT.
data lft_item type table of ZR_DOWNTIME_IT.

data lfs_remarks type ZR_DOWNTIME_RE.
data lft_remarks type table of ZR_DOWNTIME_RE.
    READ ENTITIES OF ZR_DOWNTIME_HD

      IN LOCAL MODE
      ENTITY zr_downtime_hd
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lit_header_data)

    ENTITY zr_downtime_it
     ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lit_item_data)

    ENTITY zr_downtime_re
     ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lit_remarks_data)


      FAILED DATA(lit_failed).

data(lfs_header_run) = value #(  lit_header_data[ 1 ]  ).

select * from ZQM_DOWNTIME_IT



where cuuid = @lfs_header_run-Cuuid
into TABLE @data(lft_item_db)
.

select * from ZQM_DOWNTIME_RE




where cuuid = @lfs_header_run-Cuuid
into TABLE @data(lft_remark_db)
.

    MOVE-CORRESPONDING lit_header_data TO lft_header.
    MOVE-CORRESPONDING lft_item_db TO lft_item.
    MOVE-CORRESPONDING lft_remark_db TO lft_remarks.

    zcl_btp_adobe_form=>get_ouath_token(
      EXPORTING
        im_oauth_url    = 'ADS_OAUTH_URL'
        im_clientid     = 'ADS_CLIENTID'
        im_clientsecret = 'ADS_CLIENTSECRET'
      IMPORTING
        ex_token        = lv_token
        ex_message      = lv_message
    ).

    zbp_r_downtime_hd=>get_pdf_xml(
      EXPORTING
*       im_data    = lit_data
        im_data_h  = lft_header
        im_data_i  = lft_item
        ltt_data_i_i =  lft_remarks
      IMPORTING
        ex_base_64 = lv_base64
    ).


    data lv_form_name type string.

lv_form_name = 'ZDOWN_TIME/DownTime_Daily_Template'.
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




    MODIFY ENTITIES OF ZR_DOWNTIME_HD


 IN LOCAL MODE
      ENTITY zr_downtime_hd
      UPDATE FIELDS (  attachments filename mimetype  )
      WITH VALUE #( FOR lwa_header IN lit_header_data ( %tky        = lwa_header-%tky
                                                        Attachments = lv_base64_decode
                                                        filename    = 'Form'
                                                        mimetype    = 'application/pdf'
                    ) )
    FAILED failed
    REPORTED reported.

    READ ENTITIES OF  ZR_DOWNTIME_HD


 IN LOCAL MODE

          ENTITY zr_downtime_hd

          ALL FIELDS WITH CORRESPONDING #( keys )
          RESULT DATA(lit_updatedheader).

    " set the action result parameter
    result = VALUE #( FOR lwa_updatedheader IN lit_updatedheader ( %tky   = lwa_updatedheader-%tky
                                                                   %param = lwa_updatedheader ) ).
  ENDMETHOD.

  METHOD createDowntime.

     READ ENTITIES OF ZR_DOWNTIME_HD

 IN LOCAL MODE
     ENTITY zr_downtime_hd
     ALL FIELDS WITH CORRESPONDING #( keys )
     RESULT DATA(lt_mat_data).

    IF lt_mat_data IS NOT INITIAL.

      DATA(ls_mat_data) = VALUE #( lt_mat_data[ 1 ] OPTIONAL ).



       DATA: nr_number     TYPE cl_numberrange_runtime=>nr_number.

        DATA: lv_object    TYPE CHAR10.
DATA LV_SETUP(20) TYPE C.



SELECT MAX( Downtimeno  ) FROM ZQM_DOWNTIME_HD


 INTO @DATA(LV_SETUP_OLD).
LV_SETUP = LV_SETUP_OLD + 1.
SHIFT LV_SETUP LEFT DELETING LEADING SPACE.
        MODIFY ENTITIES OF ZR_DOWNTIME_HD


 IN LOCAL MODE
      ENTITY zr_downtime_hd
      UPDATE FIELDS ( Downtimeno

                       )
      WITH VALUE #( "FOR key IN keys
                    (
  %is_draft              = ls_mat_data-%is_draft
                      Cuuid                  = VALUE #( keys[ 1 ]-Cuuid OPTIONAL )
                      Downtimeno          = LV_SETUP          ""mapped1-inspectionlot

 %control-Downtimeno = if_abap_behv=>mk-on



                    ) )

               FAILED DATA(lt_fail)
               REPORTED DATA(lt_reported)
               MAPPED DATA(lt_mapped).

               endif.
  ENDMETHOD.

  METHOD get_instance_features.

  READ ENTITY IN LOCAL MODE ZR_DOWNTIME_HD

    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lt_spec).

  result = VALUE #( FOR row IN lt_spec
                    ( %tky = row-%tky

                      %features-%field-Downtimeno =  if_abap_behv=>fc-f-read_only
                                            %features-%field-Plant =  if_abap_behv=>fc-f-read_only

                                ) ).


  ENDMETHOD.

ENDCLASS.
