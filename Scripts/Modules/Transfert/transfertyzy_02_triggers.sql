set sql dialect 3;

/* ********************************************************************************************** */
create trigger tr_transfert_trait_sequence for t_transfert_traitement
active before insert
position 0
as
begin
  if (new.t_transfert_traitement_id is null) then
    new.t_transfert_traitement_id = next value for seq_transfert_traitement;
end;