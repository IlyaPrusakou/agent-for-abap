INTERFACE zpru_if_mmsg_crud
  PUBLIC .

  INTERFACES zpru_if_agent_frw .

  TYPES: BEGIN OF ts_mmsg_control,
           message_uuid TYPE abap_boolean,
           content      TYPE abap_boolean,
           message_type TYPE abap_boolean,
           message_cid  TYPE abap_boolean,
           stage        TYPE abap_boolean,
           sub_stage    TYPE abap_boolean,
           namespace    TYPE abap_boolean,
           user_name    TYPE abap_boolean,
           agent_uuid   TYPE abap_boolean,
           run_uuid     TYPE abap_boolean,
           query_uuid   TYPE abap_boolean,
           step_uuid    TYPE abap_boolean,
           message_time TYPE abap_boolean,
           created_by   TYPE abap_boolean,
           created_at   TYPE abap_boolean,
           changed_by   TYPE abap_boolean,
           changed_at   TYPE abap_boolean,
         END OF ts_mmsg_control.

  TYPES: BEGIN OF ts_mmsg_k,
           message_uuid TYPE sysuuid_x16,
         END OF ts_mmsg_k.

  TYPES tt_mmsg_k TYPE STANDARD TABLE OF ts_mmsg_k WITH EMPTY KEY.

  TYPES ts_mmsg        TYPE zpru_mem_msg.
  TYPES tt_mmsg        TYPE STANDARD TABLE OF ts_mmsg WITH EMPTY KEY.

  TYPES: BEGIN OF ts_mmsg_create_imp.
           INCLUDE TYPE zpru_mem_msg.
  TYPES:   control TYPE ts_mmsg_control.
  TYPES: END OF ts_mmsg_create_imp.

  TYPES tt_mmsg_create_imp TYPE STANDARD TABLE OF ts_mmsg_create_imp WITH EMPTY KEY.

  TYPES: BEGIN OF ts_mmsg_update_imp.
           INCLUDE TYPE zpru_mem_msg.
  TYPES:   control TYPE ts_mmsg_control.
  TYPES: END OF ts_mmsg_update_imp.

  TYPES tt_mmsg_update_imp TYPE STANDARD TABLE OF ts_mmsg_update_imp WITH EMPTY KEY.

  TYPES: BEGIN OF ts_mmsg_read_k,
           message_uuid TYPE sysuuid_x16,
           control      TYPE ts_mmsg_control,
         END OF ts_mmsg_read_k.

  TYPES tt_mmsg_read_k TYPE STANDARD TABLE OF ts_mmsg_read_k WITH EMPTY KEY.

  TYPES: BEGIN OF ts_mmsg_delete_imp,
           message_uuid TYPE sysuuid_x16,
         END OF ts_mmsg_delete_imp.

  TYPES tt_mmsg_delete_imp TYPE STANDARD TABLE OF ts_mmsg_delete_imp WITH EMPTY KEY.

ENDINTERFACE.
