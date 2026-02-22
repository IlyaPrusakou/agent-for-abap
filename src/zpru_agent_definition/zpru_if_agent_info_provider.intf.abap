INTERFACE zpru_if_agent_info_provider
  PUBLIC .


  METHODS get_agent_info
    RETURNING VALUE(rv_agent_info) TYPE zpru_if_agent_frw=>ts_json.

  METHODS get_abap_agent_info
    RETURNING VALUE(rs_agent_info) TYPE zpru_s_agent_info.

ENDINTERFACE.
