 create or replace package body migration.pk_promotions as                                                            

  /* ********************************************************************************************** */
  function creer_promotion(AIDPromotionLGPI in integer,                   
                           ALibelle in varchar2,                          
                           ADateDebut in date,                            
                           ADateFin in date,                              
                           ATypePromotion in char,                        
                           ADateCreation in date,                         
                           ACommentaire in varchar2,                      
                           AAutorisePanachageDeclencheur in char,         
                           ALotQteAffectee in number,                      
                           ALotQteVendus in number,                       
                           ALotStockAlerte in number )                    
                          return integer                                  
  as
    intIDPromotion integer;
  begin
    savepoint sp_promotions;

    if AIDPromotionLGPI is null then
      insert into erp.t_promotion_entete(t_promotion_id,
                                  			 libelle,
                                  			 date_debut,
                                     		 date_fin,
                                     		 type_promotion,
                                     		 date_creation,
                                     		 date_maj,
                                  			 commentaire,
                                  			 autorise_panachage_declencheur,
                                  			 lot_qte_affectee,
                                  			 lot_qte_vendue,
                                  			 lot_stock_alerte)
      values(erp.seq_promotion_entete.nextval,
						 ALibelle,
             ADateDebut,
             ADateFin,
             ATypePromotion,
             ADateCreation,
             sysdate,
             ACommentaire,
             AAutorisePanachageDeclencheur,
             ALotQteAffectee,
             ALotQteVendus,
             ALotStockAlerte)
      returning t_promotion_id into intIDPromotion;
    else
      intIDPromotion := AIDPromotionLGPI;
      
      update erp.t_promotion_entete
      set libelle = ALibelle,
          date_debut = ADateDebut,
          date_fin = ADateFin,
          type_promotion = ATypePromotion,
          date_creation = ADateCreation,
          date_maj = sysdate,
          commentaire = ACommentaire,
         	autorise_panachage_declencheur = AAutorisePanachageDeclencheur,
         	lot_qte_affectee = ALotQteAffectee,
         	lot_qte_vendue = ALotQteVendus,
         	lot_stock_alerte = ALotStockAlerte
       where t_promotion_id = AIDPromotionLGPI;
      
      delete from erp.t_promotion_produit where t_promotion_id = AIDPromotionLGPI;
    end if;
    
    return intIDPromotion; 
  exception
    when others then
      rollback to sp_promotions;
      raise;
  end;

  /* ********************************************************************************************** */
  procedure creer_promotion_avantage(AIDPromotion in integer,
  																	 AAPartirDe in number,
  																	 ATypeAvantagePromo in number,
                                     AValAvantage in number,
                                     ANbOffert in number,
                                     AAvecArrondi in char )       
  as
  begin
    savepoint sp_promotion_avantages;

    insert into erp.t_promotion_avantage(t_promotion_avantage_id,
    																	 t_promotion_id,	
    																	 a_partir_de,
    																	 type_avantage_promo,
    																	 val_avantage,
    																	 nb_offert,
    																	 avec_arrondi
                                       )
    values(erp.seq_promotion_avantage.nextval,
    			 AIDPromotion,	
           AAPartirDe,
					 ATypeAvantagePromo,
					 AValAvantage,
					 ANbOffert,
					 AAvecArrondi
           );
  exception
    when others then
      rollback to sp_promotion_avantages;
      raise;
  end;

  /* ********************************************************************************************** */
  procedure creer_promotion_produit(AIDProduit in integer,                
                                    AIDPromotion in integer,              
                                    ADateEntree in date,                  
                                    ADateRetrait in date,                 
                                    AQteAffectee in number,               
                                    AQteVendue in number,                 
                                    AStockAlerte in number,               
                                   	ADeclencheur in char,                 
                                   	APanier in char,                      
                                   	ALotPrixVenteHorsPromo in number,     
                                   	ALotQtePromo in number,               
                                   	ALotRemise in number)
  as
  begin
    savepoint sp_promotion_produits;

    insert into erp.t_promotion_produit(t_promotion_produit_id,
    																		t_produit_id,
    																		t_promotion_id,
    																		date_entree,
                                       	date_retrait,
                                       	qte_affectee,
                                       	qte_vendue,
                                       	stock_alerte,
                                       	declencheur,
                                       	panier,
                                       	lot_prixvente_hors_promo,
                                       	lot_qte_promo,
                                       	lot_remise,
                                       	date_maj
                                        )
    values(erp.seq_promotion_produit.nextval,
           AIDProduit,
           AIDPromotion,
           ADateEntree,  
					 ADateRetrait, 
					 AQteAffectee,
					 AQteVendue, 
					 AStockAlerte,
					 ADeclencheur, 
					 APanier,      
					 ALotPrixVenteHorsPromo,
					 ALotQtePromo,
					 ALotRemise, 
           sysdate           
           );
  exception
    when others then
      rollback to sp_promotion_produits;
      raise;
  end;

end;  
/