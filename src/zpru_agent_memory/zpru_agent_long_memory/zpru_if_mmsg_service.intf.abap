INTERFACE zpru_if_mmsg_service
  PUBLIC .

  INTERFACES zpru_if_agent_frw .

  TYPES tt_message_uuid TYPE RANGE OF sysuuid_x16.
  TYPES tt_agent_uuid   TYPE RANGE OF sysuuid_x16.
  TYPES tt_run_uuid     TYPE RANGE OF sysuuid_x16.
  TYPES tt_query_uuid   TYPE RANGE OF sysuuid_x16.
  TYPES tt_step_uuid    TYPE RANGE OF sysuuid_x16.
  TYPES tt_message_type TYPE RANGE OF zpru_de_message_type.
  TYPES tt_created_by   TYPE RANGE OF syuname.
  TYPES tt_created_at   TYPE RANGE OF timestampl.
  TYPES tt_changed_by   TYPE RANGE OF syuname.
  TYPES tt_changed_at   TYPE RANGE OF timestampl.

  METHODS query_mmsg
    IMPORTING it_message_uuid TYPE tt_message_uuid OPTIONAL
              it_agent_uuid   TYPE tt_agent_uuid   OPTIONAL
              it_run_uuid     TYPE tt_run_uuid     OPTIONAL
              it_query_uuid   TYPE tt_query_uuid   OPTIONAL
              it_step_uuid    TYPE tt_step_uuid    OPTIONAL
              it_message_type TYPE tt_message_type OPTIONAL
              it_created_by   TYPE tt_created_by   OPTIONAL
              it_created_at   TYPE tt_created_at   OPTIONAL
              it_changed_by   TYPE tt_changed_by   OPTIONAL
              it_changed_at   TYPE tt_changed_at   OPTIONAL
    EXPORTING et_mmsg_k       TYPE zpru_if_mmsg_crud=>tt_mmsg_k.

  METHODS read_mmsg
    IMPORTING it_mmsg_read_k TYPE zpru_if_mmsg_crud=>tt_mmsg_read_k
    EXPORTING et_mmsg        TYPE zpru_if_mmsg_crud=>tt_mmsg
    CHANGING  cs_reported    TYPE zpru_if_agent_frw=>ts_mmsg_bndl_reported OPTIONAL
              cs_failed      TYPE zpru_if_agent_frw=>ts_mmsg_bndl_failed   OPTIONAL.

  METHODS create_mmsg
    IMPORTING it_mmsg_create_imp TYPE zpru_if_mmsg_crud=>tt_mmsg_create_imp
    CHANGING  cs_reported        TYPE zpru_if_agent_frw=>ts_mmsg_bndl_reported OPTIONAL
              cs_failed          TYPE zpru_if_agent_frw=>ts_mmsg_bndl_failed   OPTIONAL
              cs_mapped          TYPE zpru_if_agent_frw=>ts_mmsg_bndl_mapped   OPTIONAL.

  METHODS update_mmsg
    IMPORTING it_mmsg_update_imp TYPE zpru_if_mmsg_crud=>tt_mmsg_update_imp
    CHANGING  cs_reported        TYPE zpru_if_agent_frw=>ts_mmsg_bndl_reported OPTIONAL
              cs_failed          TYPE zpru_if_agent_frw=>ts_mmsg_bndl_failed   OPTIONAL.

  METHODS delete_mmsg
    IMPORTING it_mmsg_delete_imp TYPE zpru_if_mmsg_crud=>tt_mmsg_delete_imp
    CHANGING  cs_reported        TYPE zpru_if_agent_frw=>ts_mmsg_bndl_reported OPTIONAL
              cs_failed          TYPE zpru_if_agent_frw=>ts_mmsg_bndl_failed   OPTIONAL.

  METHODS determine
    CHANGING cs_reported TYPE zpru_if_agent_frw=>ts_mmsg_bndl_reported OPTIONAL
             cs_failed   TYPE zpru_if_agent_frw=>ts_mmsg_bndl_failed   OPTIONAL
             cs_mapped   TYPE zpru_if_agent_frw=>ts_mmsg_bndl_mapped   OPTIONAL.

  METHODS validate
    IMPORTING it_check_mmsg_v TYPE zpru_if_mmsg_crud=>tt_mmsg_read_k OPTIONAL
    CHANGING  cs_reported     TYPE zpru_if_agent_frw=>ts_mmsg_bndl_reported OPTIONAL
              cs_failed       TYPE zpru_if_agent_frw=>ts_mmsg_bndl_failed   OPTIONAL.

  METHODS clean_up
    CHANGING cs_mapped TYPE zpru_if_agent_frw=>ts_mmsg_bndl_mapped OPTIONAL.

  METHODS do_save
    IMPORTING iv_do_commit TYPE abap_boolean                              DEFAULT abap_true
    CHANGING  cs_reported  TYPE zpru_if_agent_frw=>ts_mmsg_bndl_reported OPTIONAL
              cs_failed    TYPE zpru_if_agent_frw=>ts_mmsg_bndl_failed   OPTIONAL
              cs_mapped    TYPE zpru_if_agent_frw=>ts_mmsg_bndl_mapped   OPTIONAL.

ENDINTERFACE.
