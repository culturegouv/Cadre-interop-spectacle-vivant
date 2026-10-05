# Normatif

Ce dossier fait foi. Un flux de données est conforme ou non au regard de ces
fichiers.

| Dossier | Contenu |
| --- | --- |
| `profil/` | La spécification des classes, propriété par propriété |
| `contexte/` | Le contexte JSON-LD publié, par version |
| `schema/` | Le schéma JSON de validation syntaxique, par version |
| `formes/` | Les règles de validation du graphe en SHACL, par version |

Toute modification de ce dossier déclenche une nouvelle version du cadre.

## Politique d'adressage

Chaque version publie ses fichiers à une adresse figée qui n'est jamais
modifiée, même pour corriger une erreur. Une correction donne lieu à une
nouvelle version corrective.

Un implémenteur prudent référence la version figée et migre quand il le décide.
