set sql dialect 3;

/******************************************************************************/
declare external function f_cle_ss -- dans outils mdlincohérence
  cstring(13)
returns
  integer by value
entry_point 'cless' module_name 'ibpha';

/******************************************************************************/
declare external function f_cle_cip -- dans outils mdlincohérence
  cstring(13)
returns
  integer by value
entry_point 'clecip' module_name 'ibpha';

commit;
