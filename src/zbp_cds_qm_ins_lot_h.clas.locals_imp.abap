CLASS lhc_item DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Item RESULT result.
    METHODS field_readonly FOR DETERMINE ON MODIFY
      IMPORTING keys FOR item~field_readonly.

ENDCLASS.

CLASS lhc_item IMPLEMENTATION.

  METHOD get_instance_features.
    READ ENTITIES OF zcds_qm_ins_lot_h IN LOCAL MODE
    ENTITY Header
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lit_mat_data).

    READ ENTITY IN LOCAL MODE zcds_qm_ins_lot_i
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lit_item) .
    DATA(lwa_mat_data) = VALUE #( lit_mat_data[ 1 ] OPTIONAL  ).

    result = VALUE #( FOR row IN lit_item ( %tky = row-%tky
          %features-%field-Resval6 = COND #( WHEN ( lwa_mat_data-ar6 = 'ACC.' OR lwa_mat_data-ar6 = ' ' ) AND row-Resval6 IS INITIAL
                                                   AND row-res_mark6 IS INITIAL AND row-res_mark6_ind IS INITIAL
                                                   THEN if_abap_behv=>fc-f-read_only
                                              WHEN row-Resval6 IS NOT INITIAL AND row-res_mark6 IS INITIAL AND row-res_mark6_ind IS INITIAL
                                                   THEN if_abap_behv=>fc-f-read_only
                                              WHEN  row-Resval6 IS NOT INITIAL AND row-res_mark6 IS NOT INITIAL AND row-res_mark6_ind = 'X'
                                                   THEN if_abap_behv=>fc-f-unrestricted
                                              WHEN  row-Resval6 IS NOT INITIAL AND row-res_mark6 IS NOT INITIAL AND row-res_mark6_ind = 'Y'
                                                   THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted )
          %features-%field-Resval7 = COND #( WHEN ( lwa_mat_data-ar7 = 'ACC.' OR lwa_mat_data-ar7 = ' ' ) AND row-Resval7 IS INITIAL
                                                   AND row-res_mark7 IS INITIAL AND row-res_mark7_ind IS INITIAL
                                                   THEN if_abap_behv=>fc-f-read_only
                                              WHEN row-Resval7 IS NOT INITIAL AND row-res_mark7 IS INITIAL AND row-res_mark7_ind IS INITIAL
                                                   THEN if_abap_behv=>fc-f-read_only
                                              WHEN  row-Resval7 IS NOT INITIAL AND row-res_mark7 IS NOT INITIAL AND row-res_mark7_ind = 'X'
                                                   THEN if_abap_behv=>fc-f-unrestricted
                                              WHEN  row-Resval7 IS NOT INITIAL AND row-res_mark7 IS NOT INITIAL AND row-res_mark7_ind = 'Y'
                                                   THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted )
          %features-%field-Resval8 = COND #( WHEN ( lwa_mat_data-ar8 = 'ACC.' OR lwa_mat_data-ar8 = ' ' ) AND row-Resval8 IS INITIAL
                                                   AND row-res_mark8 IS INITIAL AND row-res_mark8_ind IS INITIAL
                                                   THEN if_abap_behv=>fc-f-read_only
                                              WHEN row-Resval8 IS NOT INITIAL AND row-res_mark8 IS INITIAL AND row-res_mark8_ind IS INITIAL
                                                   THEN if_abap_behv=>fc-f-read_only
                                              WHEN  row-Resval8 IS NOT INITIAL AND row-res_mark8 IS NOT INITIAL AND row-res_mark8_ind = 'X'
                                                   THEN if_abap_behv=>fc-f-unrestricted
                                              WHEN  row-Resval8 IS NOT INITIAL AND row-res_mark8 IS NOT INITIAL AND row-res_mark8_ind = 'Y'
                                                   THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted )
          %features-%field-Resval9 = COND #( WHEN ( lwa_mat_data-ar9 = 'ACC.' OR lwa_mat_data-ar9 = ' ' ) AND row-Resval9 IS INITIAL
                                                   AND row-res_mark9 IS INITIAL AND row-res_mark9_ind IS INITIAL
                                                   THEN if_abap_behv=>fc-f-read_only
                                              WHEN row-Resval9 IS NOT INITIAL AND row-res_mark9 IS INITIAL AND row-res_mark9_ind IS INITIAL
                                                   THEN if_abap_behv=>fc-f-read_only
                                              WHEN  row-Resval9 IS NOT INITIAL AND row-res_mark9 IS NOT INITIAL AND row-res_mark9_ind = 'X'
                                                   THEN if_abap_behv=>fc-f-unrestricted
                                              WHEN  row-Resval9 IS NOT INITIAL AND row-res_mark9 IS NOT INITIAL AND row-res_mark9_ind = 'Y'
                                                   THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted )
          %features-%field-Resval10 = COND #( WHEN ( lwa_mat_data-ar10 = 'ACC.' OR lwa_mat_data-ar10 = ' ' ) AND row-Resval10 IS INITIAL
                                                   AND row-res_mark10 IS INITIAL AND row-res_mark10_ind IS INITIAL
                                                   THEN if_abap_behv=>fc-f-read_only
                                              WHEN row-Resval10 IS NOT INITIAL AND row-res_mark10 IS INITIAL AND row-res_mark10_ind IS INITIAL
                                                   THEN if_abap_behv=>fc-f-read_only
                                              WHEN  row-Resval10 IS NOT INITIAL AND row-res_mark10 IS NOT INITIAL AND row-res_mark10_ind = 'X'
                                                   THEN if_abap_behv=>fc-f-unrestricted
                                              WHEN  row-Resval10 IS NOT INITIAL AND row-res_mark10 IS NOT INITIAL AND row-res_mark10_ind = 'Y'
                                                   THEN if_abap_behv=>fc-f-read_only
                                                   ELSE if_abap_behv=>fc-f-unrestricted )

           %features-%field-res_mark1 = COND #( WHEN row-res_mark1 IS NOT INITIAL
                                                             THEN if_abap_behv=>fc-f-read_only
                                                        ELSE if_abap_behv=>fc-f-unrestricted )
           %features-%field-res_mark2 = COND #( WHEN row-res_mark2 IS NOT INITIAL
                                                             THEN if_abap_behv=>fc-f-read_only
                                                        ELSE if_abap_behv=>fc-f-unrestricted )
           %features-%field-res_mark3 = COND #( WHEN row-res_mark3 IS NOT INITIAL
                                                             THEN if_abap_behv=>fc-f-read_only
                                                        ELSE if_abap_behv=>fc-f-unrestricted )
           %features-%field-res_mark4 = COND #( WHEN row-res_mark4 IS NOT INITIAL
                                                             THEN if_abap_behv=>fc-f-read_only
                                                        ELSE if_abap_behv=>fc-f-unrestricted )
           %features-%field-res_mark5 = COND #( WHEN row-res_mark5 IS NOT INITIAL
                                                             THEN if_abap_behv=>fc-f-read_only
                                                        ELSE if_abap_behv=>fc-f-unrestricted )
           %features-%field-res_mark6 = COND #( WHEN row-res_mark6 IS NOT INITIAL
                                                             THEN if_abap_behv=>fc-f-read_only
                                                        ELSE if_abap_behv=>fc-f-unrestricted )
           %features-%field-res_mark7 = COND #( WHEN row-res_mark6 IS NOT INITIAL
                                                             THEN if_abap_behv=>fc-f-read_only
                                                        ELSE if_abap_behv=>fc-f-unrestricted )
           %features-%field-res_mark8 = COND #( WHEN row-res_mark6 IS NOT INITIAL
                                                             THEN if_abap_behv=>fc-f-read_only
                                                        ELSE if_abap_behv=>fc-f-unrestricted )
           %features-%field-res_mark9 = COND #( WHEN row-res_mark6 IS NOT INITIAL
                                                             THEN if_abap_behv=>fc-f-read_only
                                                        ELSE if_abap_behv=>fc-f-unrestricted )
           %features-%field-res_mark10 = COND #( WHEN row-res_mark6 IS NOT INITIAL
                                                             THEN if_abap_behv=>fc-f-read_only
                                                        ELSE if_abap_behv=>fc-f-unrestricted )
                     %features-%field-res_mark11 = COND #( WHEN row-Resval11 IS INITIAL
                                                             THEN if_abap_behv=>fc-f-read_only
                                                        ELSE if_abap_behv=>fc-f-unrestricted )

           %features-%field-Resval1 = COND #( WHEN row-Resval1 IS NOT INITIAL AND row-res_mark1 IS INITIAL AND row-res_mark1_ind IS INITIAL
                                                    THEN if_abap_behv=>fc-f-read_only
                                              WHEN  row-Resval1 IS NOT INITIAL AND row-res_mark1 IS NOT INITIAL AND row-res_mark1_ind = 'X'
                                                    THEN if_abap_behv=>fc-f-unrestricted
                                              WHEN  row-Resval1 IS NOT INITIAL AND row-res_mark1 IS NOT INITIAL AND row-res_mark1_ind = 'Y'
                                                   THEN if_abap_behv=>fc-f-read_only
                                              ELSE if_abap_behv=>fc-f-unrestricted )
           %features-%field-Resval2 = COND #( WHEN row-Resval2 IS NOT INITIAL AND row-res_mark2 IS INITIAL AND row-res_mark2_ind IS INITIAL
                                                    THEN if_abap_behv=>fc-f-read_only
                                              WHEN  row-Resval2 IS NOT INITIAL AND row-res_mark2 IS NOT INITIAL AND row-res_mark2_ind = 'X'
                                                    THEN if_abap_behv=>fc-f-unrestricted
                                              WHEN  row-Resval2 IS NOT INITIAL AND row-res_mark2 IS NOT INITIAL AND row-res_mark2_ind = 'Y'
                                                   THEN if_abap_behv=>fc-f-read_only
                                              ELSE if_abap_behv=>fc-f-unrestricted )
           %features-%field-Resval3 = COND #( WHEN row-Resval3 IS NOT INITIAL AND row-res_mark3 IS INITIAL AND row-res_mark3_ind IS INITIAL
                                                    THEN if_abap_behv=>fc-f-read_only
                                              WHEN  row-Resval3 IS NOT INITIAL AND row-res_mark3 IS NOT INITIAL AND row-res_mark3_ind = 'X'
                                                    THEN if_abap_behv=>fc-f-unrestricted
                                              WHEN  row-Resval3 IS NOT INITIAL AND row-res_mark3 IS NOT INITIAL AND row-res_mark3_ind = 'Y'
                                                   THEN if_abap_behv=>fc-f-read_only
                                              ELSE if_abap_behv=>fc-f-unrestricted )
           %features-%field-Resval4 = COND #( WHEN row-Resval4 IS NOT INITIAL AND row-res_mark4 IS INITIAL AND row-res_mark4_ind IS INITIAL
                                                    THEN if_abap_behv=>fc-f-read_only
                                              WHEN  row-Resval4 IS NOT INITIAL AND row-res_mark4 IS NOT INITIAL AND row-res_mark4_ind = 'X'
                                                    THEN if_abap_behv=>fc-f-unrestricted
                                              WHEN  row-Resval4 IS NOT INITIAL AND row-res_mark4 IS NOT INITIAL AND row-res_mark4_ind = 'Y'
                                                   THEN if_abap_behv=>fc-f-read_only
                                              ELSE if_abap_behv=>fc-f-unrestricted )
           %features-%field-Resval5 = COND #( WHEN row-Resval5 IS NOT INITIAL AND row-res_mark5 IS INITIAL AND row-res_mark5_ind IS INITIAL
                                                    THEN if_abap_behv=>fc-f-read_only
                                              WHEN  row-Resval5 IS NOT INITIAL AND row-res_mark5 IS NOT INITIAL AND row-res_mark5_ind = 'X'
                                                    THEN if_abap_behv=>fc-f-unrestricted
                                              WHEN  row-res_mark1 IS NOT INITIAL AND row-res_mark5 IS NOT INITIAL AND row-res_mark5_ind = 'Y'
                                                   THEN if_abap_behv=>fc-f-read_only
                                              ELSE if_abap_behv=>fc-f-unrestricted )

                                                        ) ).





  ENDMETHOD.

  METHOD field_readonly.

    READ ENTITY IN LOCAL MODE zcds_qm_ins_lot_i
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lit_item) .
    DATA(lwa_mat_data) = VALUE #( lit_item[ 1 ] OPTIONAL  ).

    DATA : ind TYPE c.

    ind = lwa_mat_data-res_mark1_ind.
    DATA(ind1) = lwa_mat_data-res_mark2_ind.
    DATA(ind2) = lwa_mat_data-res_mark3_ind.
    DATA(ind3) = lwa_mat_data-res_mark4_ind.
    DATA(ind4) = lwa_mat_data-res_mark5_ind.
    DATA(ind5) = lwa_mat_data-res_mark6_ind.
    DATA(ind6) = lwa_mat_data-res_mark7_ind.
    DATA(ind7) = lwa_mat_data-res_mark8_ind.
    DATA(ind8) = lwa_mat_data-res_mark9_ind.
    DATA(ind9) = lwa_mat_data-res_mark10_ind.
    IF lwa_mat_data-res_mark1_ind IS INITIAL AND lwa_mat_data-res_mark1 IS NOT INITIAL.
      ind = 'X'.
    ELSEIF  ( lwa_mat_data-res_mark1_ind = 'X' AND lwa_mat_data-res_mark1  IS NOT INITIAL ) .
      ind = 'Y'.
    ENDIF.
    IF lwa_mat_data-res_mark2_ind IS INITIAL AND lwa_mat_data-res_mark2 IS NOT INITIAL.
      ind1 = 'X'.
    ELSEIF ( lwa_mat_data-res_mark2_ind = 'X' AND lwa_mat_data-res_mark2  IS NOT INITIAL ) .
      ind1 = 'Y'.
    ENDIF.
    IF lwa_mat_data-res_mark3_ind IS INITIAL AND lwa_mat_data-res_mark3 IS NOT INITIAL.
      ind2 = 'X'.
    ELSEIF ( lwa_mat_data-res_mark3_ind = 'X' AND lwa_mat_data-res_mark3  IS NOT INITIAL ).
      ind2 = 'Y'.

    ENDIF.
    IF lwa_mat_data-res_mark4_ind IS INITIAL AND lwa_mat_data-res_mark4 IS NOT INITIAL.
      ind3 = 'X'.
    ELSEIF ( lwa_mat_data-res_mark4_ind = 'X' AND lwa_mat_data-res_mark4 IS NOT INITIAL ) .
      ind3 = 'Y'.
    ENDIF.
    IF lwa_mat_data-res_mark5_ind IS INITIAL AND lwa_mat_data-res_mark5 IS NOT INITIAL.
      ind4 = 'X'.
    ELSEIF ( lwa_mat_data-res_mark5_ind = 'X' AND lwa_mat_data-res_mark5  IS NOT INITIAL ).
      ind4 = 'Y'.
    ENDIF.
    IF lwa_mat_data-res_mark6_ind IS INITIAL AND lwa_mat_data-res_mark6 IS NOT INITIAL.
      ind5 = 'X'.
    ELSEIF ( lwa_mat_data-res_mark6_ind = 'X' AND lwa_mat_data-res_mark6  IS NOT INITIAL ).
      ind5 = 'Y'.
    ENDIF.
    IF lwa_mat_data-res_mark7_ind IS INITIAL AND lwa_mat_data-res_mark7 IS NOT INITIAL.
      ind6 = 'X'.
    ELSEIF ( lwa_mat_data-res_mark7_ind = 'X' AND lwa_mat_data-res_mark7  IS NOT INITIAL ).
      ind6 = 'Y'.
    ENDIF.
    IF lwa_mat_data-res_mark8_ind IS INITIAL AND lwa_mat_data-res_mark8 IS NOT INITIAL.
      ind7 = 'X'.
    ELSEIF ( lwa_mat_data-res_mark8_ind = 'X' AND lwa_mat_data-res_mark8  IS NOT INITIAL ).
      ind7 = 'Y'.
    ENDIF.
    IF lwa_mat_data-res_mark9_ind IS INITIAL AND lwa_mat_data-res_mark9 IS NOT INITIAL.
      ind8 = 'X'.
    ELSEIF ( lwa_mat_data-res_mark9_ind = 'X' AND lwa_mat_data-res_mark9  IS NOT INITIAL ).
      ind8 = 'Y'.
    ENDIF.
    IF lwa_mat_data-res_mark10_ind IS INITIAL AND lwa_mat_data-res_mark10 IS NOT INITIAL.
      ind9 = 'X'.
    ELSEIF ( lwa_mat_data-res_mark10_ind = 'X' AND lwa_mat_data-res_mark10  IS NOT INITIAL ).
      ind9 = 'Y'.
    ENDIF.


    MODIFY ENTITIES OF zcds_qm_ins_lot_h IN LOCAL MODE
                  ENTITY Item
                   UPDATE FIELDS ( res_mark1_ind  res_mark2_ind res_mark3_ind res_mark4_ind res_mark5_ind
                                   res_mark6_ind  res_mark7_ind res_mark8_ind res_mark9_ind res_mark10_ind )
       WITH VALUE #( FOR key IN keys
                     ( %cid_ref                = ''
                       %is_draft               = lwa_mat_data-%is_draft
                       %key-cuuid              = key-cuuid
                       %key-InspectionLot      = key-InspectionLot
                       %key-InspLotItem        = key-InspLotItem
                       res_mark1_ind           = ind
                       res_mark2_ind           = ind1
                       res_mark3_ind           = ind2
                       res_mark4_ind           = ind3
                       res_mark5_ind           = ind4
                       res_mark6_ind           = ind5
                       res_mark7_ind           = ind6
                       res_mark8_ind           = ind7
                       res_mark9_ind           = ind8
                       res_mark10_ind          = ind9
                       %control-res_mark1_ind  = if_abap_behv=>mk-on
                       %control-res_mark2_ind  = if_abap_behv=>mk-on
                       %control-res_mark3_ind  = if_abap_behv=>mk-on
                       %control-res_mark4_ind  = if_abap_behv=>mk-on
                       %control-res_mark5_ind  = if_abap_behv=>mk-on
                       %control-res_mark6_ind  = if_abap_behv=>mk-on
                       %control-res_mark7_ind  = if_abap_behv=>mk-on
                       %control-res_mark8_ind  = if_abap_behv=>mk-on
                       %control-res_mark9_ind  = if_abap_behv=>mk-on
                       %control-res_mark10_ind = if_abap_behv=>mk-on
                       %control-res_mark11_ind = if_abap_behv=>mk-on

                     ) )

       FAILED DATA(fal)
             REPORTED DATA(rep)
             MAPPED DATA(map).

  ENDMETHOD.

ENDCLASS.

CLASS lsc_zcds_qm_ins_lot_h DEFINITION INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

ENDCLASS.

CLASS lsc_zcds_qm_ins_lot_h IMPLEMENTATION.

  METHOD save_modified.

    DATA : lit_qm_item    TYPE STANDARD TABLE OF zta_qm_insplot_i,
           lit_qm_item_ud TYPE STANDARD TABLE OF zta_qm_insplot_i.

    DATA(lit_update) = update-item.
    IF update-item IS NOT INITIAL.

      lit_qm_item = CORRESPONDING #( update-item MAPPING FROM ENTITY ).

      SELECT * FROM zcds_qm_ins_lot_i
      FOR ALL ENTRIES IN @lit_qm_item
      WHERE InspectionLot = @lit_qm_item-inspectionlot
      AND InspLotItem = @lit_qm_item-insp_lot_item
      INTO TABLE @DATA(lit_stb_data).

      SELECT * FROM zta_qm_insplot_i
      FOR ALL ENTRIES IN @lit_qm_item
            WHERE InspectionLot = @lit_qm_item-inspectionlot
            AND insp_lot_item = @lit_qm_item-insp_lot_item
            INTO TABLE @DATA(lit_tb_data).

      LOOP AT lit_qm_item INTO DATA(lwa_qm_item).
        DATA(lwa_stb_data) = VALUE #( lit_stb_data[ InspectionLot = lwa_qm_item-inspectionlot
                                      InspLotItem = lwa_qm_item-insp_lot_item ] OPTIONAL ).
        DATA(lwa_tb_data) = VALUE #( lit_tb_data[ InspectionLot = lwa_qm_item-inspectionlot
                                     insp_lot_item = lwa_qm_item-insp_lot_item ] OPTIONAL ).
        DATA(lwa_update) = VALUE #( lit_update[ InspectionLot = lwa_qm_item-inspectionlot
                                    InspLotItem = lwa_qm_item-insp_lot_item ] OPTIONAL ).

        IF lwa_tb_data-inspectionlot IS INITIAL AND lwa_tb_data-insp_lot_item IS INITIAL .

          lwa_qm_item-res = lwa_update-Resval1.
          lwa_qm_item-res2 = lwa_update-Resval2.
          lwa_qm_item-res3 = lwa_update-Resval3.
          lwa_qm_item-res4 = lwa_update-Resval4.
          lwa_qm_item-res5 = lwa_update-Resval5.
          lwa_qm_item-res6 = lwa_update-Resval6.
          lwa_qm_item-res7 = lwa_update-Resval7.
          lwa_qm_item-res8 = lwa_update-Resval8.
          lwa_qm_item-res9 = lwa_update-Resval9.
          lwa_qm_item-res10 = lwa_update-Resval10.
          lwa_qm_item-res11 = lwa_update-Resval11.
          lwa_qm_item-inspectionspecification = lwa_stb_data-InspectionSpecification.
          lwa_qm_item-selectedcodesettext = lwa_stb_data-SelectedCodeSetText.
          lwa_qm_item-othertext1 = lwa_stb_data-othertext1.
          lwa_qm_item-othertext2 = lwa_stb_data-othertext2.

          lwa_qm_item-created_by = sy-uname.
          lwa_qm_item-created_on = sy-datum.

        ENDIF.

        IF lwa_tb_data-inspectionlot IS NOT INITIAL AND lwa_tb_data-insp_lot_item IS NOT INITIAL .

          lwa_qm_item-res = COND #( WHEN lwa_update-Resval1 IS NOT INITIAL THEN lwa_update-Resval1 ELSE  lwa_tb_data-res ).
          lwa_qm_item-res2 = COND #( WHEN lwa_update-Resval2 IS NOT INITIAL THEN lwa_update-Resval2 ELSE  lwa_tb_data-res2 ).
          lwa_qm_item-res3 = COND #( WHEN lwa_update-Resval3 IS NOT INITIAL THEN lwa_update-Resval3 ELSE  lwa_tb_data-res3 ).
          lwa_qm_item-res4 = COND #( WHEN lwa_update-Resval4 IS NOT INITIAL THEN lwa_update-Resval4 ELSE  lwa_tb_data-res4 ).
          lwa_qm_item-res5 = COND #( WHEN lwa_update-Resval5 IS NOT INITIAL THEN lwa_update-Resval5 ELSE  lwa_tb_data-res5 ).
          lwa_qm_item-res6 = COND #( WHEN lwa_update-Resval6 IS NOT INITIAL THEN lwa_update-Resval6 ELSE  lwa_tb_data-res6 ).
          lwa_qm_item-res7 = COND #( WHEN lwa_update-Resval7 IS NOT INITIAL THEN lwa_update-Resval7 ELSE  lwa_tb_data-res7 ).
          lwa_qm_item-res8 = COND #( WHEN lwa_update-Resval8 IS NOT INITIAL THEN lwa_update-Resval8 ELSE  lwa_tb_data-res8 ).
          lwa_qm_item-res9 = COND #( WHEN lwa_update-Resval9 IS NOT INITIAL THEN lwa_update-Resval9 ELSE  lwa_tb_data-res9 ).
          lwa_qm_item-res10 = COND #( WHEN lwa_update-Resval10 IS NOT INITIAL THEN lwa_update-Resval10 ELSE  lwa_tb_data-res10 ).
          lwa_qm_item-res11 = COND #( WHEN lwa_update-Resval11 IS NOT INITIAL THEN lwa_update-Resval11 ELSE  lwa_tb_data-res11 ).
          lwa_qm_item-inspectionspecification = lwa_stb_data-InspectionSpecification.
          lwa_qm_item-selectedcodesettext = lwa_stb_data-SelectedCodeSetText.
          lwa_qm_item-othertext1 = lwa_update-othertext1.
          lwa_qm_item-othertext2 = lwa_update-othertext2.
          lwa_qm_item-created_by = lwa_tb_data-created_by.
          lwa_qm_item-created_on = lwa_tb_data-created_on.
          lwa_qm_item-last_change_by = sy-uname.
          lwa_qm_item-last_change_on = sy-datum.
        ENDIF.
        APPEND lwa_qm_item TO lit_qm_item_ud.
        CLEAR: lwa_stb_data, lwa_qm_item.

      ENDLOOP.

      IF lit_tb_data IS INITIAL.
        INSERT zta_qm_insplot_i FROM TABLE @lit_qm_item_ud.
      ELSE.
        MODIFY zta_qm_insplot_i FROM TABLE @lit_qm_item_ud.
      ENDIF .


    ENDIF.



  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZCDS_QM_INS_LOT_H DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zcds_qm_ins_lot_h RESULT result.
    METHODS getpdf FOR MODIFY
      IMPORTING keys FOR ACTION zcds_qm_ins_lot_h~getpdf RESULT result.
    METHODS createinsplot FOR DETERMINE ON SAVE
      IMPORTING keys FOR zcds_qm_ins_lot_h~createinsplot.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR header RESULT result.

ENDCLASS.

CLASS lhc_ZCDS_QM_INS_LOT_H IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD getpdf.


    DATA: lit_create TYPE TABLE FOR CREATE zcds_qm_ins_lot_h,
          lwa_create LIKE LINE OF lit_create.

    DATA : lit_data       TYPE TABLE OF zcds_qm_ins_lot_h,
           lwa_data       TYPE zcds_qm_ins_lot_h,
           lit_data_i     TYPE TABLE OF zcds_qm_ins_lot_i,
           lv_base64      TYPE string,
           lit_header_upd TYPE TABLE FOR UPDATE zcds_qm_ins_lot_h,
           lwa_header_upd LIKE LINE OF lit_header_upd,
           lv_token       TYPE string,
           lv_message     TYPE string,

           lit_itemdata   TYPE TABLE OF zcds_qm_ins_lot_i,
           lwa_itemdata   TYPE zcds_qm_ins_lot_i.


    READ ENTITIES OF zcds_qm_ins_lot_h
      IN LOCAL MODE
      ENTITY Header BY \_Item
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lit_item_data)
      ENTITY Header
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lit_header_data)
      FAILED DATA(lit_failed).

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

    zbp_cds_qm_ins_lot_h=>get_pdf_xml(
      EXPORTING
*       im_data    = lit_data
        im_data_h  = lit_data
        im_data_i  = lit_data_i
      IMPORTING
        ex_base_64 = lv_base64
    ).


    zcl_btp_adobe_form=>get_pdf_api(
      EXPORTING
        im_url           = 'ADS_URL'
        im_url_path      = '/v1/adsRender/pdf?TraceLevel=2&templateSource=storageName'
        im_clientid      = 'ADS_CLIENTID'
        im_clientsecret  = 'ADS_CLIENTSECRET'
        im_token         = lv_token
        im_base64_encode = lv_base64
        im_xdp_template  = 'ZFIRST_FIVE_PIECES/ZFIRST_FIVE_PIECES_FORM'
      IMPORTING
        ex_base64_decode = DATA(lv_base64_decode)
        ex_message       = lv_message
    ).


    DATA(lwa_data1) = VALUE #( lit_item_data[ 1 ] OPTIONAL ).

    MODIFY ENTITIES OF zcds_qm_ins_lot_h IN LOCAL MODE
      ENTITY Header
      UPDATE FIELDS (  Attachments filename mimetype  )
      WITH VALUE #( FOR lwa_header IN lit_header_data ( %tky        = lwa_header-%tky
                                                        Attachments = lv_base64_decode
                                                        filename    = 'Form'
                                                        mimetype    = 'application/pdf'
                    ) )
    FAILED failed
    REPORTED reported.

    READ ENTITIES OF  zcds_qm_ins_lot_h IN LOCAL MODE
          ENTITY Item
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


    READ ENTITIES OF zcds_qm_ins_lot_h IN LOCAL MODE
    ENTITY Header
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(lit_mat_data).

    DATA(lwa_mat_data) = VALUE #( lit_mat_data[ 1 ] OPTIONAL ).

*Get Product Long Text*
    READ ENTITIES OF I_ProductTP_2 PRIVILEGED
      ENTITY ProductBasicText
      ALL FIELDS WITH VALUE #( ( %key-Product        = lwa_mat_data-Material
                                 %key-TextObjectType = 'GRUN'
                                 %key-Language       = 'E' ) )

      RESULT DATA(lit_prodtext)
      REPORTED DATA(lit_reported).
    DATA(lwa_prodtext) = VALUE #( lit_prodtext[ 1 ] OPTIONAL ).


*Create Inspection Lot*
    MODIFY ENTITIES OF I_InspectionLotTP_2 PRIVILEGED
    ENTITY InspectionLot
        CREATE FIELDS ( material plant inspectionlottype inspectionlotquantity  )
            WITH VALUE #( (
                          %cid                  = 'CID_001'
                          material              = lwa_mat_data-Material
                          plant                 = lwa_mat_data-Plant
                          inspectionlottype     = '89'
                          inspectionlotquantity = 5
                          ) )
        MAPPED DATA(mapped1)
        REPORTED DATA(reported1)
        FAILED DATA(failed).

    DATA(lv_ins_lot) = VALUE #( mapped1-inspectionlot[ 1 ]-InspectionLot OPTIONAL ).


    IF lv_ins_lot IS NOT INITIAL.
      MODIFY ENTITIES OF zcds_qm_ins_lot_h IN LOCAL MODE
                    ENTITY Header
                     UPDATE FIELDS ( InspectionLot Material Plant ManufacturingOrder ProductLongText )
         WITH VALUE #( FOR key IN keys
                       ( %cid_ref                    = ''
                         %is_draft                   = lwa_mat_data-%is_draft
                         cuuid                       = key-cuuid

                         InspectionLot               = lv_ins_lot
                         Material                    = lwa_mat_data-Material
                         Plant                       = lwa_mat_data-Plant
                         ManufacturingOrder          = lwa_mat_data-ManufacturingOrder
                         ProductLongText             = lwa_prodtext-ProductLongText
                         %control-InspectionLot      = if_abap_behv=>mk-on
                         %control-Material           = if_abap_behv=>mk-on
                         %control-Plant              = if_abap_behv=>mk-on
                         %control-ManufacturingOrder = if_abap_behv=>mk-on
                         %control-ProductLongText    = if_abap_behv=>mk-on
                       ) )

         FAILED DATA(fal)
               REPORTED DATA(rep)
               MAPPED DATA(map).


    ENDIF.

  ENDMETHOD.

  METHOD get_instance_features.
    READ ENTITIES OF zcds_qm_ins_lot_h IN LOCAL MODE
      ENTITY Header
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lit_mat_data).

    READ ENTITY IN LOCAL MODE zcds_qm_ins_lot_h
            ALL FIELDS WITH CORRESPONDING #( keys )
            RESULT DATA(resi).

    SELECT * FROM zta_qm_insplot_i
    FOR ALL ENTRIES IN @lit_mat_data
    WHERE cuuid = @lit_mat_data-cuuid
    INTO TABLE @DATA(lit_item_tb).
    DATA : lv_flag TYPE c.
    LOOP AT lit_item_tb INTO DATA(ls_data).
      IF ls_data-res IS INITIAL OR
         ls_data-res2 IS INITIAL OR
         ls_data-res3 IS INITIAL OR
         ls_data-res4 IS INITIAL OR
         ls_data-res5 IS INITIAL OR
         ls_data-res6 IS INITIAL OR
         ls_data-res7 IS INITIAL OR
         ls_data-res8 IS INITIAL OR
         ls_data-res9 IS INITIAL OR
         ls_data-res10 IS INITIAL OR
         ls_data-res11 IS INITIAL.
        lv_flag = 'X'.
        EXIT.
      ENDIF.
    ENDLOOP.
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
        %features-%field-QC_Status           = COND #( WHEN lv_flag = 'X'
                                                           THEN if_abap_behv=>fc-f-read_only
                                                      ELSE if_abap_behv=>fc-f-unrestricted ) ) ).

  ENDMETHOD.

ENDCLASS.
