REPORT ZSHELF_AD.

DATA: it_books TYPE TABLE OF zbooks.

SELECT * FROM zbooks INTO TABLE it_books.

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
  EXPORTING
    i_structure_name = 'ZBOOKS'
  TABLES
    t_outtab        = it_books.
