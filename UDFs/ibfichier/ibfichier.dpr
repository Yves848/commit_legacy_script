library ibfichier;

{ Remarque importante concernant la gestion de m�moire de DLL : ShareMem doit
  �tre la premi�re unit� de la clause USES de votre biblioth�que ET de votre projet 
  (s�lectionnez Projet-Voir source) si votre DLL exporte des proc�dures ou des
  fonctions qui passent des cha�nes en tant que param�tres ou r�sultats de fonction.
  Cela s'applique � toutes les cha�nes pass�es de et vers votre DLL --m�me celles
  qui sont imbriqu�es dans des enregistrements et classes. ShareMem est l'unit� 
  d'interface pour le gestionnaire de m�moire partag�e BORLNDMM.DLL, qui doit
  �tre d�ploy� avec vos DLL. Pour �viter d'utiliser BORLNDMM.DLL, passez les 
  informations de cha�nes avec des param�tres PChar ou ShortString. }

{$R *.res}

uses
  mdlFonctionsFichier in 'mdlFonctionsFichier.pas';

exports
  supprimerfichier,
  fichierexistant,
  extrairechemin,
  extrairefichier,
  renvoyerdatefichier,
  creerfichiertexte,
  ouvrirfichiertexte,
  lirefichiertexte,
  ecrirefichiertexte,
  fermerfichier,
  renommerfichier;

begin

end.
