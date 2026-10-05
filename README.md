# Cadre d'interopérabilité des données du spectacle vivant

Ce dépôt héberge le cadre d'interopérabilité des données du spectacle vivant.

Le cadre spécifie la manière de décrire les événements du spectacle vivant afin
qu'ils puissent circuler entre systèmes d'information sans ressaisie, être
agrégés de façon fiable, et rester lisibles par les moteurs de recherche et les
moteurs de réponse.

## Statut du dépôt

Ce dépôt est un espace de travail collectif. Il est élaboré, relu et mis à jour
conjointement par les parties prenantes de la démarche, chacune contribuant au
titre de son objet propre. Aucune partie n'agit pour le compte d'une autre.

La démarche est ouverte. Toute structure ou tout éditeur de solution souhaitant
y contribuer est bienvenu.

## Version en cours

**0.1**, périmètre des événements.

Le volet production et les référentiels font l'objet des versions suivantes.
Voir le [journal des modifications](CHANGELOG.md) et la
[politique de versionnage](docs/versionnage.md).

## Organisation du dépôt

Le dépôt distingue ce qui engage de ce qui explique.

| Dossier | Statut | Contenu |
| --- | --- | --- |
| `normatif/` | **Fait foi** | Le profil d'application, le contexte, le schéma et les règles de validation. Un flux est conforme ou non au regard de ces fichiers. |
| `docs/` | Informatif | La présentation, la méthodologie, le modèle, la gouvernance, le versionnage et le guide d'implémentation. |
| `exemples/` | Informatif | Des exemples valides, et un dossier d'exemples volontairement invalides qui servent à vérifier que les règles fonctionnent. |
| `referentiels/` | À venir | Les référentiels des lieux et des esthétiques, objet du cycle suivant. |
| `outils/` | Outillage | Le validateur et ses dépendances. |

Une modification dans `normatif/` déclenche une nouvelle version. Une
modification dans `docs/` n'en déclenche pas.

## Valider un fichier

```bash
pip install -r outils/requirements.txt
./outils/valider.sh exemples/01-representation-opera.jsonld
```

## Fondements

Le cadre s'appuie sur le vocabulaire [schema.org](https://schema.org), et
notamment sur `Event`, `PerformingArtsEvent`, `EventSeries`, `CreativeWork`,
`Place` et `Offer`.

Le recours à schema.org relève d'un choix technique d'interopérabilité et de
découvrabilité. Il ne se substitue à aucun cadre normatif, juridique ou culturel
défini par l'Union européenne ou par l'État.

## Contribuer

Voir [CONTRIBUTING.md](CONTRIBUTING.md).

## Licence

Licence Ouverte 2.0. Voir [LICENSE](LICENSE).
