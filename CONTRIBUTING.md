# Contribuer au cadre

Le cadre est un document vivant, construit collectivement. Les contributions
sont bienvenues et suivent les règles ci-dessous.

## Trois façons de contribuer

**Signaler une erreur.** Incohérence, exemple invalide, propriété mal
référencée. Ouvrez un signalement avec le modèle prévu.

**Proposer une évolution du modèle.** Ajout ou modification d'une propriété,
d'une classe ou d'une cardinalité. Ouvrez un signalement avec le modèle
« Proposition d'évolution » avant toute proposition de modification du code.
Une évolution du modèle se discute avant de s'écrire.

**Poser une question de modélisation.** Un cas d'usage que le cadre ne couvre
pas clairement. Ces questions alimentent les cycles de travail suivants.

## La contribution la plus utile

Si vous éditez un logiciel ou si vous gérez les données d'une structure, la
contribution la plus précieuse consiste à passer un export réel de vos données
dans le validateur et à signaler ce qui échoue.

Cela prend une heure, n'engage à rien, et fournit à la démarche la ressource la
plus rare dont elle dispose, à savoir des données vraies plutôt que des exemples
fabriqués.

## Ce qu'une proposition d'évolution doit contenir

Une proposition recevable indique le besoin métier auquel elle répond, le cas
d'usage concret qui l'illustre, la propriété ou la classe schema.org visée, et
l'incidence sur les implémentations existantes.

Une proposition qui n'indique pas son cas d'usage ne peut pas être instruite.

## Processus

Les propositions sont instruites par cycles. Une évolution acceptée entre dans
la branche de travail de la version suivante et n'est pas appliquée
rétroactivement à une version publiée.

Toute modification de `normatif/` doit s'accompagner d'un exemple correspondant
dans `exemples/`, et cet exemple doit passer la validation automatique.

## Style

Le cadre est rédigé en français. Les termes techniques anglais sont conservés
entre parenthèses à leur première occurrence. Les noms de propriétés schema.org
ne sont jamais traduits.
