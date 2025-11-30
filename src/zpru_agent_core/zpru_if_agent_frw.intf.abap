INTERFACE zpru_if_agent_frw
  PUBLIC.

  CONSTANTS: BEGIN OF  cs_execution_status,
               new       TYPE c LENGTH 1 VALUE space,
               running   TYPE c LENGTH 1 VALUE `R`,
               completed TYPE c LENGTH 1 VALUE `C`,
             END OF cs_execution_status.

  CONSTANTS:
    BEGIN OF  cs_fail_cause,
      unspecific   TYPE i VALUE 0,
      unauthorized TYPE i VALUE 401,
      not_found    TYPE i VALUE 404,
      conflict     TYPE i VALUE 409,
      locked       TYPE i VALUE 423,
      dependency   TYPE i VALUE 424,
      disabled     TYPE i VALUE 4221,
      readonly     TYPE i VALUE 4222,
    END OF  cs_fail_cause.

  CONSTANTS: BEGIN OF cs_message_class,
               zpru_msg_execution TYPE symsgid VALUE `ZPRU_MSG_EXECUTION`,
             END OF cs_message_class.

  TYPES ts_json       TYPE string.
  TYPES tt_agent_tool TYPE STANDARD TABLE OF zpru_agent_tool WITH EMPTY KEY.

ENDINTERFACE.
