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
