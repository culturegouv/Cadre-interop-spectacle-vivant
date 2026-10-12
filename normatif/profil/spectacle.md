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
