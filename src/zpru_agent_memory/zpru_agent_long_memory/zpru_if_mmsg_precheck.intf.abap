INTERFACE zpru_if_mmsg_precheck
  PUBLIC .

  INTERFACES zpru_if_agent_frw .

  METHODS precheck_create_mmsg
    IMPORTING it_mmsg_create_imp TYPE zpru_if_mmsg_crud=>tt_mmsg_create_imp
    EXPORTING et_entities        TYPE zpru_if_mmsg_crud=>tt_mmsg_create_imp
    CHANGING  cs_reported        TYPE zpru_if_agent_frw=>ts_mmsg_bndl_reported
              cs_failed          TYPE zpru_if_agent_frw=>ts_mmsg_bndl_failed.

  METHODS precheck_update_mmsg
    IMPORTING it_mmsg_update_imp TYPE zpru_if_mmsg_crud=>tt_mmsg_update_imp
    EXPORTING et_entities        TYPE zpru_if_mmsg_crud=>tt_mmsg_update_imp
    CHANGING  cs_reported        TYPE zpru_if_agent_frw=>ts_mmsg_bndl_reported
              cs_failed          TYPE zpru_if_agent_frw=>ts_mmsg_bndl_failed.

  METHODS precheck_delete_mmsg
    IMPORTING it_mmsg_delete_imp TYPE zpru_if_mmsg_crud=>tt_mmsg_delete_imp
    EXPORTING et_entities        TYPE zpru_if_mmsg_crud=>tt_mmsg_delete_imp
    CHANGING  cs_reported        TYPE zpru_if_agent_frw=>ts_mmsg_bndl_reported
              cs_failed          TYPE zpru_if_agent_frw=>ts_mmsg_bndl_failed.

  METHODS precheck_read_mmsg
    IMPORTING it_mmsg_read_k    TYPE zpru_if_mmsg_crud=>tt_mmsg_read_k
    EXPORTING et_entities       TYPE zpru_if_mmsg_crud=>tt_mmsg_read_k
    CHANGING  cs_reported       TYPE zpru_if_agent_frw=>ts_mmsg_bndl_reported
              cs_failed         TYPE zpru_if_agent_frw=>ts_mmsg_bndl_failed.

ENDINTERFACE.
