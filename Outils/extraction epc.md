**Patients**
===

> PH_72_PATIENTS.XLS 
```excel
=CONCATENER("execute procedure ps_epc_creer_client('";A2;"','";SUBSTITUE(B2;"'";" ");"','";SUBSTITUE(C2;"'";" ");"');")
```

**Stock**
===

> PH_72_STOCK.XLS

```excel
=CONCATENER("execute procedure ps_epc_creer_produit(";"'";SUBSTITUE(A2;".";"");"','";SUBSTITUE(A2;".";"");"','";SUBSTITUE(A2;".";"");"',";SUBSTITUE(B2;" ";"");",";SUBSTITUE(C2;" ";"");");")
```

**Procedure stockées**
---

```sql
create or alter procedure ps_epc_creer_client(
  niss varchar(11),
  nom varchar(50),
  prenom varchar(50)
)
as
begin
  if (not exists (select niss from t_client where niss=:niss)) then
  insert into t_client(
        client, 
        niss, 
        nom, 
        prenom1) values (
          substring(:niss from 1 for 11),
          substring(:niss from 1 for 11),
          substring(:nom from 1 for 30),
          substring(:prenom from 1 for 35)
        );
end;

create or alter procedure ps_epc_creer_produit(
  produit varchar(7),
  designfr varchar(50),
  designnl varchar(50),
  stock integer,
  stockideal integer
)
as
declare variable stockmini integer;
declare variable stockmaxi integer;
declare variable stockreel integer;
begin
  stockmaxi = stockideal;

  stockmini = 0;
  
  if (stock >= 0) then
    stockreel = stock;
  else
    stockreel = 0;
  

  if (not exists (select produit from t_produit where produit=:produit)) then
  begin
    insert into t_produit(
      produit,
      designcnkfr_prod,
      designcnknl_prod,
      stockmini,
      stockmaxi) values (
        :produit,
        :produit,
        :produit,
        0,
        :stockmaxi);

    insert into t_stock(
      stock,
      qteEnStk,
      stkMin,
      stkMax,
      produit,
      priorite,
      depot,
      depotvente)
    values(
      :produit,
      :stockreel,
      0,
      0,
      :produit,
      '1',
      '1',
      '1');
  end
end;
```
