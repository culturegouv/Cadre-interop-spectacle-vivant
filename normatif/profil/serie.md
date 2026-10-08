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
| Spectacle | Œuvre ou œuvres scéniques présentées | F | 0,N | `workPerformed` |
| Esthétique, identifiant | Renvoi vers le référentiel des esthétiques | F | 0,N | `additionalType` |
| Esthétique, libellé | Libellé lisible de l'esthétique | F | 0,N | `genre` |
| Organisateur | Personne ou organisation qui propose la série | F | 0,N | `organizer` |
| Offre | Billets et forfaits proposés | F | 0,N | `offers` |
| URL | Lien vers la page de la série | F | 0,1 | `url` |
| Image | Image de la série | F | 0,N | `image` |
| Statut | Statut de la série | O | 1,1 | `eventStatus` |
| Description | Description de la série | F | 0,1 | `description` |
| Sous-événement | Représentations rattachées | F | 0,N | `subEvent` |
| Super-événement | Série englobante | F | 0,N | `superEvent` |

## Le spectacle reste en 0,N sur la série

La cardinalité du spectacle est restreinte à 0,1 sur la représentation, mais
elle reste 0,N ici, et c'est voulu.

Un regroupement réunit par définition ce qui n'est pas réductible à une seule
unité. Un festival présente des dizaines de spectacles. Une série consacrée à
un seul spectacle, comme `02-serie-lieu-unique.jsonld`, n'en déclare qu'un, mais
rien ne justifie de l'y contraindre.

C'est précisément cette asymétrie qui lève l'ambiguïté. Le niveau qui porte
l'exécution porte un spectacle. Le niveau qui porte le rassemblement en porte
autant qu'il en réunit.

## L'esthétique sur une série

Les deux propriétés sont les mêmes que sur la représentation, avec la même
règle, `additionalType` pour l'identifiant et `genre` pour le libellé. Les
raisons de ce dédoublement sont exposées dans
[representation.md](representation.md).

Sur une série, la répétition est la situation courante. Un festival
pluridisciplinaire déclare autant d'esthétiques qu'il en programme. L'exemple
`04-festival.jsonld` l'illustre.

## Écart par rapport au document publié en juin 2026

Le lieu passe d'obligatoire à facultatif.

Le document publié le donne obligatoire en cardinalité 1,1, ce qui contredit son
propre exemple d'une série jouée dans plusieurs lieux. Une tournée n'a pas de
lieu unique, et l'exemple `03-serie-itinerante.jsonld` l'illustre.

Cet écart est une proposition, non une décision.
