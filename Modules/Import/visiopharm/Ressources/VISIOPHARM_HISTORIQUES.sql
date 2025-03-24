select
distinct
iif(his.no_aydrt = 0 , his.nmalade, his.no_aydrt ),
his.dateordonnance,
his.datefacture,
his.nfacture,
his.no_prescripteur


from ordohist his