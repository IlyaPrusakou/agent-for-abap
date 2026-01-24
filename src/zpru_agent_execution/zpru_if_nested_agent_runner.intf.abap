INTERFACE zpru_if_nested_agent_runner
  PUBLIC .
  METHODS run_nested_agent
    IMPORTING
      io_controller            TYPE REF TO zpru_if_agent_controller
      io_request               TYPE REF TO zpru_if_payload
      is_tool_master_data        TYPE zpru_if_adf_type_and_constant=>ts_agent_tool OPTIONAL
      is_execution_step          TYPE zpru_if_axc_type_and_constant=>ts_axc_step OPTIONAL
    EXPORTING
      eo_response              TYPE REF TO zpru_if_payload
      ev_error_flag            TYPE abap_boolean.
ENDINTERFACE.
