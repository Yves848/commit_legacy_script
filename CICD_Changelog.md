## 2024-06-23 
### Versionning des exe / bpl au build
  A partir de la branche *REPF-3205-creer-les-.res-au-build-ci-cd*, les .res sont automatiquement générés sur base d'un parsing des .dproj.
  Les informations de version sont extraites du .dproj pour construire un .RC qui sera compilé à la volée par brcc32.
  
  **Avantages** : 
  - Ce n'est plus l'ide de Delphi qui gère les incréments lors des builds.
  - On risque moins de régression lors d'un merge
  - Il n'y a plus de message d'erreur lors du chargement d'un projet ".res manquant" dans Delphi
  - On peut à présent considérer un vrai versionning.

  **Inconvévients** :
  - Modification **manuelle** des .dproj pour assurer le bon suivi des versions.
  
### Refactoring du passage d'arguments
  La définition des variables d'environnement a été simplifiée (suppression de la duplication du code)
  En build local, sans surcharger le paramètre SVN, le build se fera dans le répertoire courant.
  Si on surcharge le paramètre SVN, le build se fera dans le répertoire passé à cette variable (comme ça se passe sur le Jenkins Slave)

### Passage de tous les modules en 4.8
  Modification de tous les .dproj pour qu'ils soient iso en versions Majeure/Mineure avec la 4.8

### Modification de .gitignore
  Changement des règles dans .gitignore pour ne plus qu'AUCUN .RC, .RES ou .DCU ne soit tracké.
  Nettement plus propre et convivial pour les commits sur BitBucket.
  Un script de "untracking" a dû être généré pour enlever les fichiers déjà enregistrés (untrack.ps1)

# TODO
  Enlever "incrémentation de version automatique lors du build" dans tous les projets