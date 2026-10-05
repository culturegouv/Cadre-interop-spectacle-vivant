# Présentation du cadre

## À quoi il sert

Les données de programmation du spectacle vivant sont produites dans autant de
formats qu'il existe d'outils. Billetterie, site web, logiciel de paie, planning
technique, chacun fait très bien son travail et presque aucun n'est relié aux
autres. La conséquence est la double saisie, les erreurs en cascade, et du temps
passé à réparer le système plutôt qu'à faire le métier.

Le cadre répond à cela par une convention de description. Il ne remplace aucun
outil et ne centralise aucune donnée. Il établit une façon commune de nommer les
choses, pour que deux systèmes qui ne se connaissent pas puissent malgré tout se
comprendre.

## Ce qu'il n'est pas

Le cadre n'est pas un logiciel. Il n'est pas une base de données. Il n'est pas
une norme opposable, et son adoption est volontaire.

## Le modèle, en bref

Le cadre distingue quatre niveaux.

| Concept | Ce qu'il désigne | Classe schema.org |
| --- | --- | --- |
| L'œuvre | Le texte, la partition, le livret | `CreativeWork` |
| Le spectacle | La création, la mise en scène, la distribution | `CreativeWork` |
| La série | Le festival, la tournée, la saison, le cycle | `EventSeries` |
| La représentation | Une date, une heure, un lieu | `PerformingArtsEvent` |

Cette distinction paraît évidente énoncée ainsi. Elle ne l'est pas du tout dans
les systèmes, où tout est souvent confondu, et c'est précisément pour cela que
rien ne se recoupe automatiquement.

## Origine

Le cadre est issu d'un cycle de travail collectif conduit de décembre 2025 à
juin 2026, réunissant une soixantaine de professionnels du secteur, lieux,
éditeurs de solutions, sociétés d'auteurs, plateformes et laboratoires de
recherche.
