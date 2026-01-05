CLASS lhc_zqm_ba_ilot_i DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS createitem FOR DETERMINE ON SAVE
      IMPORTING keys FOR zqm_ba_ilot_i~createitem.

ENDCLASS.

CLASS lhc_zqm_ba_ilot_i IMPLEMENTATION.

  METHOD createitem.

    SELECT *
      FROM i_inspectioncharacteristic
      WHERE inspectionlot = @zbp_qm_ba_ilot_h=>gv_ins_lot
      INTO TABLE @DATA(lt_char).


  ENDMETHOD.

ENDCLASS.

CLASS lhc_zqm_ba_ilot_h DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS createinsplot FOR DETERMINE ON SAVE
      IMPORTING keys FOR zqm_ba_ilot_h~createinsplot.

ENDCLASS.

CLASS lhc_zqm_ba_ilot_h IMPLEMENTATION.

  METHOD createinsplot.

    " --- defensive checks ---
    IF keys IS INITIAL.
      RETURN.
    ENDIF.

*    TRY.
    " read header rows for keys (local read)
    READ ENTITIES OF zqm_ba_ilot_h IN LOCAL MODE
      ENTITY zqm_ba_ilot_h
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

    zbp_qm_ba_ilot_h=>gv_ins_lot = VALUE #( mapped_ilot-inspectionlot[ 1 ]-InspectionLot OPTIONAL ).

    " update own header with returned inspection lot number
    MODIFY ENTITIES OF zqm_ba_ilot_h IN LOCAL MODE
      ENTITY zqm_ba_ilot_h
      UPDATE FIELDS ( Reportnumber Material Plant Productionorder )
      WITH VALUE #( FOR key IN keys
                    ( %cid_ref                 = ''
                      %is_draft                = ls_header-%is_draft
                      uniqueid                 = key-uniqueid
                      Reportnumber             = lv_inslot
                      Material                 = ls_header-Material
                      Plant                    = ls_header-Plant
                      Productionorder          = ls_header-Productionorder
                      %control-Reportnumber    = if_abap_behv=>mk-on
                      %control-Material        = if_abap_behv=>mk-on
                      %control-Plant           = if_abap_behv=>mk-on
                      %control-Productionorder = if_abap_behv=>mk-on ) )
      FAILED DATA(failed_zilot)
      REPORTED DATA(reported_zilot)
      MAPPED DATA(mapped_zilot).

  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZQM_BA_ILOT_H DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZQM_BA_ILOT_H IMPLEMENTATION.

  METHOD save_modified.

    DATA : lt_item_ins TYPE STANDARD TABLE OF zqm_t_ilot_i,
           lt_item_upd TYPE STANDARD TABLE OF zqm_t_ilot_i,
           lt_item_del TYPE STANDARD TABLE OF zqm_t_ilot_i.

    " --- Create Items ---
    IF create-zqm_ba_ilot_i IS NOT INITIAL.

      lt_item_ins = CORRESPONDING #( create-zqm_ba_ilot_i
              MAPPING
                uniqueid                    = uniqueid
                reportnumberitem            = ReportNumberItem
                inspplanoperationinternalid = InspPlanOperationInternalID
                inspecttargetvalue          = InspSpecTargetValue
                labmax                      = lab_max
                labmin                      = lab_min
                result1val1      = Result1val1
                result1val2      = Result1val2
                result1val3      = Result1val3
                result1val4      = Result1val4
                result1val5      = Result1val5
                result1val6      = Result1val6
                result1val7      = Result1val7
                result1val8      = Result1val8
                result1val9      = Result1val9
                result1val10     = Result1val10
                result1val11     = Result1val11
                result2val1      = Result2val1
                result2val2      = Result2val2
                result2val3      = Result2val3
                result2val4      = Result2val4
                result2val5      = Result2val5
                result2val6      = Result2val6
                result2val7      = Result2val7
                result2val8      = Result2val8
                result2val9      = Result2val9
                result2val10     = Result2val10
                result2val11     = Result2val11
            ).

      LOOP AT lt_item_ins ASSIGNING FIELD-SYMBOL(<ls_item>).
        IF zbp_qm_ba_ilot_h=>gv_ins_lot IS NOT INITIAL.
          <ls_item>-reportnumber = zbp_qm_ba_ilot_h=>gv_ins_lot.
        ENDIF.
      ENDLOOP.

      INSERT zqm_t_ilot_i FROM TABLE @lt_item_ins.

    ENDIF.

    IF update-zqm_ba_ilot_i IS NOT INITIAL.
      lt_item_upd = CORRESPONDING #( update-zqm_ba_ilot_i ).
      " Update items by key
      MODIFY zqm_t_ilot_i FROM TABLE @lt_item_upd.
    ENDIF.

    " --- Delete Items ---
    IF delete-zqm_ba_ilot_i IS NOT INITIAL.
      lt_item_del = CORRESPONDING #( delete-zqm_ba_ilot_i ).
      " Delete items by key
      DELETE zqm_t_ilot_i FROM TABLE @lt_item_del.
    ENDIF.

  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
