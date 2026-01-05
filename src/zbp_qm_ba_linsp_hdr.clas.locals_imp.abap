CLASS lhc_zqm_ba_linsp_spc DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS resulttxt FOR DETERMINE ON SAVE
      IMPORTING keys FOR zqm_ba_linsp_spc~resulttxt.

ENDCLASS.

CLASS lhc_zqm_ba_linsp_spc IMPLEMENTATION.

  METHOD resulttxt.
  ENDMETHOD.

ENDCLASS.

CLASS lhc_ZQM_BA_LINSP_HDR DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS createlineinsplot FOR DETERMINE ON SAVE
      IMPORTING keys FOR zqm_ba_linsp_hdr~createlineinsplot.

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

ENDCLASS.

CLASS lsc_ZQM_BA_LINSP_HDR DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZQM_BA_LINSP_HDR IMPLEMENTATION.

  METHOD save_modified.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
