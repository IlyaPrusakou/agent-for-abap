CLASS zpru_cl_dummy_agent_logic DEFINITION
  PUBLIC FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zpru_if_decision_provider.
    INTERFACES zpru_if_short_memory_provider.
    INTERFACES zpru_if_long_memory_provider.
    INTERFACES zpru_if_agent_info_provider.
    INTERFACES zpru_if_prompt_provider.
    INTERFACES zpru_if_tool_provider.
    INTERFACES zpru_if_input_schema_provider.
    INTERFACES zpru_if_unit_agent.
ENDCLASS.


CLASS zpru_cl_dummy_agent_logic IMPLEMENTATION.
  METHOD zpru_if_unit_agent~execute_agent.
    DATA lo_api_agent TYPE REF TO zpru_if_api_agent.

    lo_api_agent = NEW zpru_cl_api_agent( ).
    TRY.
        lo_api_agent->initialize( EXPORTING iv_agent_name = iv_agent_name
                                  IMPORTING es_agent      = DATA(ls_agent)
                                  " TODO: variable is assigned but never used (ABAP cleaner)
                                            et_tools      = DATA(lt_tools) ).

        lo_api_agent->set_input_query( iv_input_query = iv_input_query
                                       iv_agent_uuid  = ls_agent-agent_uuid ).

        lo_api_agent->build_execution( EXPORTING iv_agent_uuid       = ls_agent-agent_uuid
                                       IMPORTING ev_built_run_uuid   = DATA(lv_built_run_uuid)
                                                 ev_built_query_uuid = DATA(lv_built_query_uuid)  ).

        lo_api_agent->run( EXPORTING iv_run_uuid       = lv_built_run_uuid
                                     iv_query_uuid     = lv_built_query_uuid
                           IMPORTING
                           " TODO: variable is assigned but never used (ABAP cleaner)
                                     eo_final_response = DATA(lo_final_response) ).

        lo_api_agent->save_execution( iv_do_commit = abap_true ).
      CATCH zpru_cx_agent_core.
    ENDTRY.
  ENDMETHOD.

  METHOD zpru_if_decision_provider~call_decision_engine.
    DATA lo_decision_provider TYPE REF TO zpru_if_decision_provider.

    lo_decision_provider = NEW lcl_decision_provider( ).

    lo_decision_provider->call_decision_engine( EXPORTING io_controller          = io_controller
                                                          io_input               = io_input
                                                          io_system_prompt       = io_system_prompt
                                                          io_short_memory        = io_short_memory
                                                          io_long_memory         = io_long_memory
                                                          io_agent_info_provider = io_agent_info_provider
                                                IMPORTING eo_execution_plan      = eo_execution_plan
                                                          eo_first_tool_input    = eo_first_tool_input
                                                          eo_langu               = eo_langu
                                                          eo_decision_log        = eo_decision_log ).
  ENDMETHOD.

  METHOD zpru_if_short_memory_provider~clear_history.
    DATA lo_short_memory TYPE REF TO zpru_if_short_memory_provider.

    lo_short_memory = NEW lcl_short_memory_provider( ).
    lo_short_memory->clear_history( ).
  ENDMETHOD.

  METHOD zpru_if_agent_info_provider~get_agent_info.
    DATA lo_agent_info_provider TYPE REF TO zpru_if_agent_info_provider.

    lo_agent_info_provider = NEW lcl_agent_info_provider( ).
    rv_agent_info = lo_agent_info_provider->get_agent_info( ).
  ENDMETHOD.

  METHOD zpru_if_short_memory_provider~get_discard_strategy.
    DATA lo_short_memory TYPE REF TO zpru_if_short_memory_provider.

    lo_short_memory = NEW lcl_short_memory_provider( ).
    ro_discard_strategy = lo_short_memory->get_discard_strategy( ).
  ENDMETHOD.

  METHOD zpru_if_short_memory_provider~get_history.
    DATA lo_short_memory TYPE REF TO zpru_if_short_memory_provider.

    lo_short_memory = NEW lcl_short_memory_provider( ).
    rt_history = lo_short_memory->get_history( ).
  ENDMETHOD.

  METHOD zpru_if_short_memory_provider~get_long_memory.
    DATA lo_short_memory TYPE REF TO zpru_if_short_memory_provider.

    lo_short_memory = NEW lcl_short_memory_provider( ).
    ro_long_memory = lo_short_memory->get_long_memory( ).
  ENDMETHOD.

  METHOD zpru_if_long_memory_provider~get_msg_persistence.
    DATA lo_long_memory TYPE REF TO zpru_if_long_memory_provider.

    lo_long_memory = NEW lcl_long_memory_provider( ).
    ro_msg_persistence = lo_long_memory->get_msg_persistence( ).
  ENDMETHOD.

  METHOD zpru_if_prompt_provider~get_prompt_language.
    DATA lo_prompt_provider TYPE REF TO zpru_if_prompt_provider.

    lo_prompt_provider = NEW lcl_prompt_provider( ).
    rv_language = lo_prompt_provider->get_prompt_language( ).
  ENDMETHOD.

  METHOD zpru_if_long_memory_provider~get_summarization.
    DATA lo_long_memory TYPE REF TO zpru_if_long_memory_provider.

    lo_long_memory = NEW lcl_long_memory_provider( ).
    ro_summarization = lo_long_memory->get_summarization( ).
  ENDMETHOD.

  METHOD zpru_if_long_memory_provider~get_sum_persistence.
    DATA lo_long_memory TYPE REF TO zpru_if_long_memory_provider.

    lo_long_memory = NEW lcl_long_memory_provider( ).
    ro_sum_persistence = lo_long_memory->get_sum_persistence( ).
  ENDMETHOD.

  METHOD zpru_if_prompt_provider~get_system_prompt.
    DATA lo_prompt_provider TYPE REF TO zpru_if_prompt_provider.

    lo_prompt_provider = NEW lcl_prompt_provider( ).
    rv_system_prompt = lo_prompt_provider->get_system_prompt( ).
  ENDMETHOD.

  METHOD zpru_if_decision_provider~prepare_final_response.
    DATA lo_decision_provider TYPE REF TO zpru_if_decision_provider.

    lo_decision_provider = NEW lcl_decision_provider( ).
    lo_decision_provider->prepare_final_response( EXPORTING iv_run_uuid       = iv_run_uuid
                                                            iv_query_uuid     = iv_query_uuid
                                                  IMPORTING eo_final_response = eo_final_response
                                                  CHANGING  cs_axc_reported   = cs_axc_reported
                                                            cs_axc_failed     = cs_axc_failed
                                                            cs_adf_reported   = cs_adf_reported
                                                            cs_adf_failed     = cs_adf_failed ).
  ENDMETHOD.

  METHOD zpru_if_long_memory_provider~retrieve_message.
    DATA lo_long_memory TYPE REF TO zpru_if_long_memory_provider.

    lo_long_memory = NEW lcl_long_memory_provider( ).
    lo_long_memory->retrieve_message( ).
  ENDMETHOD.

  METHOD zpru_if_long_memory_provider~retrieve_summary.
    DATA lo_long_memory TYPE REF TO zpru_if_long_memory_provider.

    lo_long_memory = NEW lcl_long_memory_provider( ).
    lo_long_memory->retrieve_summary( ).
  ENDMETHOD.

  METHOD zpru_if_short_memory_provider~save_message.
    DATA lo_short_memory TYPE REF TO zpru_if_short_memory_provider.

    lo_short_memory = NEW lcl_short_memory_provider( ).
    lo_short_memory->save_message( it_message = it_message ).
  ENDMETHOD.

  METHOD zpru_if_long_memory_provider~save_messages.
    DATA lo_long_memory TYPE REF TO zpru_if_long_memory_provider.

    lo_long_memory = NEW lcl_long_memory_provider( ).
    lo_long_memory->save_messages( EXPORTING io_input  = io_input
                                   IMPORTING eo_output = eo_output
                                             ev_error  = ev_error ).
  ENDMETHOD.

  METHOD zpru_if_long_memory_provider~save_summary.
    DATA lo_long_memory TYPE REF TO zpru_if_long_memory_provider.

    lo_long_memory = NEW lcl_long_memory_provider( ).
    lo_long_memory->save_summary( EXPORTING io_input  = io_input
                                  IMPORTING eo_output = eo_output
                                            ev_error  = ev_error ).
  ENDMETHOD.

  METHOD zpru_if_short_memory_provider~set_discard_strategy.
    DATA lo_short_memory TYPE REF TO zpru_if_short_memory_provider.

    lo_short_memory = NEW lcl_short_memory_provider( ).
    lo_short_memory->set_discard_strategy( io_discard_strategy = io_discard_strategy ).
  ENDMETHOD.

  METHOD zpru_if_short_memory_provider~set_long_memory.
    DATA lo_short_memory TYPE REF TO zpru_if_short_memory_provider.

    lo_short_memory = NEW lcl_short_memory_provider( ).
    lo_short_memory->set_long_memory( io_long_memory = io_long_memory ).
  ENDMETHOD.

  METHOD zpru_if_long_memory_provider~set_msg_persistence.
    DATA lo_long_memory TYPE REF TO zpru_if_long_memory_provider.

    lo_long_memory = NEW lcl_long_memory_provider( ).
    lo_long_memory->set_msg_persistence( io_msg_persistence = io_msg_persistence ).
  ENDMETHOD.

  METHOD zpru_if_long_memory_provider~set_summarization.
    DATA lo_long_memory TYPE REF TO zpru_if_long_memory_provider.

    lo_long_memory = NEW lcl_long_memory_provider( ).
    lo_long_memory->set_summarization( io_summarization = io_summarization ).
  ENDMETHOD.

  METHOD zpru_if_long_memory_provider~set_sum_persistence.
    DATA lo_long_memory TYPE REF TO zpru_if_long_memory_provider.

    lo_long_memory = NEW lcl_long_memory_provider( ).
    lo_long_memory->set_sum_persistence( io_sum_persistence = io_sum_persistence ).
  ENDMETHOD.

  METHOD zpru_if_long_memory_provider~summarize_conversation.
    DATA lo_long_memory TYPE REF TO zpru_if_long_memory_provider.

    lo_long_memory = NEW lcl_long_memory_provider( ).
    lo_long_memory->summarize_conversation( EXPORTING io_input  = io_input
                                            IMPORTING eo_output = eo_output
                                                      ev_error  = ev_error ).
  ENDMETHOD.

  METHOD zpru_if_tool_provider~get_tool.
    DATA lo_tool_provider TYPE REF TO zpru_if_tool_provider.

    lo_tool_provider = NEW lcl_tool_provider( ).
    ro_executor = lo_tool_provider->get_tool( is_tool_master_data = is_tool_master_data
                                              is_execution_step   = is_execution_step ).
  ENDMETHOD.

  METHOD zpru_if_input_schema_provider~get_input_schema.
    DATA lo_input_schema_provider TYPE REF TO zpru_if_input_schema_provider.

    lo_input_schema_provider = NEW lcl_input_schema_provider( ).
    lo_input_schema_provider->get_input_schema( ).
  ENDMETHOD.
ENDCLASS.
