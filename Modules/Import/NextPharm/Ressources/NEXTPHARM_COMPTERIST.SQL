SELECT idcomptefid,
idtitulairecompte,
soldeTot,
( select valeurtxt from Param where séction='Fidelite' and nom like 'TypeDecompteFid%lit%' ) Type_decompte,
( select valeurtxt from Param where séction='Fidelite' and nom like 'MontantComptePourD%compte' ) Montant_compte,
( select valeurtxt from Param where séction='Fidelite' and nom like 'NbrVisitePourD%compte') Nombre_visite
FROM CompteFid CF