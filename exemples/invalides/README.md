# Exemples invalides

Les fichiers de ce dossier sont volontairement incorrects. Ils doivent échouer à
la validation, et c'est ce qui prouve que les règles fonctionnent.

Une règle de validation mal écrite ne détecte rien et laisse tout passer. On ne
s'en aperçoit jamais, puisque tous les tests réussissent. En vérifiant que des
fichiers incorrects sont bien rejetés, on teste les règles elles-mêmes et pas
seulement les données.

| Fichier | Ce qui manque | Message attendu |
| --- | --- | --- |
| `01-sans-identifiant.jsonld` | L'identifiant de la ressource | Une représentation doit porter un identifiant pérenne |
| `02-sans-statut.jsonld` | Le statut de l'événement | Le statut de l'événement est obligatoire |
| `03-serie-deux-lieux.jsonld` | Deux lieux sur une même série | La propriété ne peut pas être répétée |
