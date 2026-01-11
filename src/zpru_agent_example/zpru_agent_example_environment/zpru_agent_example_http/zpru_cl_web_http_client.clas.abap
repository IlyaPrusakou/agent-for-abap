CLASS zpru_cl_web_http_client DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_web_http_client .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zpru_cl_web_http_client IMPLEMENTATION.


  METHOD if_web_http_client~accept_cookies.
  ENDMETHOD.


  METHOD if_web_http_client~close.
  ENDMETHOD.


  METHOD if_web_http_client~enable_path_prefix.
  ENDMETHOD.


  METHOD if_web_http_client~execute.
  ENDMETHOD.


  METHOD if_web_http_client~get_distributed_tracing_status.
  ENDMETHOD.


  METHOD if_web_http_client~get_form_field_policy.
  ENDMETHOD.


  METHOD if_web_http_client~get_http_request.
  ENDMETHOD.


  METHOD if_web_http_client~get_logon_popup_policy.
  ENDMETHOD.


  METHOD if_web_http_client~get_redirect_policy.
  ENDMETHOD.


  METHOD if_web_http_client~retry_execute.
  ENDMETHOD.


  METHOD if_web_http_client~set_authn_mode.
  ENDMETHOD.


  METHOD if_web_http_client~set_csrf_token.
  ENDMETHOD.


  METHOD if_web_http_client~set_distributed_tracing_status.
  ENDMETHOD.


  METHOD if_web_http_client~set_form_field_policy.
  ENDMETHOD.


  METHOD if_web_http_client~set_logon_popup_policy.
  ENDMETHOD.


  METHOD if_web_http_client~set_redirect_policy.
  ENDMETHOD.
ENDCLASS.
