# Le modèle de données

## Les quatre niveaux

Le modèle s'organise autour de quatre niveaux imbriqués. La spécification
détaillée de chacun figure dans le dossier `normatif/profil/`.

**L'œuvre** est le matériau de référence sur lequel s'appuie un spectacle, à
savoir le texte d'une pièce, une partition, un livret, un scénario. Elle existe
indépendamment de toute mise en scène.

**Le spectacle** est l'œuvre scénique conçue pour être présentée. Il regroupe
l'intention artistique, la mise en scène, la distribution et les partis pris
esthétiques. C'est ce qui reste identique d'une représentation à l'autre.

**Le regroupement de représentations** est un ensemble d'événements liés par un
cadre commun, qu'il s'agisse ou non du même spectacle. Un festival en est
l'exemple type, puisqu'il réunit des représentations de spectacles différents
sous une même bannière.

**La représentation** est l'exécution concrète, à une date, une heure et un lieu
précis, devant un public.

## Trois décisions de modélisation

Le premier cycle a tranché trois points qui méritent d'être rappelés.

**Un spectacle peut être composé de plusieurs œuvres.** C'est le cas du théâtre
lorsqu'une création assemble des textes de plusieurs auteurs, de la musique
lorsqu'un concert réunit plusieurs œuvres interprétées, et des formes hybrides.

**Une variation de distribution ne crée pas un nouveau spectacle** dès lors que
la mise en scène et l'identité artistique demeurent. Les variations ponctuelles
se rattachent aux représentations concernées.

**Les sous-classes disciplinaires ne sont pas multipliées.** L'expérience montre
que les classifications par discipline posent des difficultés de maintenance et
de périmètre, particulièrement pour les formes hybrides. Le cadre privilégie une
classe générique enrichie de propriétés descriptives.

## Distinction lieu et structure

Un lieu est un espace physique. Une structure est une personne morale. Une
structure peut exploiter plusieurs lieux, un lieu peut changer d'exploitant, et
les deux n'ont pas la même durée de vie.

La plupart des bases existantes décrivent des structures et sont présentées
comme des référentiels de lieux. Confondre les deux rend tout rapprochement
faux.
