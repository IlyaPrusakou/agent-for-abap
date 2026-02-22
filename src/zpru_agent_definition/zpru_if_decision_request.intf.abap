INTERFACE zpru_if_decision_request
  PUBLIC .

  INTERFACES zpru_if_agent_frw.
  INTERFACES zpru_if_payload.

  METHODS get_decision_request_string
    RETURNING VALUE(rv_decision_request) TYPE string.


ENDINTERFACE.
