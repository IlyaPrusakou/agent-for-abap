CLASS lcl_decision_provider DEFINITION CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES zpru_if_decision_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS lcl_decision_provider IMPLEMENTATION.

  METHOD zpru_if_decision_provider~call_decision_engine.
    RETURN.
  ENDMETHOD.

  METHOD zpru_if_decision_provider~prepare_final_response.
    RETURN.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_short_memory_provider DEFINITION
 INHERITING FROM zpru_cl_short_memory_base
  CREATE PUBLIC.
  PUBLIC SECTION.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS lcl_short_memory_provider IMPLEMENTATION.

ENDCLASS.

CLASS lcl_long_memory_provider DEFINITION
 INHERITING FROM zpru_cl_long_memory_base
  CREATE PUBLIC.
  PUBLIC SECTION.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS lcl_long_memory_provider IMPLEMENTATION.

ENDCLASS.

CLASS lcl_agent_info_provider DEFINITION
  CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES zpru_if_agent_info_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS lcl_agent_info_provider IMPLEMENTATION.

  METHOD zpru_if_agent_info_provider~get_agent_info.
    RETURN.
  ENDMETHOD.

ENDCLASS.


CLASS lcl_prompt_provider DEFINITION
  CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES zpru_if_prompt_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS lcl_prompt_provider IMPLEMENTATION.

  METHOD zpru_if_prompt_provider~get_prompt_language.
    RETURN.
  ENDMETHOD.

  METHOD zpru_if_prompt_provider~get_system_prompt.
    RETURN.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_input_schema_provider DEFINITION
  CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES zpru_if_input_schema_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS lcl_input_schema_provider IMPLEMENTATION.

  METHOD zpru_if_input_schema_provider~get_input_schema.
    RETURN.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_tool_provider DEFINITION
  CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES zpru_if_tool_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS lcl_simple_tool DEFINITION
  CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES zpru_if_tool_executor.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS lcl_simple_tool IMPLEMENTATION.

  METHOD zpru_if_tool_executor~execute_tool.

  ENDMETHOD.

  METHOD zpru_if_tool_executor~lookup_knowledge.
    RETURN.
  ENDMETHOD.

  METHOD zpru_if_tool_executor~run_nested_agent.
    RETURN.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_knowledge DEFINITION
  CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES zpru_if_tool_executor.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS lcl_knowledge IMPLEMENTATION.

  METHOD zpru_if_tool_executor~execute_tool.
    RETURN.
  ENDMETHOD.

  METHOD zpru_if_tool_executor~lookup_knowledge.

  ENDMETHOD.

  METHOD zpru_if_tool_executor~run_nested_agent.
    RETURN.
  ENDMETHOD.

ENDCLASS.


CLASS lcl_nested_agent DEFINITION
  CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES zpru_if_tool_executor.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS lcl_nested_agent IMPLEMENTATION.

  METHOD zpru_if_tool_executor~execute_tool.
    RETURN.
  ENDMETHOD.

  METHOD zpru_if_tool_executor~lookup_knowledge.
    RETURN.
  ENDMETHOD.

  METHOD zpru_if_tool_executor~run_nested_agent.

  ENDMETHOD.

ENDCLASS.

CLASS lcl_tool_provider IMPLEMENTATION.


  METHOD zpru_if_tool_provider~get_tool.
    CASE is_tool_master_data-tool_name.
      WHEN 'SIMPLE_TOOL'.
        ro_executor = NEW lcl_simple_tool( ).
      WHEN 'KNOWLEDGE'.
        ro_executor = NEW lcl_knowledge( ).
      WHEN 'NESTED_AGENT'.
        ro_executor = NEW lcl_nested_agent( ).
      WHEN OTHERS.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.
