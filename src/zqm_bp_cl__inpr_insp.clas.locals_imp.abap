CLASS lhc_ZqmCmInprocessinspectionrp DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR ZqmCmInprocessinspectionrpt RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR ZqmCmInprocessinspectionrpt RESULT result.

    METHODS createinsplot FOR DETERMINE ON SAVE
      IMPORTING keys FOR ZqmCmInprocessinspectionrpt~createinsplot.

ENDCLASS.

CLASS lhc_ZqmCmInprocessinspectionrp IMPLEMENTATION.

  METHOD get_instance_features.

    READ ENTITY IN LOCAL MODE ZQM_CM_InprocessInspectionRpt
            ALL FIELDS WITH CORRESPONDING #( keys )
            RESULT DATA(lt_header).

    SELECT * FROM ZQM_CM_InprocessInspectionRpt
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

        %features-%field-Qcstatus           = COND #( WHEN ls_item-Result1 IS NOT INITIAL
                                                       AND ls_item-Result2 IS NOT INITIAL
                                                       AND ls_item-Result3 IS NOT INITIAL
                                                      THEN  if_abap_behv=>fc-f-unrestricted
                                                      ELSE  if_abap_behv=>fc-f-read_only )
                                                      ) ).

  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD createinsplot.

    READ ENTITIES OF ZQM_CM_InprocessInspectionRpt IN LOCAL MODE
       ENTITY ZqmCmInprocessinspectionrpt
       ALL FIELDS WITH CORRESPONDING #( keys )
       RESULT DATA(lit_mat_data).

    DATA(lwa_mat_data) = VALUE #( lit_mat_data[ 1 ] OPTIONAL ).


    MODIFY ENTITIES OF I_InspectionLotTP_2 PRIVILEGED "IN LOCAL MODE
    ENTITY InspectionLot
        CREATE FIELDS ( material plant inspectionlottype inspectionlotquantity )
            WITH VALUE #( (
                          %cid                  = 'CID_001'
                          material              = lwa_mat_data-Material
                          plant                 = lwa_mat_data-Plant
                          inspectionlottype     = '89'
                          inspectionlotquantity = 1
*                          ManufacturingOrder    = lwa_mat_data-Manufacturingorder
                          ) )
        MAPPED   DATA(mapped1)
        REPORTED DATA(reported1)
        FAILED   DATA(failed).

    DATA(lv_ins_lot) = VALUE #( mapped1-inspectionlot[ 1 ]-InspectionLot OPTIONAL ).


    MODIFY ENTITIES OF  ZQM_CM_InprocessInspectionRpt IN LOCAL MODE
                  ENTITY ZqmCmInprocessinspectionrpt
                   UPDATE FIELDS ( InspectionLot )
       WITH VALUE #( FOR key IN keys
                     ( %cid_ref               = ''
                       %is_draft              = lwa_mat_data-%is_draft
                       %key                   = key-%key
                       InspectionLot          = lv_ins_lot       ""mapped1-inspectionlot
                       ManufacturingOrder     = lwa_mat_data-ManufacturingOrder
                       %control-InspectionLot = if_abap_behv=>mk-on
                       %control-Manufacturingorder = if_abap_behv=>mk-on
                     ) )

       FAILED DATA(fal)
             REPORTED DATA(rep)
             MAPPED DATA(map).


  ENDMETHOD.

ENDCLASS.
