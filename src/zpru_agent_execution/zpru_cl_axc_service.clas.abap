CLASS zpru_cl_axc_service DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zpru_if_axc_service.

  PROTECTED SECTION.
    METHODS precheck_create
      IMPORTING it_head_create_imp TYPE zpru_if_axc_service=>tt_head_create_imp
      EXPORTING et_entities        TYPE zpru_if_axc_service=>tt_head_create_imp
      CHANGING  cs_reported        TYPE zpru_if_axc_service=>ts_reported
                cs_failed          TYPE zpru_if_axc_service=>ts_failed.

    METHODS fill_head_admin_fields
      IMPORTING iv_during_create TYPE abap_boolean DEFAULT abap_false
      CHANGING  cs_header        TYPE zpru_cl_axc_buffer=>ts_header.
ENDCLASS.


CLASS zpru_cl_axc_service IMPLEMENTATION.
  METHOD fill_head_admin_fields.
    GET TIME STAMP FIELD DATA(lv_now).

    IF iv_during_create = abap_true.
      cs_header-instance-created_by = COND #( WHEN cs_header-instance-created_by IS INITIAL
                                              THEN sy-uname
                                              ELSE cs_header-instance-created_by ).

      cs_header-instance-created_at = COND #( WHEN cs_header-instance-created_at IS INITIAL
                                              THEN lv_now
                                              ELSE cs_header-instance-created_at ).
    ENDIF.

    cs_header-instance-changed_by   = COND #( WHEN cs_header-instance-changed_by IS INITIAL
                                              THEN sy-uname
                                              ELSE cs_header-instance-changed_by ).

    cs_header-instance-last_changed = COND #( WHEN cs_header-instance-last_changed IS INITIAL
                                              THEN lv_now
                                              ELSE cs_header-instance-last_changed ).
  ENDMETHOD.

  METHOD zpru_if_axc_service~read_agent_execution.
    DATA lo_axc_database_access TYPE REF TO zpru_if_axc_database_access.

    CLEAR: et_axc_head,
           et_axc_query,
           et_axc_step.

    IF it_axc_head_k IS INITIAL.
      RETURN.
    ENDIF.

    lo_axc_database_access = NEW zpru_cl_axc_database_access( ).

    et_axc_head = lo_axc_database_access->select_head( it_axc_head_k ).

    IF et_axc_query IS SUPPLIED.
      et_axc_query = lo_axc_database_access->select_query_by_head( it_axc_head_k ).
    ENDIF.

    IF et_axc_step IS SUPPLIED.
      et_axc_step = lo_axc_database_access->select_step_by_query( VALUE #( FOR <ls_q_k> IN et_axc_query
                                                                           ( query_uuid = <ls_q_k>-query_uuid  ) ) ).
    ENDIF.
  ENDMETHOD.

  METHOD zpru_if_axc_service~get_actual_query.
    DATA lo_axc_database_access TYPE REF TO zpru_if_axc_database_access.

    IF it_axc_head_k IS INITIAL.
      RETURN.
    ENDIF.

    lo_axc_database_access = NEW zpru_cl_axc_database_access( ).
    DATA(lt_query_candidates) = lo_axc_database_access->select_query_by_head( it_axc_head_k ).

    LOOP AT it_axc_head_k ASSIGNING FIELD-SYMBOL(<ls_axc_head_k>).

      DATA(lt_query_copy) = lt_query_candidates.
      DELETE lt_query_copy WHERE run_uuid <> <ls_axc_head_k>-run_uuid.
      DELETE lt_query_copy WHERE execution_status <> zpru_if_agent_frw=>cs_execution_status-new.

      SORT lt_query_copy BY start_timestamp ASCENDING.

      APPEND INITIAL LINE TO rt_axc_head_query_link ASSIGNING FIELD-SYMBOL(<ls_axc_head_query_link>).
      <ls_axc_head_query_link>-run_uuid   = <ls_axc_head_k>-run_uuid.
      <ls_axc_head_query_link>-query_uuid = VALUE #( lt_query_copy[ 1 ]-query_uuid OPTIONAL ).

    ENDLOOP.
  ENDMETHOD.

  METHOD zpru_if_axc_service~cba_query.
  ENDMETHOD.

  METHOD zpru_if_axc_service~delete.
  ENDMETHOD.

  METHOD zpru_if_axc_service~lock.
  ENDMETHOD.

  METHOD zpru_if_axc_service~rba_query.
  ENDMETHOD.

  METHOD zpru_if_axc_service~read.
  ENDMETHOD.

  METHOD zpru_if_axc_service~update.

    IF it_head_update_imp IS INITIAL.
      RETURN.
    ENDIF.

    zpru_cl_axc_buffer=>prep_header_buffer( VALUE #( FOR <ls_k>
                                                     IN     it_head_update_imp
                                                     ( run_uuid = <ls_k>-run_uuid ) ) ).

    LOOP AT it_head_update_imp ASSIGNING FIELD-SYMBOL(<ls_update>).

      ASSIGN zpru_cl_axc_buffer=>header_buffer[ instance-run_uuid = <ls_update>-run_uuid
                                                deleted           = abap_false ] TO FIELD-SYMBOL(<ls_buffer>).
      IF sy-subrc = 0.
        <ls_buffer>-instance-agent_uuid      = COND #( WHEN <ls_update>-control-agent_uuid = abap_true
                                                       THEN <ls_update>-agent_uuid
                                                       ELSE <ls_buffer>-instance-agent_uuid ).
        <ls_buffer>-instance-user_id         = COND #( WHEN <ls_update>-control-user_id = abap_true
                                                       THEN <ls_update>-user_id
                                                       ELSE <ls_buffer>-instance-user_id ).
        <ls_buffer>-instance-start_timestamp = COND #( WHEN <ls_update>-control-start_timestamp = abap_true
                                                       THEN <ls_update>-start_timestamp
                                                       ELSE <ls_buffer>-instance-start_timestamp ).
        <ls_buffer>-instance-end_timestamp   = COND #( WHEN <ls_update>-control-end_timestamp = abap_true
                                                       THEN <ls_update>-end_timestamp
                                                       ELSE <ls_buffer>-instance-end_timestamp ).
        <ls_buffer>-instance-created_by      = COND #( WHEN <ls_update>-control-created_by = abap_true
                                                       THEN <ls_update>-created_by
                                                       ELSE <ls_buffer>-instance-created_by ).
        <ls_buffer>-instance-created_at      = COND #( WHEN <ls_update>-control-created_at = abap_true
                                                       THEN <ls_update>-created_at
                                                       ELSE <ls_buffer>-instance-created_at ).
        <ls_buffer>-instance-changed_by      = COND #( WHEN <ls_update>-control-changed_by = abap_true
                                                       THEN <ls_update>-changed_by
                                                       ELSE <ls_buffer>-instance-changed_by ).
        <ls_buffer>-instance-last_changed    = COND #( WHEN <ls_update>-control-last_changed = abap_true
                                                       THEN <ls_update>-last_changed
                                                       ELSE <ls_buffer>-instance-last_changed ).
        <ls_buffer>-changed = abap_true.
        <ls_buffer>-deleted = abap_false.

        fill_head_admin_fields( EXPORTING iv_during_create = abap_false
                                CHANGING  cs_header        = <ls_buffer> ).

      ELSE.

        APPEND VALUE #( run_uuid = <ls_update>-run_uuid
                        update   = abap_true
                        fail     = zpru_if_agent_frw=>cs_fail_cause-not_found )
               TO cs_failed-header.

        APPEND VALUE #( run_uuid = <ls_update>-run_uuid
                        update   = abap_true
                        msg      = NEW zpru_cl_agent_util( )->zpru_if_agent_util~new_message(
                                           iv_id       = zpru_if_agent_frw=>cs_message_class-zpru_msg_execution
                                           iv_number   = `003`
                                           iv_severity = zpru_if_agent_message=>sc_severity-error ) )
               TO cs_reported-header.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD zpru_if_axc_service~create.
    IF it_head_create_imp IS INITIAL.
      RETURN.
    ENDIF.

    precheck_create( EXPORTING it_head_create_imp = it_head_create_imp
                     IMPORTING et_entities        = DATA(lt_entities)
                     CHANGING  cs_reported        = cs_reported
                               cs_failed          = cs_failed ).

    zpru_cl_axc_buffer=>prep_header_buffer( VALUE #( FOR <ls_k>
                                                     IN lt_entities
                                                     ( run_uuid = <ls_k>-run_uuid ) ) ).

    LOOP AT lt_entities ASSIGNING FIELD-SYMBOL(<ls_create>).

      IF    NOT line_exists( zpru_cl_axc_buffer=>header_buffer[ instance-run_uuid = <ls_create>-run_uuid ] )
         OR     line_exists( zpru_cl_axc_buffer=>header_buffer[ instance-run_uuid = <ls_create>-run_uuid
                                                                deleted           = abap_true ] ).

        DELETE zpru_cl_axc_buffer=>header_buffer
               WHERE     instance-run_uuid = VALUE #( zpru_cl_axc_buffer=>header_buffer[
                                                          instance-run_uuid = <ls_create>-run_uuid ]-instance-run_uuid OPTIONAL )
                     AND deleted           = abap_true.

        APPEND VALUE #(
            instance-run_uuid           = <ls_create>-run_uuid
            instance-agent_uuid         = COND #( WHEN <ls_create>-control-agent_uuid = abap_true
                                                  THEN <ls_create>-agent_uuid )
            instance-user_id            = COND #( WHEN <ls_create>-control-user_id = abap_true
                                                  THEN <ls_create>-user_id )
            instance-start_timestamp    = COND #( WHEN <ls_create>-control-start_timestamp = abap_true
                                                  THEN <ls_create>-start_timestamp )
            instance-end_timestamp      = COND #( WHEN <ls_create>-control-end_timestamp = abap_true
                                                  THEN <ls_create>-end_timestamp )
            instance-created_by         = COND #( WHEN <ls_create>-control-created_by = abap_true
                                                  THEN <ls_create>-created_by )
            instance-created_at         = COND #( WHEN <ls_create>-control-created_at = abap_true
                                                  THEN <ls_create>-created_at )
            instance-changed_by         = COND #( WHEN <ls_create>-control-changed_by <> if_abap_behv=>mk-off
                                                  THEN <ls_create>-changed_by )
            instance-last_changed       = COND #( WHEN <ls_create>-control-last_changed = abap_true
                                                  THEN <ls_create>-last_changed )
            instance-local_last_changed = COND #( WHEN <ls_create>-control-local_last_changed = abap_true
                                                  THEN <ls_create>-local_last_changed )
            changed                     = abap_true
            deleted                     = abap_false ) TO zpru_cl_axc_buffer=>header_buffer ASSIGNING FIELD-SYMBOL(<ls_just_added>).

        fill_head_admin_fields( EXPORTING iv_during_create = abap_true
                                CHANGING  cs_header        = <ls_just_added> ).

        INSERT VALUE #( run_uuid = <ls_create>-run_uuid ) INTO TABLE cs_mapped-header.

        APPEND VALUE #( msg      = NEW zpru_cl_agent_util( )->zpru_if_agent_util~new_message(
                                           iv_id       = zpru_if_agent_frw=>cs_message_class-zpru_msg_execution
                                           iv_number   = `001`
                                           iv_severity = zpru_if_agent_message=>sc_severity-success )
                        run_uuid = <ls_create>-run_uuid  ) TO cs_reported-header.

      ELSE.

        APPEND VALUE #( run_uuid = <ls_create>-run_uuid
                        create   = abap_true
                        fail     = zpru_if_agent_frw=>cs_fail_cause-unspecific )
               TO cs_failed-header.

        APPEND VALUE #( run_uuid = <ls_create>-run_uuid
                        create   = abap_true
                        msg      = NEW zpru_cl_agent_util( )->zpru_if_agent_util~new_message(
                                           iv_id       = zpru_if_agent_frw=>cs_message_class-zpru_msg_execution
                                           iv_number   = `002`
                                           iv_severity = zpru_if_agent_message=>sc_severity-error ) )
               TO cs_reported-header.

      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD precheck_create.

    CLEAR et_entities.

    LOOP AT it_head_create_imp ASSIGNING FIELD-SYMBOL(<ls_create>).
      IF <ls_create>-run_uuid IS INITIAL.
        TRY.
            <ls_create>-run_uuid = cl_system_uuid=>create_uuid_x16_static( ).
          CATCH cx_uuid_error.
            RAISE SHORTDUMP NEW zpru_cx_agent_core( ).
        ENDTRY.
      ENDIF.

      NEW zpru_cl_agent_util( )->zpru_if_agent_util~fill_flags(
        EXPORTING
          iv_name    = `ZPRU_IF_AXC_SERVICE=>TS_HEAD_CONTROL`
        CHANGING
          cs_data    = <ls_create>
          cs_control = <ls_create>-control ).

      IF <ls_create>-agent_uuid IS INITIAL.

        APPEND VALUE #( run_uuid = <ls_create>-run_uuid
                        create   = abap_true
                        fail     = zpru_if_agent_frw=>cs_fail_cause-dependency )
               TO cs_failed-header.

        APPEND VALUE #( run_uuid = <ls_create>-run_uuid
                        create   = abap_true
                        msg      = NEW zpru_cl_agent_util( )->zpru_if_agent_util~new_message(
                                           iv_id       = zpru_if_agent_frw=>cs_message_class-zpru_msg_execution
                                           iv_number   = `004`
                                           iv_severity = zpru_if_agent_message=>sc_severity-error ) )
               TO cs_reported-header.

        CONTINUE.
      ENDIF.

      APPEND INITIAL LINE TO et_entities ASSIGNING FIELD-SYMBOL(<ls_entity>).
      <ls_entity> = <ls_create>.

    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
