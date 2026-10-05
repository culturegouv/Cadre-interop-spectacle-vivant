# Représentation

La représentation est l'événement central du modèle. Elle correspond à
`schema:PerformingArtsEvent`, sous-classe de `schema:Event`.

C'est l'exécution concrète d'un spectacle, à une date, une heure et un lieu
précis, devant un public.

## Propriétés

| Propriété | Description | Obligation | Cardinalité | schema.org |
| --- | --- | --- | --- | --- |
| Identifiant | Identifiant pérenne de la ressource | O | 1,1 | `@id` |
| Nom | Nom de l'événement | O | 1,1 | `name` |
| Date et heure de début | Début de la représentation | O | 1,1 | `startDate` |
| Date et heure de fin | Fin de la représentation | F | 0,1 | `endDate` |
| Durée | Durée de la représentation | F | 0,1 | `duration` |
| Lieu | Lieu physique où se déroule la représentation | O | 1,1 | `location` |
| Spectacle | Œuvre scénique présentée | F | 0,N | `workPerformed` |
| Organisateur | Personne ou organisation qui propose l'événement | F | 0,N | `organizer` |
| Offre | Billets et tarifs proposés | F | 0,N | `offers` |
| Public | Public cible | F | 0,N | `audience` |
| Interprète | Artistes de l'événement | F | 0,N | `performer` |
| Langue | Langue de la représentation | F | 0,1 | `inLanguage` |
| URL | Lien vers la page de l'événement | F | 0,1 | `url` |
| Image | Image de l'événement | F | 0,N | `image` |
| Statut | Statut de l'événement | O | 1,1 | `eventStatus` |
| Mode de présence | Sur place, en ligne, hybride | F | 0,1 | `eventAttendanceMode` |
| Description | Description de l'événement | F | 0,1 | `description` |
| Super-événement | Série dont fait partie la représentation | F | 0,N | `superEvent` |

## Écarts par rapport au document publié en juin 2026

Deux propriétés sont ici marquées obligatoires alors que le document publié ne
les exigeait pas.

**L'identifiant.** Les exemples du document en emploient partout, y compris des
URI et des ISNI, mais aucun identifiant ne figure dans les tableaux de
propriétés minimales. Sans identifiant exigé, aucune réconciliation entre
systèmes n'est possible.

**Le statut.** Facultatif, il ne sera pas renseigné. Une annulation ou un report
ne se propagera donc jamais jusqu'aux réutilisateurs, qui continueront
d'afficher une représentation annulée.

Ces deux écarts sont des propositions, non des décisions. Ils font l'objet de
signalements ouverts et seront tranchés collectivement.
