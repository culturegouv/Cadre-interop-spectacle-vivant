# Regroupement de représentations

Un ensemble d'événements liés par un cadre commun, qu'il s'agisse ou non du même
spectacle. Correspond à `schema:EventSeries`.

Exemples, un festival, un cycle de programmation, une saison, une soirée
thématique, une tournée.

## Propriétés

| Propriété | Description | Obligation | Cardinalité | schema.org |
| --- | --- | --- | --- | --- |
| Identifiant | Identifiant pérenne de la ressource | O | 1,1 | `@id` |
| Nom | Nom de la série | O | 1,1 | `name` |
| Date de début | Début de la série | O | 1,1 | `startDate` |
| Date de fin | Fin de la série | F | 0,1 | `endDate` |
| Lieu | Lieu, lorsque la série se tient en un lieu unique | F | 0,1 | `location` |
| Spectacle | Œuvre scénique présentée | F | 0,N | `workPerformed` |
| Organisateur | Personne ou organisation qui propose la série | F | 0,N | `organizer` |
| Offre | Billets et forfaits proposés | F | 0,N | `offers` |
| URL | Lien vers la page de la série | F | 0,1 | `url` |
| Image | Image de la série | F | 0,N | `image` |
| Statut | Statut de la série | O | 1,1 | `eventStatus` |
| Description | Description de la série | F | 0,1 | `description` |
| Sous-événement | Représentations rattachées | F | 0,N | `subEvent` |
| Super-événement | Série englobante | F | 0,N | `superEvent` |

## Écart par rapport au document publié en juin 2026

Le lieu passe d'obligatoire à facultatif.

Le document publié le donne obligatoire en cardinalité 1,1, ce qui contredit son
propre exemple d'une série jouée dans plusieurs lieux. Une tournée n'a pas de
lieu unique, et l'exemple `03-serie-itinerante.jsonld` l'illustre.

Cet écart est une proposition, non une décision.
