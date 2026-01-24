CLASS zpru_cl_nested_agent_runner DEFINITION
  PUBLIC
INHERITING FROM zpru_cl_tool_executor ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zpru_if_nested_agent_runner .
  PROTECTED SECTION.

    METHODS run_nested_agent_int
      ABSTRACT
      IMPORTING io_controller           TYPE REF TO zpru_if_agent_controller
                io_input                TYPE REF TO data
                io_tool_schema_provider TYPE REF TO zpru_if_tool_schema_provider OPTIONAL
                io_tool_info_provider   TYPE REF TO zpru_if_tool_info_provider   OPTIONAL
      EXPORTING eo_output               TYPE REF TO data
                ev_error_flag           TYPE abap_boolean.

  PRIVATE SECTION.
ENDCLASS.



CLASS zpru_cl_nested_agent_runner IMPLEMENTATION.


  METHOD zpru_if_nested_agent_runner~run_nested_agent.

*   run_nested_agent_int(
*     EXPORTING
*       io_controller           =
*       io_input                =
**       io_tool_schema_provider =
**       io_tool_info_provider   =
**     IMPORTING
**       eo_output               =
**       ev_error_flag           =
*   ).

  ENDMETHOD.
ENDCLASS.
