SELECT
  cdb.Cnk
 ,cdb.CodeBarre
FROM AutresCodesBarresSpe cdb
--  supprimé car trop long
--, Stock stk, TarSpe pdt
--WHERE pdt.cnk = stk.cnk AND pdt.cnk=cdb.cnk  AND 
--(stk.stkrayon <> 0 OR stk.stkcave <> 0 OR (stk.stkrayon = 0 AND stk.stkcave = 0 AND pdt.datedervente >=add_months(sysdate,-36)))