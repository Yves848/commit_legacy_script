## Réponse Pharmony 10/01/2023

Bonjour Yves,

Merci pour vos bons voeux, je souhaite également mes meilleurs voeux pour cette nouvelle année.

Comme je disais à Aline, cet export ayant été fait en urgence à votre demande il n'est pas documenté (c'est un export brut de la db). Je vais alors répondre sans trop de certitude.

1. S'il n'y a pas de produit c'est qu'il faut se baser sur le code DCI (car chez nous les traitements sont basé sur la DCI).
Il ne faut pas rejeter de schéma car sinon vous aurez des trous dans les schémas repris et ça peut être critique.
Pour les traitements, le plus important c'est que les produits et les fréquences soient bons.

2. Mode d'administration
"form_admin.100": "Ampoule",
"form_admin.101": "Application",
"form_admin.102": "Cachet",
"form_admin.103": "Comprimé",
"form_admin.104": "5ml (C.à café)",
"form_admin.105": "10ml(C. à dessert)",
"form_admin.106": "15ml (C. à soupe)",
"form_admin.107": "Gélule",
"form_admin.108": "Gomme",
"form_admin.109": "Goutte",
"form_admin.110": "Inhalation",
"form_admin.111": "Injection",
"form_admin.112": "Lavage",
"form_admin.113": "Mesure",
"form_admin.114": "Ovule",
"form_admin.115": "Patch",
"form_admin.116": "Perle",
"form_admin.117": "Pilule",
"form_admin.118": "Pipette",
"form_admin.119": "Pulvérisation",
"form_admin.120": "Sachet",
"form_admin.121": "Suppositoire",


3. Fréquence
  "DOSING_FREQUENCY_TYPE": {
    "DAYS": 1,
    "EVERY_X_DAYS": 2,
    "CALENDAR": 3,
    "NEEDED": 4,
    "EVERY_DAYS": 5,
    "MONTH_DAYS": 6,
    "SCHEME_X_DAYS": 7
  },

4. Les moments de prises correspondent et il y a bien uniquement whole ou w pour 1, half ou h pour 1/2 et quarter ou q pour 1/4


## liste des modes d'administration SU
Comprimés = 1
Cuillères à café = 2
Cuillères à soupe = 3
Gélule = 4
Goutte = 5
Injections = 6
Pulvérisation = 7
Suppositoires = 8
Sachet = 9
Ampoule = 10
Application = 11
Cuillères ou godets mesure = 12
Ampoule = 13 (Oui, encore 'ampoule', mais je ne sais pas pourquoi, là)
Unité = 14

## liste des types de fréquences (Schéma de médication) SU
1 Journalier
2 Jours au choix
3 Tous les X jours
4 Calenrier
5 Posologie à la demande
6 Tous les ans
7 Tous les mois
8 Toutes les semaines