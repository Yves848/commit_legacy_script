select *
from (select p.prd_primkey,
             p.prd_cnk, 
             p.prd_publieksprijs, 
             p.prd_minvoorraad, 
             p.prd_maxvoorraad,
             (select count(*)
              from dbo.productstock s
                left join dbo.lokatie l on l.lok_primkey = s.pst_lok_primkey
              where s.pst_prd_primkey = p.prd_primkey
                and s.pst_tebestellen = 0
                and s.pst_inbestelling = 0
                and s.pst_inuse = 0
                and s.pst_verkocht = 0
                and l.lok_type = 0) -
             (select count(*)
              from dbo.productstock
              where pst_prd_primkey = p.prd_primkey
                and (pst_tebestellen = 1 or pst_inbestelling = 1)
                and pst_verkocht = 1) as prd_stock,
             (select count(*)
              from dbo.productstock s
              inner join dbo.lokatie l on l.lok_primkey = s.pst_lok_primkey
              where s.pst_prd_primkey = p.prd_primkey
                and s.pst_tebestellen = 0
                and s.pst_inbestelling = 0
                and s.pst_inuse = 0
                and s.pst_verkocht = 0
                and l.lok_type = 2) as stk_robot, 
             pn1.pnm_naam as nom_nl, 
             pn2.pnm_naam as nom_fr, 
             pak.prd_aankoopprijs, 
             p.prd_lok_primkey as zonegeo_cle, 
             p.prd_vervaldatum,
             (select max(s.pst_datumverval)
              from dbo.productstock s
              where s.pst_prd_primkey = p.prd_primkey) date_1
        from dbo.product as p
        left join dbo.productnaam as pn1 on pn1.pnm_prd_primkey = p.prd_primkey
                                            and pn1.pnm_hoofdbenaming = 1
                                            and pn1.pnm_nederlands=1
        left join dbo.productnaam as pn2 on pn2.pnm_prd_primkey = p.prd_primkey
                                            and pn2.pnm_hoofdbenaming = 1
                                            and pn2.pnm_frans=1
        left join dbo.vproductakprijs as pak on pak.prd_pk = p.prd_primkey) p

where stk_robot > 0
  or prd_stock > 0
  or prd_primkey in (select distinct pst_prd_primkey
                     from dbo.productstock
                     where pst_datumverkocht > getdate()-365*3)