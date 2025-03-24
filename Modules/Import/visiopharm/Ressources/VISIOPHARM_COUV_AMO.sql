select
distinct
cli.pointeur_caiss_primaire,
cli.typerembt,
coalesce( rbt.libelle , '' )||':'||coalesce( rbt.libellecas , '' ),
cli.ald,
cli.justificationexoneration,
rbt.bleue,
rbt.blanche,
rbt.blanchex,
rbt.orange


from client cli
left join coderemb rbt on rbt.intitul = cli.typerembt
where  cli.pointeur_caiss_primaire > 0