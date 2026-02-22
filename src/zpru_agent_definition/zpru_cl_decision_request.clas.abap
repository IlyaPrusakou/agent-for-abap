CLASS zpru_cl_decision_request DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zpru_if_payload .
    INTERFACES zpru_if_agent_frw .
    INTERFACES zpru_if_decision_request .
  PROTECTED SECTION.

    DATA ms_decision_request TYPE REF TO zpru_s_decision_request.

  PRIVATE SECTION.
ENDCLASS.



CLASS zpru_cl_decision_request IMPLEMENTATION.


  METHOD zpru_if_decision_request~get_decision_request_string.
    DATA lv_string TYPE string.

    DATA(ls_request) = ms_decision_request->*.

    " agent metadata
    IF ls_request-agentmetadata IS NOT INITIAL.
      lv_string = lv_string && `Agent Metadata:` && cl_abap_char_utilities=>newline.

      IF ls_request-agentmetadata-agentname IS NOT INITIAL.
        lv_string = lv_string && |Agent Name: { ls_request-agentmetadata-agentname }| && cl_abap_char_utilities=>newline.
      ENDIF.

      IF  ls_request-agentmetadata-agentversion IS NOT INITIAL.
        lv_string = lv_string && |Agent Version: { ls_request-agentmetadata-agentversion }| && cl_abap_char_utilities=>newline.
      ENDIF.

      IF ls_request-agentmetadata-agentrole IS NOT INITIAL.
        lv_string = lv_string && |Agent Role: { ls_request-agentmetadata-agentrole }| && cl_abap_char_utilities=>newline.
      ENDIF.

      DATA(lv_goal_count) = 0.
      LOOP AT ls_request-agentmetadata-agentgoals ASSIGNING FIELD-SYMBOL(<ls_agent_goal>).

        IF <ls_agent_goal>-agentgoalid IS INITIAL OR
           <ls_agent_goal>-agentgoaldescription IS INITIAL OR
           <ls_agent_goal>-agentgoalcontent IS INITIAL.
          CONTINUE.
        ENDIF.

        IF lv_goal_count = 0.
          lv_string = lv_string && |Agent Goals: | && cl_abap_char_utilities=>newline.
        ENDIF.

        lv_string = lv_string && |Agent Goal ID: { <ls_agent_goal>-agentgoalid }| && cl_abap_char_utilities=>newline.
        lv_string = lv_string && |Agent Goal Description: { <ls_agent_goal>-agentgoaldescription }| && cl_abap_char_utilities=>newline.
        lv_string = lv_string && |Agent Goal: { <ls_agent_goal>-agentgoalcontent }| && cl_abap_char_utilities=>newline.

        IF <ls_agent_goal>-agentgoalpriority IS NOT INITIAL.
          lv_string = lv_string && |Agent Goal Priority: { <ls_agent_goal>-agentgoalpriority }| && cl_abap_char_utilities=>newline.
        ENDIF.
        IF <ls_agent_goal>-agentgoalsuccesscriteria IS NOT INITIAL.
          lv_string = lv_string && |Agent Success Criteria: { <ls_agent_goal>-agentgoalsuccesscriteria }| && cl_abap_char_utilities=>newline.
        ENDIF.

        lv_goal_count = lv_goal_count + 1.
      ENDLOOP.

      IF ls_request-agentmetadata-agentdomain IS NOT INITIAL.
        lv_string = lv_string && |Agent Domain: | && cl_abap_char_utilities=>newline.

        IF ls_request-agentmetadata-agentdomain-agentdomainname IS NOT INITIAL.
          lv_string = lv_string && |Agent Main Domain: { ls_request-agentmetadata-agentdomain-agentdomainname }| && cl_abap_char_utilities=>newline.
        ENDIF.

        IF ls_request-agentmetadata-agentdomain-agentdomaincontent IS NOT INITIAL.
          lv_string = lv_string && |Agent Main Domain Description: { ls_request-agentmetadata-agentdomain-agentdomaincontent }| && cl_abap_char_utilities=>newline.
        ENDIF.

        DATA(lv_subdomain_count) = 0.
        LOOP AT ls_request-agentmetadata-agentdomain-agentsubdomains ASSIGNING FIELD-SYMBOL(<ls_agent_subdomain>).

          IF <ls_agent_subdomain>-agentsubdomainname IS INITIAL OR
             <ls_agent_subdomain>-agentsubdomaincontent    IS INITIAL.
            CONTINUE.
          ENDIF.

          IF lv_subdomain_count = 0.
            lv_string = lv_string && |Agent Subdomains: | && cl_abap_char_utilities=>newline.
          ENDIF.

          lv_string = lv_string && |Agent Subdomain Name: { <ls_agent_subdomain>-agentsubdomainname }| && cl_abap_char_utilities=>newline.
          lv_string = lv_string && |Agent Subdomain Description: { <ls_agent_subdomain>-agentsubdomaincontent }| && cl_abap_char_utilities=>newline.

          lv_subdomain_count = lv_subdomain_count + 1.
        ENDLOOP.
      ENDIF.

      DATA(lv_agent_restrict_count) = 0.
      LOOP AT ls_request-agentmetadata-agentrestrictions ASSIGNING FIELD-SYMBOL(<ls_agentrestriction>).

        IF <ls_agentrestriction>-agentrestrictionname IS INITIAL OR
           <ls_agentrestriction>-agentrestriction    IS INITIAL.
          CONTINUE.
        ENDIF.

        IF lv_agent_restrict_count = 0.
          lv_string = lv_string && |Agent Restrictions: | && cl_abap_char_utilities=>newline.
        ENDIF.

        lv_string = lv_string && |Agent Restriction Name: { <ls_agentrestriction>-agentrestrictionname }| && cl_abap_char_utilities=>newline.
        lv_string = lv_string && |Agent Restriction Rule: { <ls_agentrestriction>-agentrestriction }| && cl_abap_char_utilities=>newline.

        lv_subdomain_count = lv_subdomain_count + 1.
      ENDLOOP.
    ENDIF.


    " agent system prompt
    IF ls_request-systemprompt IS NOT INITIAL.
      lv_string = lv_string && `System Prompt:` && cl_abap_char_utilities=>newline.

      IF ls_request-systemprompt-primarysessiontask IS NOT INITIAL.
        lv_string = lv_string && |Primary Session Task: { ls_request-systemprompt-primarysessiontask }| && cl_abap_char_utilities=>newline.
      ENDIF.

      DATA(lv_tech_rule_count) = 0.
      LOOP AT ls_request-systemprompt-technicalrules ASSIGNING FIELD-SYMBOL(<ls_technicalrules>).

        IF <ls_technicalrules>-technicalrulesname IS INITIAL OR
           <ls_technicalrules>-technicalrule    IS INITIAL.
          CONTINUE.
        ENDIF.

        IF lv_tech_rule_count = 0.
          lv_string = lv_string && |Technical Rules: | && cl_abap_char_utilities=>newline.
        ENDIF.

        lv_string = lv_string && |Technical Rule Name: { <ls_technicalrules>-technicalrulesname }| && cl_abap_char_utilities=>newline.
        lv_string = lv_string && |Technical Rule: { <ls_technicalrules>-technicalrule }| && cl_abap_char_utilities=>newline.

        lv_tech_rule_count = lv_tech_rule_count + 1.
      ENDLOOP.

      DATA(lv_bus_rule_count) = 0.
      LOOP AT ls_request-systemprompt-businessrules ASSIGNING FIELD-SYMBOL(<ls_businessrules>).

        IF <ls_businessrules>-businessrulesname IS INITIAL OR
           <ls_businessrules>-businessrule    IS INITIAL.
          CONTINUE.
        ENDIF.

        IF lv_bus_rule_count = 0.
          lv_string = lv_string && |Business Rules: | && cl_abap_char_utilities=>newline.
        ENDIF.

        lv_string = lv_string && |Business Rule Name: { <ls_businessrules>-businessrulesname }| && cl_abap_char_utilities=>newline.
        lv_string = lv_string && |Business Rule: { <ls_businessrules>-businessrule }| && cl_abap_char_utilities=>newline.

        lv_bus_rule_count = lv_bus_rule_count + 1.
      ENDLOOP.

      """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
      DATA(lv_format_count) = 0.
      LOOP AT ls_request-systemprompt-formatguidelines ASSIGNING FIELD-SYMBOL(<ls_formatguidelines>).

        IF <ls_formatguidelines>-formatguidelinename IS INITIAL OR
           <ls_formatguidelines>-formatguideline    IS INITIAL.
          CONTINUE.
        ENDIF.

        IF lv_format_count = 0.
          lv_string = lv_string && |Format Guidlines: | && cl_abap_char_utilities=>newline.
        ENDIF.

        lv_string = lv_string && |Format Guidline Name: { <ls_formatguidelines>-formatguidelinename }| && cl_abap_char_utilities=>newline.
        lv_string = lv_string && |Format Guidline Instruction: { <ls_formatguidelines>-formatguideline }| && cl_abap_char_utilities=>newline.

        lv_format_count = lv_format_count + 1.
      ENDLOOP.




    ENDIF.












  ENDMETHOD.


  METHOD zpru_if_payload~clear_data.
    CLEAR: ms_decision_request.
  ENDMETHOD.


  METHOD zpru_if_payload~get_data.
    rr_data = ms_decision_request.
  ENDMETHOD.

  METHOD zpru_if_payload~set_data.
    CREATE DATA ms_decision_request.
    ASSIGN ms_decision_request->* TO FIELD-SYMBOL(<ls_data>).
    <ls_data> = ir_data->*.
  ENDMETHOD.
ENDCLASS.
