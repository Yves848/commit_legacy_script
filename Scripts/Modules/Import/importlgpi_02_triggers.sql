set sql dialect 3;

/* ********************************************************************************************** */
create or alter trigger trg_importlgpi_produit for t_produit
active before insert or update
position 11
as
begin
  if (new.etat = '0') then new.etat = '1';
  if (new.service_tips = '') then new.service_tips = null;
end;

/* ********************************************************************************************** */
alter trigger trg_cmd_creation_catalogue inactive;
alter trigger trg_cmdlig_creation_lig_cat inactive;

/* ********************************************************************************************** */
create or alter trigger trg_importlgpi_produit_lpp for t_produit_lpp
active before insert or update
position 11
as
begin
  if (new.service_tips = '0') then
    if (new.type_code = '1') then
      new.service_tips = 'S';
    else
      new.service_tips = null;
end;