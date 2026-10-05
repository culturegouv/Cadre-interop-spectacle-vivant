# Versionnage

Le cadre suit le versionnage sémantique, sous la forme majeure point mineure
point corrective.

## Ce qui déclenche une version

| Type | Ce qui le déclenche | Effet pour un implémenteur |
| --- | --- | --- |
| Corrective | Correction rédactionnelle, exemple corrigé, faute dans une définition, sans changement de règle | Aucun, rien à modifier |
| Mineure | Ajout d'une propriété facultative, ajout d'une classe, assouplissement d'une contrainte | Ce qui était conforme le reste |
| Majeure | Retrait d'une propriété, passage de facultatif à obligatoire, resserrement d'une cardinalité, renommage | Rupture, un guide de migration est publié |

## La règle qui tranche

**Si un flux conforme à une version cesse de l'être à la version suivante, il
s'agit d'une version majeure.** Peu importe la taille du changement, peu importe
qu'il paraisse évident ou anodin.

Cette règle évite les discussions d'appréciation. Elle répond notamment aux
trois écarts aujourd'hui en discussion, à savoir l'identifiant obligatoire, le
statut obligatoire et le lieu facultatif sur une série. Ce sont des ruptures,
donc elles relèvent d'une version majeure.

## Politique d'adressage

Chaque version publie ses fichiers normatifs à une adresse figée, qui n'est
jamais modifiée, même pour corriger une faute de frappe.

```
.../normatif/contexte/v0.1/cidsv.jsonld      figée, ne bouge jamais
.../normatif/contexte/latest/cidsv.jsonld    pointe vers la version stable
```

Un implémenteur prudent référence la version figée et migre quand il le décide.
Un implémenteur qui souhaite suivre automatiquement référence l'adresse
courante et accepte le risque. Le cadre recommande la première pratique.

## Politique de dépréciation

Une propriété que l'on souhaite retirer n'est pas supprimée du jour au
lendemain. Elle est d'abord marquée comme dépréciée dans le profil et dans le
journal des modifications, elle produit un avertissement à la validation et non
une erreur, et elle reste valide pendant au moins une version majeure.

## Branches et étiquettes

| Élément | Rôle |
| --- | --- |
| Branche `main` | Ce qui est publié. Protégée, relecture obligatoire avant fusion |
| Branche de cycle | Une branche par cycle de travail, où s'accumulent les évolutions |
| Étiquette `v0.1.0` | Marque une publication et rend la version citable durablement |
