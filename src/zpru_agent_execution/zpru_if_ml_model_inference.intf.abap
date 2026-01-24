INTERFACE zpru_if_ml_model_inference
  PUBLIC .

  METHODS get_machine_learning_inference
    IMPORTING
      io_controller            TYPE REF TO zpru_if_agent_controller
      io_request               TYPE REF TO zpru_if_payload
      is_tool_master_data        TYPE zpru_if_adf_type_and_constant=>ts_agent_tool OPTIONAL
      is_execution_step          TYPE zpru_if_axc_type_and_constant=>ts_axc_step OPTIONAL
    EXPORTING
      eo_response              TYPE REF TO zpru_if_payload
      ev_error_flag            TYPE abap_boolean.

ENDINTERFACE.
