REPORT ZINTERN_CONTROLLER_AD.

TABLES zstajyer.

PARAMETERS:
  p_numara TYPE zstajyer-numara,
  p_ad     TYPE zstajyer-ad,
  p_soyad  TYPE zstajyer-soyadd,
  p_bolum  TYPE zstajyer-bolum,
  p_islem  TYPE c LENGTH 1.

DATA: ls_stajyer TYPE zstajyer,
      lt_stajyer TYPE TABLE OF zstajyer.

START-OF-SELECTION.

CASE p_islem.
  WHEN 'I'.
    ls_stajyer-numara = p_numara.
    ls_stajyer-ad     = p_ad.
    ls_stajyer-soyadd = p_soyad.
    ls_stajyer-bolum  = p_bolum.

    INSERT zstajyer FROM ls_stajyer.
    IF sy-subrc = 0.
      WRITE 'Kayıt başarıyla eklendi.'.
    ELSE.
      WRITE 'Ekleme hatası, numara zaten var olabilir.'.
    ENDIF.

  WHEN 'M'.
    SELECT SINGLE * FROM zstajyer INTO ls_stajyer WHERE numara = p_numara.
    IF sy-subrc = 0.
      ls_stajyer-ad     = p_ad.
      ls_stajyer-soyadd = p_soyad.
      ls_stajyer-bolum  = p_bolum.

      MODIFY zstajyer FROM ls_stajyer.
      IF sy-subrc = 0.
        WRITE 'Kayıt başarıyla güncellendi.'.
      ELSE.
        WRITE 'Güncelleme hatası.'.
      ENDIF.
    ELSE.
      WRITE 'Kayıt bulunamadı.'.
    ENDIF.

  WHEN 'D'.
    DELETE FROM zstajyer WHERE numara = p_numara.
    IF sy-subrc = 0.
      WRITE 'Kayıt başarıyla silindi.'.
    ELSE.
      WRITE 'Silme hatası veya kayıt bulunamadı.'.
    ENDIF.

  WHEN 'L'.
    SELECT * FROM zstajyer INTO TABLE lt_stajyer.
    IF lt_stajyer IS INITIAL.
      WRITE 'Tabloda kayıt yok.'.
    ELSE.
      LOOP AT lt_stajyer INTO ls_stajyer.
        WRITE: / ls_stajyer-numara, ls_stajyer-ad, ls_stajyer-soyadd, ls_stajyer-bolum.
      ENDLOOP.
    ENDIF.

  WHEN OTHERS.
    WRITE 'Lütfen geçerli işlem seçin: I (Insert), M (Modify), D (Delete), L (List)'.
ENDCASE.
