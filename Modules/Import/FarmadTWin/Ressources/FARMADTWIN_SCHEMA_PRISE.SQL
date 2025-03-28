SELECT 
  DET.MSD_ID,
  MOMENT.MSIM_WEEKDAG AS JOUR_SEMAINE,
  MOMENT.MSIM_MSM_ID AS MOMENT_JOUR,
  MOMENT.MSIM_DOSERING AS DOSE,
  MOMENT.MSIM_DAG AS JOUR_FREQUENCE,
  REM.MSO_OPMERKING AS REMARQUE,
  DET.MSD_FREQUENTIE_ID AS FREQUENCE
FROM
  FTBMEDICATIESCHEMA SCH
  LEFT OUTER JOIN FTBMSDETAILS DET ON (SCH.MS_ID = DET.MSD_SCHEMA_ID)
  LEFT OUTER JOIN FTBMSINNAMEMOMENTEN MOMENT ON (DET.MSD_ID = MOMENT.MSIM_MSD_ID)
  LEFT OUTER JOIN FTBMSOPMERKINGEN REM ON (DET.MSD_OPMERKING_ID = REM.MSO_ID)
where SCH.MS_KLANT_ID is not null and DET.MSD_CNKNUMMER is not null
and DET.MSD_EINDDATUM IS NULL