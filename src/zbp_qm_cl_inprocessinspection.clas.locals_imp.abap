*****CLASS lhc_Header DEFINITION INHERITING FROM cl_abap_behavior_handler.
*****  PRIVATE SECTION.
*****
*****    METHODS get_instance_features FOR INSTANCE FEATURES
*****      IMPORTING keys REQUEST requested_features FOR ZQM_BA_InprocessInspectionHead RESULT result.
*****
*****    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
*****      IMPORTING keys REQUEST requested_authorizations FOR ZQM_BA_InprocessInspectionHead RESULT result.
*****
*****    METHODS getpdf FOR MODIFY
*****      IMPORTING keys FOR ACTION ZQM_BA_InprocessInspectionHead~getpdf RESULT result.
*****
*****    METHODS createinsplot FOR DETERMINE ON SAVE
*****      IMPORTING keys FOR ZQM_BA_InprocessInspectionHead~createinsplot.
*****
*****ENDCLASS.
*****
*****CLASS lhc_Header IMPLEMENTATION.
*****
*****  METHOD get_instance_features.
*****
*****    READ ENTITY IN LOCAL MODE ZQM_BA_InprocessInspectionHead
*****              ALL FIELDS WITH CORRESPONDING #( keys )
*****              RESULT DATA(lt_header).
*****
*****    SELECT * FROM ZQM_BA_InprocessInspectionRecd
*****    WHERE Cuuid = @( VALUE #( lt_header[ 1 ]-Cuuid ) )
*****    INTO TABLE @DATA(lt_item).
*****    IF sy-subrc = 0.
*****      DATA(ls_item) = VALUE #( lt_item[ 1 ] OPTIONAL ).
*****    ENDIF.
*****
*****
*****    result = VALUE #( FOR ls_header IN lt_header ( %tky = ls_header-%tky
*****        %features-%field-inspectionlot      = COND #( WHEN ls_header-inspectionlot IS NOT INITIAL
*****                                                           THEN if_abap_behv=>fc-f-read_only
*****                                                      ELSE if_abap_behv=>fc-f-unrestricted )
*****        %features-%field-manufacturingorder = COND #( WHEN ls_header-manufacturingorder IS NOT INITIAL
*****                                                           THEN if_abap_behv=>fc-f-read_only
*****                                                      ELSE if_abap_behv=>fc-f-unrestricted )
*****        %features-%field-Material           = COND #( WHEN ls_header-Material IS NOT INITIAL
*****                                                           THEN if_abap_behv=>fc-f-read_only
*****                                                      ELSE if_abap_behv=>fc-f-unrestricted )
*****        %features-%field-Plant              = COND #( WHEN ls_header-Plant IS NOT INITIAL
*****                                                           THEN if_abap_behv=>fc-f-read_only
*****                                                      ELSE if_abap_behv=>fc-f-unrestricted )
*****        %features-%field-Batch              = COND #( WHEN ls_header-Batch IS NOT INITIAL
*****                                                           THEN if_abap_behv=>fc-f-read_only
*****                                                      ELSE if_abap_behv=>fc-f-unrestricted )
*****
*****        %features-%field-Qcstatus           = COND #( WHEN ls_item-Result1 IS NOT INITIAL
*****                                                       AND ls_item-Result2 IS NOT INITIAL
*****                                                       AND ls_item-Result3 IS NOT INITIAL
*****                                                      THEN  if_abap_behv=>fc-f-unrestricted
*****                                                      ELSE  if_abap_behv=>fc-f-read_only )
*****                                                      ) ).
*****
*****
*****  ENDMETHOD.
*****
*****  METHOD get_instance_authorizations.
*****  ENDMETHOD.
*****
*****  METHOD getpdf.
*****  ENDMETHOD.
*****
*****  METHOD createinsplot.
*****
*****    READ ENTITIES OF ZQM_BA_InprocessInspectionHead IN LOCAL MODE
*****     ENTITY ZQM_BA_InprocessInspectionHead
*****     ALL FIELDS WITH CORRESPONDING #( keys )
*****     RESULT DATA(lt_mat_data).
*****
*****    IF lt_mat_data IS NOT INITIAL.
*****
*****      DATA(ls_mat_data) = VALUE #( lt_mat_data[ 1 ] OPTIONAL ).
*****
*****
*****      MODIFY ENTITIES OF I_InspectionLotTP_2 PRIVILEGED "IN LOCAL MODE
*****      ENTITY InspectionLot
*****          CREATE FIELDS ( Material Plant InspectionLotType InspectionLotQuantity  )
*****              WITH VALUE #( (
*****                            %cid                  = 'CID_001'
*****                            Material              = ls_mat_data-Material
*****                            Plant                 = ls_mat_data-Plant
*****                            InspectionLotType     = '89'
*****                            InspectionLotQuantity = 1
******                            ManufacturingOrder    = ls_mat_data-Manufacturingorder
*****                            ) )
*****          MAPPED DATA(mapped1)
*****          REPORTED DATA(reported1)
*****          FAILED DATA(failed).
*****
*****      DATA(lv_ins_lot) = VALUE #( mapped1-inspectionlot[ 1 ]-InspectionLot OPTIONAL ).
*****
*****
******      SELECT * FROM I_InspectionLot
******      WHERE InspectionLot = @lv_ins_lot
******      INTO TABLE @DATA(lt_inspection).
*****
*****      READ ENTITIES OF I_InspectionLotTP_2 PRIVILEGED
*****      ENTITY InspectionOperation
*****      ALL FIELDS WITH VALUE #( ( InspectionLot = lv_ins_lot ) )
*****      RESULT DATA(lt_insp_result).
*****
*****      MODIFY ENTITIES OF ZQM_BA_InprocessInspectionHead IN LOCAL MODE
*****      ENTITY ZQM_BA_InprocessInspectionHead
*****      UPDATE FIELDS ( InspectionLot
*****                      Material
*****                      Plant
*****                      ManufacturingOrder
*****                       )
*****      WITH VALUE #( "FOR key IN keys
*****                    ( %cid_ref               = ''
*****                      %is_draft              = ls_mat_data-%is_draft
*****                      Cuuid                  = VALUE #( keys[ 1 ]-cuuid OPTIONAL )
*****                      InspectionLot          = lv_ins_lot          ""mapped1-inspectionlot
*****                      Material               = ls_mat_data-Material
*****                      Plant                  = ls_mat_data-Plant
*****                      ManufacturingOrder     = ls_mat_data-ManufacturingOrder
*****                      %control-InspectionLot = if_abap_behv=>mk-on
*****                      %control-Material      = if_abap_behv=>mk-on
*****                      %control-Plant         = if_abap_behv=>mk-on
******                      %control-ManufacturingOrder = if_abap_behv=>mk-on
*****                    ) )
*****
*****               FAILED DATA(lt_fail)
*****               REPORTED DATA(lt_reported)
*****               MAPPED DATA(lt_mapped).
*****
*****    ENDIF.
*****
*****  ENDMETHOD.
*****
*****ENDCLASS.
