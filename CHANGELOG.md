# Journal des modifications

Le format suit les principes de Keep a Changelog et la numérotation suit le
versionnage sémantique. Voir [docs/versionnage.md](docs/versionnage.md).

## [Non publié]

### Questions ouvertes, à instruire collectivement

Ces trois points sont des écarts constatés entre le document publié et ce que
la validation automatique suppose. Ils ne sont pas tranchés et font l'objet de
signalements ouverts sur le dépôt.

- Rendre obligatoire un identifiant pérenne sur chaque ressource. Les exemples
  publiés en emploient partout, mais aucun n'est exigé par les tableaux de
  propriétés minimales.
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
