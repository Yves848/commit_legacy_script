;with XMLNAMESPACES(DEFAULT 'schemas.microsoft.com/winfx/2006/xaml/presentation'),

  com as (select bco.Bco_Id, bco.Bco_Commentaire, tcm.Tcm_Interne
          from dbo.BesCommentaire bco
            left join dbo.TypeCommentaire tcm on tcm.Tcm_Id = bco.Tcm_Id),
  com_v as (select * from com where Tcm_Interne = 'Vente'),
  com_g as (select * from com where Tcm_Interne = 'Gestion'),
  com_c as (select * from com where Tcm_Interne = 'Commande')
SELECT
    bes.bes_Id,
    try_convert(xml, com_v.Bco_Commentaire).value('.' , 'varchar(max)' ) AS commentaire_vente,
    try_convert(xml, com_g.Bco_Commentaire).value('.' , 'varchar(max)' ) AS commentaire_gestion,
    try_convert(xml, com_c.Bco_Commentaire).value('.' , 'varchar(max)' ) AS commentaire_commande
from
    dbo.BienEtService bes
    LEFT JOIN com_v on com_v.Bco_Id = bes.bes_id
    LEFT JOIN com_g on com_g.Bco_Id = bes.bes_id
    LEFT JOIN com_c on com_c.Bco_Id = bes.bes_id
WHERE
    com_v.Bco_Commentaire IS NOT NULL
    OR com_g.Bco_Commentaire IS NOT NULL
    OR com_c.Bco_Commentaire IS NOT NULL;