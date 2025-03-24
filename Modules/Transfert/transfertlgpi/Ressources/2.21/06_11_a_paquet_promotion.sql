create or replace package migration.pk_promotions as

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
                          return integer;
       
  /* ********************************************************************************************** */
  procedure creer_promotion_avantage(AIDPromotion in integer,
  																	 AAPartirDe in number,
  																	 ATypeAvantagePromo in number,
                                     AValAvantage in number,
                                     ANbOffert in number,
                                     AAvecArrondi in char );       
                          
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
                                   	ALotRemise in number);                                    
end;
/                                   
