FUNCTION ZORDER_READ_WS.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     VALUE(IV_OBJECT_ID) TYPE  CRMT_OBJECT_ID_DB
*"  EXPORTING
*"     VALUE(EV_STATUS) TYPE  J_ESTAT
*"     VALUE(EV_PARTNER_NO) TYPE  CRMT_PARTNER_NO
*"----------------------------------------------------------------------

  DATA: lv_guid TYPE crmt_object_guid,
        lt_header_guid TYPE crmt_object_guid_tab,
        ls_header_guid TYPE LINE OF crmt_object_guid_tab,
        lt_status TYPE crmt_status_wrkt,
        ls_status TYPE LINE OF crmt_status_wrkt,
        lt_partner TYPE crmt_partner_external_wrkt,
        ls_partner TYPE LINE OF crmt_partner_external_wrkt.

  CLEAR: ev_status, ev_partner_no.

  SELECT SINGLE guid
    FROM crmd_orderadm_h
    INTO lv_guid
    WHERE object_id = iv_object_id.

  IF sy-subrc <> 0 OR lv_guid IS INITIAL.
    MESSAGE 'Belge bulunamadı!' TYPE 'E'.
    RETURN.
  ENDIF.

  ls_header_guid = lv_guid.
  APPEND ls_header_guid TO lt_header_guid.

  CALL FUNCTION 'CRM_ORDER_READ'
    EXPORTING
      it_header_guid = lt_header_guid
    IMPORTING
      et_status      = lt_status
      et_partner     = lt_partner
    EXCEPTIONS
      document_not_found = 1
      error_occurred     = 2
      document_locked    = 3
      no_change_authority = 4
      no_display_authority = 5
      no_change_allowed   = 6
      OTHERS              = 7.

  IF sy-subrc <> 0.
    MESSAGE 'Belge okunamadı!' TYPE 'E'.
    RETURN.
  ENDIF.

* Statü çekme
  READ TABLE lt_status INTO ls_status INDEX 1.
  IF sy-subrc = 0.
    ev_status = ls_status-status.
  ENDIF.

* Partner info
  LOOP AT lt_partner INTO ls_partner.
    IF ls_partner-partner_fct = '00000001' OR
       ls_partner-partner_fct = 'ISX00001' OR
       ls_partner-partner_fct = 'ISX00002'.
      ev_partner_no = ls_partner-partner_no.
      EXIT.
    ENDIF.
  ENDLOOP.

ENDFUNCTION.
