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
