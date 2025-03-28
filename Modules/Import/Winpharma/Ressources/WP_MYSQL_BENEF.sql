SELECT
cli.cli_ti,
cli.ti,
cli.nom_prenom,
cli.nom_len,
cli.lien,
cli.code_mutu,
if(mr.CodeMRembt>0,mr.CodeMRembt, mut.Code_MutuRemb),
cli.noadhesion,
if (cli.datevalid_mutu0/100000000>1 or cli.datevalid_mutu0 =0,null,cli.datevalid_mutu0 ),
cli.datevalid_mutu,
cli.last_visit,
cli.solde,
cli.note,
date_naissance,
cli.datevalid_ss_1,
cli.code_navette_1,
cli.datevalid_ss_2,
cli.code_navette_2,
cli.datevalid_ss_3,
cli.code_navette_3,
cli.datevalid_ss_4,
cli.code_navette_4,
cli.datevalid_ss_5,
cli.code_navette_5,
cli.datevalid_ss_6,
cli.code_navette_6, 
cli.datevalid_ss_7,
cli.code_navette_7,
cli.qualite,
not ( cli.cliben_FLGS >> 8 ) gestion_unique,
if (cli.memo_ti > 0 , cli.memo_ti , null)
FROM benefic0 cli
left join mutuel mut on cli.code_mutu= mut.code
left join muturemb mr on (mr.mutu_code = cli.code_mutu and mr.timutucontrat = cli.TIMutuContrat)
