# Lieu

L'espace physique où se tient une représentation. Correspond à `schema:Place`.

C'est l'endroit communiqué au public pour qu'il sache où se rendre. Un lieu peut
contenir plusieurs salles, qui sont des espaces scéniques distincts à
l'intérieur d'un même lieu.

## Propriétés

| Propriété | Description | Obligation | Cardinalité | schema.org |
| --- | --- | --- | --- | --- |
| Identifiant | Identifiant pérenne du lieu | O | 1,1 | `@id` |
| Nom | Nom du lieu | O | 1,1 | `name` |
| Adresse | Adresse postale | O | 1,1 | `address` |
| Coordonnées | Latitude et longitude | F | 0,1 | `geo` |
| Correspondances | Identifiants du même lieu dans d'autres bases | F | 0,N | `sameAs` |

## Distinction à ne pas perdre de vue

Un **lieu** est un espace physique. Une **structure** est une personne morale,
identifiée par un numéro SIRET. Une structure peut exploiter plusieurs lieux, un
lieu peut changer d'exploitant, et les deux n'ont pas la même durée de vie.

La plupart des bases existantes décrivent des structures et sont présentées
comme des référentiels de lieux. Confondre les deux rend tout rapprochement faux.

## Note sur les identifiants

La constitution d'un référentiel des lieux relève du cycle suivant. En l'absence
de référentiel national, l'identifiant peut pointer vers une ressource
existante, et la propriété `sameAs` porte les correspondances connues.
