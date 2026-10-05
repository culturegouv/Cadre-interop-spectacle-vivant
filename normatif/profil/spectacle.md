# Spectacle

L'œuvre scénique conçue pour être présentée devant un public. Correspond à
`schema:CreativeWork`.

Le spectacle regroupe les éléments artistiques qui définissent ce qui est
représenté, à savoir l'intention artistique, la mise en scène, la distribution
et les partis pris esthétiques. Il existe indépendamment des occasions
concrètes où il est présenté.

> La spécification complète de cette classe relève de la version suivante. Ce
> fichier recense les questions ouvertes.

## Questions ouvertes

**La relation entre le spectacle et les œuvres qui le composent.** Le modèle
prévoit qu'un spectacle puisse être composé de plusieurs œuvres, mais aucune
propriété n'est spécifiée pour cette relation. Candidats à trancher,
`isBasedOn`, `hasPart`, `workExample`.

**L'attente de `PerformanceWork`.** La communauté schema.org instruit une classe
dédiée à l'œuvre-spectacle. Faut-il spécifier maintenant sur `CreativeWork` en
prévoyant une migration, ou attendre la publication.

**L'identité dans le temps.** Une reprise ou une recréation constitue-t-elle le
même spectacle.

**La distribution.** Le premier cycle a tranché qu'une variation de distribution
ne crée pas un nouveau spectacle dès lors que la mise en scène et l'identité
artistique demeurent. Reste à spécifier comment représenter la distribution
stable et ses variations ponctuelles.
