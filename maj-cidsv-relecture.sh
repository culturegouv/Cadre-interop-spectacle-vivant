#!/usr/bin/env bash
# ============================================================================
#  Cadre d'interopérabilité des données du spectacle vivant
#  Mise à jour, prise en compte de la relecture d'octobre 2026
#
#  Ce que le script applique
#    - l'esthétique devient descriptible sur la représentation et sur la série,
#      avec deux propriétés distinctes, l'identifiant et le libellé
#    - une représentation ne porte plus qu'un seul spectacle
#    - le niveau production, issu du modèle LAPA, est documenté comme
#      proposition pour la version suivante
#    - la page spectacle est réécrite autour de la distinction entre la
#      conception et la réalisation
#    - un nouvel exemple invalide teste la règle du spectacle unique
#    - la liste des contributeurs et le journal des modifications sont corrigés
#
#  Ce que le script ne modifie pas
#    - la question de l'identifiant obligatoire, en cours d'instruction
#    - les outils de validation, qui restent inchangés
#    - le contexte JSON-LD, qui déclare déjà additionalType
#
#  Usage
#    cd ~/dev/cadre-interoperabilite-spectacle-vivant
#    chmod +x maj-cidsv-relecture.sh
#    ./maj-cidsv-relecture.sh
#
#  Le script n'effectue aucun commit et ne pousse rien.
#  Les commandes à lancer ensuite s'affichent à la fin.
# ============================================================================
set -euo pipefail

VERSION="v0.1"

# ---------------------------------------------------------------------------
# Vérification, le script doit tourner à la racine du dépôt
# ---------------------------------------------------------------------------
echo "==> Vérifications"

if [ ! -d ".git" ] || [ ! -d "normatif/profil" ]; then
  cat <<'MSG'
Ce script doit être lancé depuis la racine du dépôt du cadre.

   cd ~/dev/cadre-interoperabilite-spectacle-vivant
   ./maj-cidsv-relecture.sh

MSG
  exit 1
fi

echo "    dépôt reconnu, $(pwd)"

if [ -n "$(git status --porcelain)" ]; then
  echo
  echo "    Attention, le dépôt contient des modifications non enregistrées."
  git status --short | sed 's/^/      /'
  echo
  printf "    Continuer et les écraser pour les fichiers concernés ? [o/N] "
  read -r reponse
  case "${reponse}" in
    o|O|oui|OUI) echo "    on continue" ;;
    *) echo "    abandon, rien n'a été modifié"; exit 1 ;;
  esac
fi

echo "==> Écriture des fichiers"

# ===========================================================================
#  PROFIL, REPRÉSENTATION
# ===========================================================================
echo "    normatif/profil/representation.md"
cat > normatif/profil/representation.md <<'EOF'
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
EOF

# ===========================================================================
#  PROFIL, SÉRIE
# ===========================================================================
echo "    normatif/profil/serie.md"
cat > normatif/profil/serie.md <<'EOF'
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
EOF

# ===========================================================================
#  PROFIL, SPECTACLE
# ===========================================================================
echo "    normatif/profil/spectacle.md"
cat > normatif/profil/spectacle.md <<'EOF'
# Spectacle

L'œuvre scénique conçue pour être présentée devant un public. Correspond
provisoirement à `schema:CreativeWork`.

> La spécification complète de cette classe relève de la version suivante. Ce
> fichier expose la difficulté principale et recense les questions ouvertes.

## La difficulté, conception et réalisation sont confondues

Le modèle publié en juin 2026 compte quatre niveaux, l'œuvre, le spectacle, la
série et la représentation. Le niveau spectacle y recouvre deux choses de
nature différente.

D'un côté la conception, c'est-à-dire l'intention artistique, l'écriture
scénique, le parti pris de mise en scène. Elle est abstraite, elle n'a pas de
date, elle survit aux reprises.

De l'autre la réalisation, c'est-à-dire ce qui est effectivement monté, avec une
distribution nommée, une équipe technique, une durée de montage, une série de
dates dans un lieu donné. Elle est datée, elle est unique, et c'est elle que
désignent les professionnels quand ils parlent d'une production.

Les deux sont rassemblées sous le même mot, et c'est de là que viennent les
désaccords sur la cardinalité du spectacle et sur l'identité dans le temps.

## La distinction, telle qu'elle est posée ailleurs

Les travaux de recherche sur la documentation des arts de la scène, notamment le
modèle LAPA, distinguent trois niveaux là où le cadre n'en distingue qu'un.

| Niveau | Nature | Exemple | Daté |
| --- | --- | --- | --- |
| Œuvre scénique | La conception, l'intention, l'écriture scénique | Le Hamlet de Patrice Chéreau | non |
| Production | La réalisation, avec sa distribution et son équipe | La production de 1988 au Festival d'Avignon | oui |
| Représentation | Une occurrence devant un public | Le 9 juillet 1988 | oui |

Rapportée au cadre, la hiérarchie devient la suivante.

    Œuvre source          le texte, la partition, le livret
      Œuvre scénique      la conception, l'intention, l'écriture scénique
        Production        la réalisation datée, avec sa distribution
          Représentation  une occurrence

Le cadre tient aujourd'hui les premier, deuxième et quatrième niveaux. Le
troisième manque, et c'est lui qui porterait la distribution, l'équipe
technique, les dates de création et de dernière, les coproducteurs.

Un niveau production est proposé pour la version suivante. Il est documenté
dans [production.md](production.md).

## Questions ouvertes

**La relation entre le spectacle et les œuvres qui le composent.** Le modèle
prévoit qu'un spectacle puisse être composé de plusieurs œuvres, mais aucune
propriété n'est spécifiée pour cette relation. Candidats à trancher,
`isBasedOn`, `hasPart`, `workExample`.

Cette question commande la cardinalité du spectacle sur la représentation.
Celle-ci est désormais restreinte à 0,1, au motif qu'un spectacle composé de
plusieurs œuvres reste un spectacle, et que la composition se décrit à ce
niveau. Il reste à spécifier comment.

**L'attente de `PerformanceWork`.** La communauté schema.org instruit une classe
dédiée à l'œuvre-spectacle, proposée par CAPACOA, la même organisation à
l'origine de `PerformingArtsEvent`, publiée en décembre 2025. Faut-il spécifier
maintenant sur `CreativeWork` en prévoyant une migration, ou attendre la
publication.

L'arbitrage dépend du niveau production. Si ce niveau est retenu, la question
n'est plus seulement celle d'une classe pour l'œuvre scénique, mais celle de
l'articulation entre deux classes.

**L'identité dans le temps.** Une reprise ou une recréation constitue-t-elle le
même spectacle.

La distinction entre conception et réalisation permet de reformuler la question
au lieu de la trancher arbitrairement. Une reprise est une nouvelle production
de la même œuvre scénique. Une recréation est une nouvelle œuvre scénique issue
de la même œuvre source. Reste à fixer le critère qui sépare les deux cas.

**La distribution.** Le premier cycle a tranché qu'une variation de distribution
ne crée pas un nouveau spectacle dès lors que la mise en scène et l'identité
artistique demeurent. Cette décision reste valable, et elle devient lisible dès
lors que la distribution est rattachée à la production et non à l'œuvre
scénique. Une variation ponctuelle, une doublure sur une date, se décrit alors
sur la représentation par `performer`.
EOF

# ===========================================================================
#  PROFIL, PRODUCTION, NOUVEAU FICHIER
# ===========================================================================
echo "    normatif/profil/production.md  (nouveau)"
cat > normatif/profil/production.md <<'EOF'
# Production

> Ce niveau n'existe pas dans le cadre publié en juin 2026. Ce fichier est une
> proposition pour la version suivante. Rien ici n'est validé, aucune règle de
> validation ne porte sur ce niveau, et les exemples n'en emploient pas.

## Ce que le niveau désigne

La production est la réalisation datée d'une œuvre scénique, avec sa
distribution, son équipe technique et sa série de dates.

Le Hamlet mis en scène par Patrice Chéreau est une œuvre scénique. Ce qui a été
monté au Festival d'Avignon en 1988, avec cette distribution-là, est une
production. Le 9 juillet 1988 est une représentation.

## Pourquoi ce niveau manque

Le cadre publié compte quatre niveaux, l'œuvre, le spectacle, la série et la
représentation. Le niveau spectacle y recouvre à la fois la conception et la
réalisation, qui sont de nature différente. L'une est abstraite et survit aux
reprises, l'autre est datée et unique. La démonstration figure dans
[spectacle.md](spectacle.md).

Trois conséquences pratiques découlent de cette absence.

**La distribution n'a pas de niveau de rattachement.** Rattachée à l'œuvre
scénique, elle serait fausse dès la première reprise. Rattachée à chaque
représentation, elle serait répétée à l'identique sur des dizaines
d'occurrences, avec le risque de divergence que cela implique.

**Une reprise ne se distingue pas d'une création.** Deux productions
successives de la même œuvre scénique, à dix ans d'intervalle et avec des
distributions différentes, ne peuvent aujourd'hui être décrites ni comme un
seul spectacle ni comme deux, sans perte dans les deux cas.

**La série ne peut pas porter cette information.** Une série est un
regroupement d'événements, pas une entité artistique. Une tournée réunit des
représentations issues d'une même production, mais la série décrit le cadre de
programmation, pas la réalisation artistique.

## Propriétés envisagées

| Propriété | Description | Obligation | Cardinalité | schema.org |
| --- | --- | --- | --- | --- |
| Identifiant | Identifiant pérenne de la ressource | O | 1,1 | `@id` |
| Nom | Nom de la production | O | 1,1 | `name` |
| Œuvre scénique | Conception dont la production est la réalisation | O | 1,1 | à spécifier |
| Date de création | Première représentation publique | F | 0,1 | à spécifier |
| Date de dernière | Dernière représentation publique | F | 0,1 | à spécifier |
| Distribution | Interprètes de la production | F | 0,N | `performer` |
| Équipe artistique | Mise en scène, scénographie, lumière, son | F | 0,N | à spécifier |
| Producteur | Structure porteuse de la production | F | 0,N | `producer` |
| Coproducteur | Structures coproductrices | F | 0,N | à spécifier |
| Durée | Durée de la production, hors entracte | F | 0,1 | `duration` |
| Esthétique, identifiant | Renvoi vers le référentiel des esthétiques | F | 0,N | `additionalType` |
| Esthétique, libellé | Libellé lisible de l'esthétique | F | 0,N | `genre` |

## Questions à trancher avant toute spécification

**La classe.** `CreativeWork` conviendrait syntaxiquement, mais employer la
même classe pour l'œuvre scénique et pour sa réalisation reconduit la confusion
au lieu de la lever. La classe `PerformanceWork` en instruction chez
schema.org, proposée par CAPACOA, porte sur l'œuvre scénique et non sur la
production. Aucune classe existante ne correspond exactement.

**La relation vers l'œuvre scénique.** `exampleOfWork` et `isBasedOn` sont les
deux candidats. Le premier dit qu'une production est une instance d'une œuvre,
ce qui correspond à l'intention, mais il est employé par ailleurs dans le cadre
pour relier le spectacle à l'œuvre source.

**La relation vers la représentation.** `workPerformed` relie aujourd'hui la
représentation au spectacle. Si le niveau production est introduit, il faut
décider si `workPerformed` pointe vers la production, vers l'œuvre scénique, ou
vers les deux. Cette décision est rétrocompatible ou non selon le choix retenu,
et elle conditionne le numéro de la version qui l'introduira.

**Le caractère obligatoire.** Un niveau supplémentaire obligatoire alourdirait
considérablement la saisie pour des acteurs qui ne tiennent aujourd'hui que
des dates et des titres. Un niveau facultatif risque de ne jamais être
renseigné. Un niveau facultatif mais recommandé pour les structures qui
produisent est la voie la plus probable.

**L'articulation avec les référentiels existants.** Plusieurs bases
documentaires du spectacle vivant tiennent déjà un niveau équivalent, sous des
noms différents. Le rapprochement est à instruire avant de fixer une
spécification, faute de quoi le cadre créerait un niveau que personne ne
pourrait alimenter.
EOF

# ===========================================================================
#  SCHÉMA JSON
# ===========================================================================
echo "    normatif/schema/${VERSION}/cidsv.schema.json"
cat > "normatif/schema/${VERSION}/cidsv.schema.json" <<'EOF'
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "https://example.org/cidsv/v0.1/cidsv.schema.json",
  "title": "Cadre d'interopérabilité des données du spectacle vivant, version 0.1",
  "description": "Validation syntaxique d'un document JSON-LD conforme au cadre. La validation du graphe relève des règles SHACL, qui sont la référence.",
  "type": "object",
  "required": ["@context", "@type", "@id", "name"],
  "properties": {
    "@context": { "type": ["string", "object"] },
    "@type": {
      "type": "string",
      "enum": ["PerformingArtsEvent", "Event", "EventSeries"]
    },
    "@id": { "type": "string", "format": "uri" },
    "name": { "type": "string", "minLength": 1 },
    "startDate": { "type": "string" },
    "endDate": { "type": "string" },
    "duration": { "type": "string" },
    "eventStatus": { "type": "string", "format": "uri" },
    "eventAttendanceMode": { "type": "string", "format": "uri" },
    "inLanguage": { "type": "string" },
    "url": { "type": "string", "format": "uri" },
    "description": { "type": "string" },
    "location": { "type": ["object", "array"] },
    "organizer": { "type": ["object", "array"] },
    "performer": { "type": ["object", "array"] },
    "offers": { "type": ["object", "array"] },
    "audience": { "type": ["object", "array"] },
    "image": { "type": ["string", "array"] },
    "subEvent": { "type": ["object", "array"] },
    "superEvent": { "type": ["object", "array"] },
    "workPerformed": { "type": ["object", "array"] },
    "additionalType": {
      "description": "Identifiant de l'esthétique, URI renvoyant au référentiel des esthétiques. Répétable.",
      "oneOf": [
        { "type": "string", "format": "uri" },
        {
          "type": "array",
          "items": { "type": "string", "format": "uri" },
          "minItems": 1
        }
      ]
    },
    "genre": {
      "description": "Libellé lisible de l'esthétique. Répétable. L'identifiant correspondant se porte avec additionalType.",
      "oneOf": [
        { "type": "string", "minLength": 1 },
        {
          "type": "array",
          "items": { "type": "string", "minLength": 1 },
          "minItems": 1
        }
      ]
    }
  },
  "allOf": [
    {
      "if": {
        "properties": { "@type": { "const": "PerformingArtsEvent" } },
        "required": ["@type"]
      },
      "then": {
        "required": ["startDate", "location", "eventStatus"],
        "properties": {
          "workPerformed": {
            "description": "Une représentation ne porte qu'un seul spectacle. Un spectacle composé de plusieurs oeuvres se décrit au niveau du spectacle. Plusieurs spectacles dans une même soirée se décrivent par un regroupement de représentations.",
            "type": "object"
          }
        }
      }
    },
    {
      "if": {
        "properties": { "@type": { "const": "EventSeries" } },
        "required": ["@type"]
      },
      "then": {
        "required": ["startDate", "eventStatus"],
        "properties": {
          "workPerformed": {
            "description": "Un regroupement peut réunir plusieurs spectacles.",
            "type": ["object", "array"]
          }
        }
      }
    }
  ]
}
EOF

# ===========================================================================
#  FORMES SHACL
# ===========================================================================
echo "    normatif/formes/${VERSION}/cidsv.shapes.ttl"
cat > "normatif/formes/${VERSION}/cidsv.shapes.ttl" <<'EOF'
@prefix sh:     <http://www.w3.org/ns/shacl#> .
@prefix schema: <https://schema.org/> .
@prefix xsd:    <http://www.w3.org/2001/XMLSchema#> .
@prefix cidsv:  <https://example.org/cidsv/v0.1/shapes#> .

#
# Représentation
#
cidsv:RepresentationShape
    a sh:NodeShape ;
    sh:targetClass schema:PerformingArtsEvent ;
    sh:nodeKind sh:IRI ;
    sh:message "Une représentation doit porter un identifiant pérenne."@fr ;

    sh:property [
        sh:path schema:name ;
        sh:minCount 1 ; sh:maxCount 1 ;
        sh:message "Le nom de la représentation est obligatoire."@fr ;
    ] ;

    sh:property [
        sh:path schema:startDate ;
        sh:minCount 1 ; sh:maxCount 1 ;
        sh:message "La date et l'heure de début sont obligatoires."@fr ;
    ] ;

    sh:property [
        sh:path schema:endDate ;
        sh:maxCount 1 ;
    ] ;

    sh:property [
        sh:path schema:duration ;
        sh:maxCount 1 ;
        sh:message "La durée ne peut pas être répétée. Une durée variable selon les dates se porte sur chaque représentation."@fr ;
    ] ;

    sh:property [
        sh:path schema:location ;
        sh:minCount 1 ; sh:maxCount 1 ;
        sh:nodeKind sh:BlankNodeOrIRI ;
        sh:message "Le lieu physique est obligatoire pour une représentation."@fr ;
    ] ;

    sh:property [
        sh:path schema:workPerformed ;
        sh:maxCount 1 ;
        sh:message "Une représentation ne porte qu'un seul spectacle. Un spectacle composé de plusieurs oeuvres se décrit au niveau du spectacle, et plusieurs spectacles réunis se décrivent par un regroupement de représentations."@fr ;
    ] ;

    sh:property [
        sh:path schema:additionalType ;
        sh:nodeKind sh:IRI ;
        sh:message "L'identifiant d'esthétique doit être une URI renvoyant à un référentiel."@fr ;
    ] ;

    sh:property [
        sh:path schema:genre ;
        sh:datatype xsd:string ;
        sh:message "Le libellé d'esthétique est un texte. L'identifiant se porte avec additionalType."@fr ;
    ] ;

    sh:property [
        sh:path schema:eventStatus ;
        sh:minCount 1 ; sh:maxCount 1 ;
        sh:in ( schema:EventScheduled
                schema:EventCancelled
                schema:EventPostponed
                schema:EventRescheduled
                schema:EventMovedOnline ) ;
        sh:message "Le statut de l'événement est obligatoire, sans quoi une annulation ne se propage pas aux réutilisateurs."@fr ;
    ] ;

    sh:property [
        sh:path schema:inLanguage ;
        sh:maxCount 1 ;
    ] .

#
# Série
#
cidsv:SerieShape
    a sh:NodeShape ;
    sh:targetClass schema:EventSeries ;
    sh:nodeKind sh:IRI ;
    sh:message "Une série doit porter un identifiant pérenne."@fr ;

    sh:property [
        sh:path schema:name ;
        sh:minCount 1 ; sh:maxCount 1 ;
        sh:message "Le nom de la série est obligatoire."@fr ;
    ] ;

    sh:property [
        sh:path schema:startDate ;
        sh:minCount 1 ; sh:maxCount 1 ;
        sh:message "La date de début de la série est obligatoire."@fr ;
    ] ;

    sh:property [
        sh:path schema:location ;
        sh:maxCount 1 ;
        sh:message "Une série itinérante n'a pas de lieu unique. La propriété est facultative et ne peut pas être répétée."@fr ;
    ] ;

    sh:property [
        sh:path schema:additionalType ;
        sh:nodeKind sh:IRI ;
        sh:message "L'identifiant d'esthétique doit être une URI renvoyant à un référentiel."@fr ;
    ] ;

    sh:property [
        sh:path schema:genre ;
        sh:datatype xsd:string ;
        sh:message "Le libellé d'esthétique est un texte. L'identifiant se porte avec additionalType."@fr ;
    ] ;

    sh:property [
        sh:path schema:eventStatus ;
        sh:minCount 1 ; sh:maxCount 1 ;
        sh:message "Le statut de la série est obligatoire."@fr ;
    ] .

#
# Lieu
#
cidsv:LieuShape
    a sh:NodeShape ;
    sh:targetClass schema:Place ;

    sh:property [
        sh:path schema:name ;
        sh:minCount 1 ;
        sh:message "Le nom du lieu est obligatoire."@fr ;
    ] .
EOF

# ===========================================================================
#  EXEMPLES VALIDES
# ===========================================================================
echo "    exemples/01-representation-opera.jsonld"
cat > exemples/01-representation-opera.jsonld <<'EOF'
{
  "@context": "https://schema.org",
  "@type": "PerformingArtsEvent",
  "@id": "https://exemple.fr/event/pelleas-et-melisande/2027-01-30",
  "name": "Pelléas et Mélisande",
  "startDate": "2027-01-30T19:30:00+01:00",
  "endDate": "2027-01-30T22:30:00+01:00",
  "duration": "PT3H",
  "eventStatus": "https://schema.org/EventScheduled",
  "eventAttendanceMode": "https://schema.org/OfflineEventAttendanceMode",
  "inLanguage": "fr",
  "url": "https://exemple.fr/event/pelleas-et-melisande",
  "additionalType": "https://exemple.fr/referentiel/esthetiques/opera",
  "genre": "Opéra",
  "location": {
    "@type": "Place",
    "@id": "https://www.wikidata.org/wiki/Q975422",
    "name": "Opéra Bastille",
    "address": {
      "@type": "PostalAddress",
      "streetAddress": "Place de la Bastille",
      "addressLocality": "Paris",
      "postalCode": "75012",
      "addressCountry": "FR"
    }
  },
  "organizer": {
    "@type": "Organization",
    "@id": "https://isni.org/isni/0000000121472201",
    "name": "Opéra national de Paris"
  },
  "workPerformed": {
    "@type": "CreativeWork",
    "@id": "https://exemple.fr/oeuvre/pelleas-et-melisande",
    "name": "Pelléas et Mélisande"
  },
  "offers": [
    {
      "@type": "Offer",
      "name": "Catégorie 1",
      "price": "200",
      "priceCurrency": "EUR",
      "availability": "https://schema.org/InStock",
      "url": "https://exemple.fr/billetterie"
    },
    {
      "@type": "Offer",
      "name": "Catégorie 6",
      "price": "75",
      "priceCurrency": "EUR",
      "availability": "https://schema.org/InStock",
      "url": "https://exemple.fr/billetterie"
    }
  ]
}
EOF

echo "    exemples/02-serie-lieu-unique.jsonld"
cat > exemples/02-serie-lieu-unique.jsonld <<'EOF'
{
  "@context": "https://schema.org",
  "@type": "EventSeries",
  "@id": "https://exemple.fr/serie/le-ring-2027",
  "name": "Le Ring de Katharsy, série 2027",
  "startDate": "2027-05-20",
  "endDate": "2027-05-30",
  "eventStatus": "https://schema.org/EventScheduled",
  "additionalType": "https://exemple.fr/referentiel/esthetiques/theatre-musical",
  "genre": "Théâtre musical",
  "location": {
    "@type": "Place",
    "@id": "https://exemple.fr/lieu/salle-renaud-barrault",
    "name": "Salle Renaud-Barrault",
    "address": {
      "@type": "PostalAddress",
      "addressLocality": "Paris",
      "addressCountry": "FR"
    }
  },
  "workPerformed": {
    "@type": "CreativeWork",
    "@id": "https://exemple.fr/oeuvre/le-ring-de-katharsy",
    "name": "Le Ring de Katharsy"
  },
  "subEvent": [
    {
      "@type": "PerformingArtsEvent",
      "@id": "https://exemple.fr/event/le-ring-2027-05-20",
      "name": "Le Ring de Katharsy, 20 mai 2027",
      "startDate": "2027-05-20T20:00:00+02:00",
      "duration": "PT1H25M",
      "eventStatus": "https://schema.org/EventScheduled",
      "additionalType": "https://exemple.fr/referentiel/esthetiques/theatre-musical",
      "genre": "Théâtre musical",
      "location": {
        "@type": "Place",
        "@id": "https://exemple.fr/lieu/salle-renaud-barrault",
        "name": "Salle Renaud-Barrault"
      },
      "workPerformed": {
        "@type": "CreativeWork",
        "@id": "https://exemple.fr/oeuvre/le-ring-de-katharsy",
        "name": "Le Ring de Katharsy"
      }
    }
  ]
}
EOF

echo "    exemples/03-serie-itinerante.jsonld"
cat > exemples/03-serie-itinerante.jsonld <<'EOF'
{
  "@context": "https://schema.org",
  "@type": "EventSeries",
  "@id": "https://exemple.fr/serie/la-lettre-2027",
  "name": "La Lettre, série de représentations 2027",
  "description": "Série itinérante, sans lieu unique. Cet exemple illustre pourquoi la propriété location ne peut pas être obligatoire sur une série.",
  "startDate": "2027-05-20",
  "endDate": "2027-05-30",
  "eventStatus": "https://schema.org/EventScheduled",
  "additionalType": "https://exemple.fr/referentiel/esthetiques/theatre-contemporain",
  "genre": "Théâtre contemporain",
  "organizer": {
    "@type": "Organization",
    "@id": "https://exemple.fr/org/tpm",
    "name": "Théâtre Public de Montreuil"
  },
  "workPerformed": {
    "@type": "CreativeWork",
    "@id": "https://exemple.fr/oeuvre/la-lettre",
    "name": "La Lettre"
  },
  "subEvent": [
    {
      "@type": "PerformingArtsEvent",
      "@id": "https://exemple.fr/event/la-lettre-2027-05-20",
      "name": "La Lettre",
      "startDate": "2027-05-20T20:00:00+02:00",
      "eventStatus": "https://schema.org/EventScheduled",
      "additionalType": "https://exemple.fr/referentiel/esthetiques/theatre-contemporain",
      "genre": "Théâtre contemporain",
      "workPerformed": {
        "@type": "CreativeWork",
        "@id": "https://exemple.fr/oeuvre/la-lettre",
        "name": "La Lettre"
      },
      "location": {
        "@type": "Place",
        "@id": "https://exemple.fr/lieu/parc-montreau",
        "name": "Parc Montreau",
        "address": {
          "@type": "PostalAddress",
          "streetAddress": "2 rue Babeuf",
          "addressLocality": "Montreuil",
          "addressCountry": "FR"
        }
      }
    },
    {
      "@type": "PerformingArtsEvent",
      "@id": "https://exemple.fr/event/la-lettre-2027-05-26",
      "name": "La Lettre",
      "startDate": "2027-05-26T20:00:00+02:00",
      "eventStatus": "https://schema.org/EventScheduled",
      "additionalType": "https://exemple.fr/referentiel/esthetiques/theatre-contemporain",
      "genre": "Théâtre contemporain",
      "workPerformed": {
        "@type": "CreativeWork",
        "@id": "https://exemple.fr/oeuvre/la-lettre",
        "name": "La Lettre"
      },
      "location": {
        "@type": "Place",
        "@id": "https://exemple.fr/lieu/theatre-des-roches",
        "name": "Théâtre des Roches",
        "address": {
          "@type": "PostalAddress",
          "streetAddress": "19 rue Antoinette",
          "addressLocality": "Montreuil",
          "addressCountry": "FR"
        }
      }
    }
  ]
}
EOF

echo "    exemples/04-festival.jsonld"
cat > exemples/04-festival.jsonld <<'EOF'
{
  "@context": "https://schema.org",
  "@type": "EventSeries",
  "@id": "https://exemple.fr/serie/festival-2027",
  "name": "Festival des Musiques Vivantes 2027",
  "description": "Festival pluridisciplinaire. Cet exemple illustre la répétition de l'esthétique sur un regroupement, chaque identifiant ayant son libellé.",
  "startDate": "2027-08-26",
  "endDate": "2027-08-30",
  "eventStatus": "https://schema.org/EventScheduled",
  "additionalType": [
    "https://exemple.fr/referentiel/esthetiques/musiques-actuelles",
    "https://exemple.fr/referentiel/esthetiques/musique-contemporaine",
    "https://exemple.fr/referentiel/esthetiques/arts-de-la-rue"
  ],
  "genre": [
    "Musiques actuelles",
    "Musique contemporaine",
    "Arts de la rue"
  ],
  "location": {
    "@type": "Place",
    "@id": "https://exemple.fr/lieu/domaine-national",
    "name": "Domaine national",
    "address": {
      "@type": "PostalAddress",
      "addressLocality": "Saint-Cloud",
      "addressCountry": "FR"
    }
  },
  "offers": [
    { "@type": "Offer", "name": "Billet 1 jour", "category": "Ticket" },
    { "@type": "Offer", "name": "Forfait 3 jours", "category": "Pass" }
  ],
  "subEvent": [
    {
      "@type": "PerformingArtsEvent",
      "@id": "https://exemple.fr/event/festival-2027-08-26-scene-1",
      "name": "Concert d'ouverture",
      "startDate": "2027-08-26T18:00:00+02:00",
      "endDate": "2027-08-26T20:00:00+02:00",
      "eventStatus": "https://schema.org/EventScheduled",
      "additionalType": "https://exemple.fr/referentiel/esthetiques/musiques-actuelles",
      "genre": "Musiques actuelles",
      "location": {
        "@type": "Place",
        "@id": "https://exemple.fr/lieu/domaine-national-scene-principale",
        "name": "Domaine national, scène principale"
      }
    }
  ]
}
EOF

echo "    exemples/05-journee-composite.jsonld"
cat > exemples/05-journee-composite.jsonld <<'EOF'
{
  "@context": "https://schema.org",
  "@type": "EventSeries",
  "@id": "https://exemple.fr/serie/journee-decouverte-2027",
  "name": "Journée découverte, Parier sur la beauté",
  "description": "Journée composée d'événements de natures différentes, répétition publique, rencontre et conférence. Chaque sous-événement porte son propre spectacle, ce qui montre comment décrire plusieurs spectacles dans une même journée sans les accumuler sur une seule représentation.",
  "startDate": "2027-02-28",
  "endDate": "2027-02-28",
  "eventStatus": "https://schema.org/EventScheduled",
  "additionalType": [
    "https://exemple.fr/referentiel/esthetiques/opera",
    "https://exemple.fr/referentiel/esthetiques/rencontre-publique"
  ],
  "genre": [
    "Opéra",
    "Rencontre publique"
  ],
  "location": {
    "@type": "Place",
    "@id": "https://exemple.fr/lieu/opera-exemple",
    "name": "Opéra, exemple",
    "address": {
      "@type": "PostalAddress",
      "addressLocality": "Lyon",
      "addressCountry": "FR"
    }
  },
  "subEvent": [
    {
      "@type": "PerformingArtsEvent",
      "@id": "https://exemple.fr/event/repetition-publique-2027-02-28",
      "name": "Répétition publique, Manon Lescaut",
      "startDate": "2027-02-28T09:30:00+01:00",
      "eventStatus": "https://schema.org/EventScheduled",
      "additionalType": "https://exemple.fr/referentiel/esthetiques/opera",
      "genre": "Opéra",
      "workPerformed": {
        "@type": "CreativeWork",
        "@id": "https://exemple.fr/oeuvre/manon-lescaut",
        "name": "Manon Lescaut"
      },
      "location": {
        "@type": "Place",
        "@id": "https://exemple.fr/lieu/opera-exemple",
        "name": "Opéra, exemple"
      }
    },
    {
      "@type": "PerformingArtsEvent",
      "@id": "https://exemple.fr/event/rencontre-2027-02-28",
      "name": "Rencontre, Parier sur la beauté",
      "startDate": "2027-02-28T11:00:00+01:00",
      "eventStatus": "https://schema.org/EventScheduled",
      "additionalType": "https://exemple.fr/referentiel/esthetiques/rencontre-publique",
      "genre": "Rencontre publique",
      "workPerformed": {
        "@type": "CreativeWork",
        "@id": "https://exemple.fr/oeuvre/parier-sur-la-beaute",
        "name": "Parier sur la beauté"
      },
      "location": {
        "@type": "Place",
        "@id": "https://exemple.fr/lieu/opera-exemple",
        "name": "Opéra, exemple"
      }
    }
  ]
}
EOF

# ===========================================================================
#  EXEMPLES INVALIDES
# ===========================================================================
echo "    exemples/invalides/04-representation-deux-spectacles.jsonld  (nouveau)"
cat > exemples/invalides/04-representation-deux-spectacles.jsonld <<'EOF'
{
  "@context": "https://schema.org",
  "@type": "PerformingArtsEvent",
  "@id": "https://exemple.fr/event/soiree-deux-spectacles",
  "name": "Soirée à deux spectacles déclarés sur une seule représentation",
  "description": "Fichier volontairement incorrect. Deux spectacles sont déclarés sur une seule représentation. La description correcte est un regroupement de deux représentations, comme dans 05-journee-composite.jsonld.",
  "startDate": "2027-03-12T20:00:00+01:00",
  "eventStatus": "https://schema.org/EventScheduled",
  "location": {
    "@type": "Place",
    "@id": "https://exemple.fr/lieu/salle-exemple",
    "name": "Salle, exemple"
  },
  "workPerformed": [
    {
      "@type": "CreativeWork",
      "@id": "https://exemple.fr/oeuvre/premiere-piece",
      "name": "Première pièce"
    },
    {
      "@type": "CreativeWork",
      "@id": "https://exemple.fr/oeuvre/seconde-piece",
      "name": "Seconde pièce"
    }
  ]
}
EOF

echo "    exemples/invalides/README.md"
cat > exemples/invalides/README.md <<'EOF'
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
| `04-representation-deux-spectacles.jsonld` | Deux spectacles sur une même représentation | Une représentation ne porte qu'un seul spectacle |

## Lancer la vérification

    python3 outils/valider.py --attendu-invalide exemples/invalides/*.jsonld

Le validateur renvoie un code de sortie nul si, et seulement si, chacun de ces
fichiers est effectivement rejeté. Un fichier qui passerait la validation
signalerait que la règle correspondante est inactive.
EOF

# ===========================================================================
#  AUTHORS ET CHANGELOG
# ===========================================================================
echo "    AUTHORS.md"
cat > AUTHORS.md <<'EOF'
# Contributrices et contributeurs

Le cadre est le produit d'un travail collectif.

## Démarche

Démarche conduite conjointement par le ministère de la Culture et le TMNlab,
chacun au titre de son objet propre.

## Premier cycle, décembre 2025 à juin 2026

Une soixantaine de professionnels ont contribué à cette première version. La
liste nominative figure en annexe du document publié et sera reportée ici lors
de la prochaine mise à jour.

Parmi les contributions au modèle de données, la contribution de Clarisse
Bardiot, professeure des universités, dont les travaux sur la documentation des
arts de la scène et le modèle LAPA ont alimenté la distinction entre l'œuvre
scénique et sa réalisation.

Pour être ajouté ou corrigé dans cette liste, ouvrez un signalement.

## Relectures

Les relectures de la couche technique sont consignées ici, avec leur date.

| Date | Relecteur | Portée |
| --- | --- | --- |
| Octobre 2026 | Clarisse Bardiot | Modèle de données, niveaux de description, esthétique, cardinalités |

Les suites données à chaque relecture figurent dans
[CHANGELOG.md](CHANGELOG.md).
EOF

echo "    CHANGELOG.md"
cat > CHANGELOG.md <<'EOF'
# Journal des modifications

Le format suit les principes de Keep a Changelog et la numérotation suit le
versionnage sémantique. Voir [docs/versionnage.md](docs/versionnage.md).

## [Non publié]

### Modifié, à la suite de la relecture d'octobre 2026

La relecture de Clarisse Bardiot a porté sur le modèle de données. Quatre
points sont repris ici. Le cinquième, le mécanisme d'identification, est en
cours d'instruction et n'est pas traité par cette mise à jour.

- **L'esthétique devient descriptible**, sur la représentation et sur la série,
  par deux propriétés distinctes. `additionalType` porte l'identifiant sous
  forme d'URI, `genre` porte le libellé. Le dédoublement s'explique par le fait
  que `genre` n'est pas déclarée sur `Event` dans le vocabulaire schema.org,
  alors que `additionalType` est déclarée sur `Thing`. Les deux propriétés sont
  facultatives et répétables. Le détail figure dans
  [normatif/profil/representation.md](normatif/profil/representation.md).

- **Le spectacle passe de 0,N à 0,1 sur la représentation.** Une représentation
  est l'exécution d'un spectacle. Un spectacle composé de plusieurs œuvres se
  décrit au niveau du spectacle, et plusieurs spectacles réunis dans une même
  soirée se décrivent par un regroupement de représentations. La cardinalité
  reste 0,N sur la série, qui réunit par définition plusieurs spectacles.

- **La durée est limitée à une occurrence** sur la représentation.

- **La page spectacle est réécrite** autour de la distinction entre la
  conception et la réalisation, que le niveau spectacle confondait.

### Ajouté, à la suite de la même relecture

- **Un niveau production est proposé** pour la version suivante, documenté dans
  [normatif/profil/production.md](normatif/profil/production.md). Il porterait
  la réalisation datée d'une œuvre scénique, avec sa distribution et son équipe.
  Rien n'est spécifié ni validé, le fichier recense les questions à trancher.

- **Un exemple invalide**,
  `exemples/invalides/04-representation-deux-spectacles.jsonld`, qui teste le
  rejet de deux spectacles sur une même représentation.

### Conséquence sur le numéro de version

La restriction du spectacle à 0,1 est un changement non rétrocompatible. Un flux
qui déclarait plusieurs spectacles sur une représentation cesse d'être conforme.
Au titre de la règle énoncée dans [docs/versionnage.md](docs/versionnage.md),
cette modification relève d'une version majeure dès lors qu'une version de la
couche technique aura été publiée. La couche technique étant à l'état de
proposition non validée, elle reste pour l'instant dans l'espace `v0.1`.

### Questions ouvertes, à instruire collectivement

Ces trois points sont des écarts constatés entre le document publié et ce que
la validation automatique suppose. Ils ne sont pas tranchés et font l'objet de
signalements ouverts sur le dépôt.

- Rendre obligatoire un identifiant pérenne sur chaque ressource. Les exemples
  publiés en emploient partout, mais aucun n'est exigé par les tableaux de
  propriétés minimales. Le mécanisme d'identification lui-même, et son
  articulation avec les identifiants existants du secteur, sont en cours
  d'instruction.
- Rendre obligatoire le statut de l'événement. Facultatif, il ne sera pas
  renseigné, et une annulation ne se propagera pas aux réutilisateurs.
- Rendre facultatif le lieu sur une série. Le tableau le donne obligatoire en
  cardinalité 1,1 alors que l'exemple qui suit est une série itinérante.

### Ajouté

- Couche exécutable du cadre, à l'état de proposition technique non validée.
  Contexte JSON-LD, exemples valides, règles de validation et validateur.

## [0.1] - 2026-06-04

### Ajouté

- Modèle de données à quatre niveaux, œuvre, spectacle, série, représentation
- Propriétés minimales de la représentation
- Propriétés minimales de la série
- Exemples de mise en œuvre

### Contexte

Version issue du premier cycle de travail collectif conduit de décembre 2025 à
juin 2026, réunissant une soixantaine de professionnels du secteur.
EOF

# ===========================================================================
#  VALIDATION
# ===========================================================================
echo
echo "==> Validation"

VALIDATION_OK="non"

if command -v python3 >/dev/null 2>&1 && python3 -c "import pyshacl" >/dev/null 2>&1; then
  echo
  echo "--- Les cinq exemples doivent être conformes"
  if python3 outils/valider.py exemples/*.jsonld; then
    echo
    echo "--- Les quatre exemples invalides doivent être rejetés"
    if python3 outils/valider.py --attendu-invalide exemples/invalides/*.jsonld; then
      VALIDATION_OK="oui"
    fi
  fi
else
  echo "    pyshacl n'est pas disponible, validation ignorée."
  echo
  echo "    Pour l'installer, dans le dépôt :"
  echo "      python3 -m venv .venv"
  echo "      source .venv/bin/activate"
  echo "      pip install -r outils/requirements.txt"
  echo
  echo "    Puis relancer la validation seule :"
  echo "      python3 outils/valider.py exemples/*.jsonld"
  echo "      python3 outils/valider.py --attendu-invalide exemples/invalides/*.jsonld"
fi

echo
if [ "${VALIDATION_OK}" = "oui" ]; then
  echo "==> Validation réussie, 5 exemples conformes et 4 exemples rejetés"
elif command -v python3 >/dev/null 2>&1 && python3 -c "import pyshacl" >/dev/null 2>&1; then
  echo "==> La validation a signalé un problème. Les fichiers sont écrits,"
  echo "    mais ne les enregistrez pas avant d'avoir corrigé."
fi

# ===========================================================================
#  RÉCAPITULATIF
# ===========================================================================
echo
echo "==> Fichiers modifiés"
git status --short | sed 's/^/    /'

cat <<'MSG'

============================================================================
 ENREGISTRER ET POUSSER
============================================================================

1. Relisez la différence avant d'enregistrer.

   git diff
   git diff --stat

2. Enregistrez.

   git add -A
   git commit -m "Relecture d'octobre 2026, esthétique, cardinalité du spectacle, niveau production

Esthétique descriptible sur la représentation et sur la série, par
additionalType pour l'identifiant et genre pour le libellé.
Spectacle restreint à une occurrence par représentation, la cardinalité
restant multiple sur la série.
Niveau production documenté comme proposition pour la version suivante.
Page spectacle réécrite autour de la distinction conception et réalisation.
Nouvel exemple invalide testant la règle du spectacle unique.
Relectrice créditée dans AUTHORS.md à sa demande.

Le mécanisme d'identification n'est pas traité, il reste en instruction."

3. Poussez, en remplaçant ORGANISATION par l'adresse réelle du dépôt.

   Si le dépôt distant n'est pas encore relié :

   git remote add origin git@github.com:ORGANISATION/cadre-interoperabilite-spectacle-vivant.git
   git push -u origin main

   En HTTPS plutôt qu'en SSH :

   git remote add origin https://github.com/ORGANISATION/cadre-interoperabilite-spectacle-vivant.git
   git push -u origin main

   Si le dépôt est déjà relié, il suffit de :

   git push

4. Si le dépôt distant a changé entre-temps :

   git pull --rebase origin main
   git push

MSG

cat <<'MSG'
============================================================================
 PLUTÔT PAR BRANCHE, SI LE DÉPÔT EST PARTAGÉ
============================================================================

Une relecture se discute. Plutôt que de pousser sur main, ouvrez une branche
et une demande de fusion, ce qui donne un fil où répondre point par point.

   git checkout -b relecture-octobre-2026
   git add -A
   git commit -m "Relecture d'octobre 2026, esthétique, cardinalité du spectacle, niveau production"
   git push -u origin relecture-octobre-2026

Puis sur GitHub, ouvrez la demande de fusion depuis la bannière qui s'affiche,
ou avec gh si vous l'avez installé :

   gh pr create --fill

============================================================================
 CE QUI RESTE À FAIRE À LA MAIN
============================================================================

   Ouvrir un signalement sur le mécanisme d'identification, laissé de côté
   Ouvrir un signalement sur le niveau production, pour arbitrage collectif
   Remplacer les URI de substitution du référentiel des esthétiques
   lorsque le référentiel national sera publié
   Reporter la liste nominative des contributeurs du premier cycle

============================================================================
MSG
