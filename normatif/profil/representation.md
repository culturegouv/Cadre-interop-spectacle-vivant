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
| Spectacle | Œuvre scénique présentée | F | 0,1 | `workPerformed` |
| Esthétique, identifiant | Renvoi vers le référentiel des esthétiques | F | 0,N | `additionalType` |
| Esthétique, libellé | Libellé lisible de l'esthétique | F | 0,N | `genre` |
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

## L'esthétique, et pourquoi deux propriétés

L'esthétique est l'un des deux axes de recherche les plus demandés par le
public, avec le lieu. Elle était absente du tableau des propriétés minimales,
alors que le cadre annonce un référentiel des esthétiques. Un référentiel sans
propriété pour le porter ne sert à rien.

Elle est portée par deux propriétés, et ce n'est pas une redondance.

`schema:genre` attend un texte, ou une URL, et accepte donc le libellé
« théâtre contemporain ». Mais cette propriété n'est pas déclarée sur
`schema:Event` dans le vocabulaire schema.org. Elle l'est sur `CreativeWork`,
sur `MusicGroup` et sur `BroadcastChannel`. L'employer sur un événement n'est
pas une erreur de syntaxe, le document reste lisible, mais c'est un usage hors
domaine déclaré, qu'aucun consommateur n'est tenu d'interpréter.

`schema:additionalType` est déclarée sur `Thing`, donc disponible partout, et
attend une URL de classe. C'est la propriété conçue précisément pour rattacher
une ressource à une catégorie définie ailleurs. C'est donc elle qui porte le
renvoi vers le référentiel des esthétiques.

La règle est la suivante.

- `additionalType` porte l'identifiant, sous forme d'URI du référentiel. C'est
  ce qui permet la réconciliation entre systèmes et la recherche à facettes.
- `genre` porte le libellé, sous forme de texte. C'est ce qui reste lisible
  pour un humain et pour un moteur, sans avoir à résoudre l'URI.

Les deux sont facultatives et répétables. Un spectacle à la croisée de
plusieurs esthétiques en déclare plusieurs.

Tant que le référentiel national des esthétiques n'est pas publié, les
exemples renvoient vers des URI de substitution. Le changement d'URI lors de la
publication du référentiel ne modifiera ni le modèle ni les règles de
validation.

## Écarts par rapport au document publié en juin 2026

### L'identifiant devient obligatoire

Les exemples du document en emploient partout, y compris des URI et des ISNI,
mais aucun identifiant ne figure dans les tableaux de propriétés minimales.
Sans identifiant exigé, aucune réconciliation entre systèmes n'est possible.

Le choix du mécanisme d'identification est en cours d'instruction et ne sera
pas tranché par ce fichier.

### Le statut devient obligatoire

Facultatif, il ne sera pas renseigné. Une annulation ou un report ne se
propagera donc jamais jusqu'aux réutilisateurs, qui continueront d'afficher une
représentation annulée.

### Le spectacle passe de 0,N à 0,1

Une représentation est l'exécution d'un spectacle, au singulier. La cardinalité
0,N posait une ambiguïté que rien ne venait lever.

Deux situations étaient confondues.

Un spectacle composé de plusieurs œuvres, un récital qui enchaîne des pièces de
compositeurs différents par exemple, est un seul spectacle. La composition se
décrit au niveau du spectacle, pas au niveau de la représentation.

Plusieurs spectacles présentés dans une même soirée sont plusieurs
représentations, réunies par un regroupement. C'est exactement ce que décrit
l'exemple `05-journee-composite.jsonld`.

La cardinalité 0,N permettait de décrire la seconde situation comme si c'était
la première, ce qui produit deux fichiers incomparables pour une même réalité.
L'exemple `invalides/04-representation-deux-spectacles.jsonld` teste le rejet.

### L'esthétique est ajoutée

Voir la section ci-dessus.

Ces écarts sont des propositions, non des décisions. Ils font l'objet de
signalements ouverts et seront tranchés collectivement.
