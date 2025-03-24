set sql dialect 3;

create or alter exception exp_suppression_non_supportee '';
create or alter exception exp_erreur_fichier_inexistant '';
create or alter exception exp_taux_prestation_inconnue '';
create or alter exception exp_cnv_couv_amo_taux_intrv '';
create or alter exception exp_cnv_couv_amc_defaut_amo '';
create or alter exception exp_cnv_couv_amc_taux_amo '';
create or alter exception exp_doc_entite_inconnue '';
create or alter exception exp_com_entite_inconnue '';