REPORT zcrm_abap_odev8_ad.

TABLES: crmd_orderadm_h, tj30t.
PARAMETERS: p_objid TYPE crmt_object_id_db OBLIGATORY,
            p_stat TYPE j_estat OBLIGATORY.

* F4 fırsatalr
AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_stat.
  TYPES: BEGIN OF ty_stat,
           estat TYPE j_estat,
           txt30 TYPE tj30t-txt30,
         END OF ty_stat.
  DATA: lt_statlist TYPE TABLE OF ty_stat.
  SELECT estat txt30 FROM tj30t
    INTO TABLE lt_statlist
    WHERE spras = 'TR'
      AND stsma = 'CRMOPPOR'.
  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
    EXPORTING
      retfield        = 'ESTAT'
      dynpprog        = sy-repid
      dynpnr          = sy-dynnr
      dynprofield     = 'P_STAT'
      value_org       = 'S'
    TABLES
      value_tab       = lt_statlist.

START-OF-SELECTION.

* GUID bulma
  DATA: lv_guid TYPE crmt_object_guid.
  SELECT SINGLE guid FROM crmd_orderadm_h INTO lv_guid WHERE object_id = p_objid.

  IF sy-subrc <> 0 OR lv_guid IS INITIAL.
    MESSAGE 'Belge bulunamadı!' TYPE 'E'.
  ENDIF.

DATA: lt_status TYPE crmt_status_comt,
      ls_status TYPE LINE OF crmt_status_comt.

CLEAR: lt_status.
CLEAR: ls_status.

ls_status-ref_guid  = lv_guid.
ls_status-ref_kind  = 'A'.
ls_status-status    = p_stat.
APPEND ls_status TO lt_status.

CALL FUNCTION 'CRM_ORDER_MAINTAIN'
  EXPORTING
    it_status = lt_status
  EXCEPTIONS
    document_not_saved = 1
    OTHERS             = 2.

IF sy-subrc <> 0.
  MESSAGE 'Güncelleme yapılamadı!' TYPE 'E'.
ENDIF.

CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
  EXPORTING
    wait = 'X'.

MESSAGE 'Belge statüsü başarıyla güncellendi.' TYPE 'S'.
