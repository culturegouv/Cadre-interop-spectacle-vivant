# Guide d'implémentation

> Document en cours de rédaction. Il doit permettre à un éditeur de produire un
> flux conforme en le lisant seul, sans poser de question.

## À qui s'adresse ce guide

Aux éditeurs de solutions et aux équipes techniques des structures qui
souhaitent exposer leurs données de programmation conformément au cadre.

## Démarrage rapide

1. Référencez le contexte publié dans votre document JSON-LD
2. Reprenez l'exemple `exemples/01-representation-opera.jsonld` comme modèle
3. Validez votre production avec `./outils/valider.sh votre-fichier.jsonld`
4. Corrigez les messages remontés et recommencez

## Les erreurs fréquentes

À compléter au fil des retours.

## Cas particuliers

**La série itinérante.** Une tournée n'a pas de lieu unique. La propriété
`location` est facultative sur une série, et chaque représentation porte son
propre lieu. Voir `exemples/03-serie-itinerante.jsonld`.

**La journée composite.** Un festival peut contenir des événements de natures
différentes. Voir `exemples/05-journee-composite.jsonld`.

**Les représentations hors les murs.** À documenter.

## Nous signaler un problème

Si votre cas n'est pas couvert, ouvrez un signalement avec le modèle
« Question de modélisation ». Ces questions alimentent le cycle suivant.
