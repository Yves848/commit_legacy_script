select 
 d.numero,
 d.ti, 
 d.cli_ti, 
 cast(d.ben_ti as signed ),
 cast(from_unixtime(d.timeCreate) as date) tmcreate,
 d.cip,
 d.QtePromis
 from PROMIS d
 left join produit p on p.cip = d.cip
where d.Status = 0 and cast(En_stock as signed) < 0
