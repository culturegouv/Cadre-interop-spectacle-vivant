#!/usr/bin/env python3
"""
Valide des fichiers JSON-LD contre les règles SHACL du cadre.

La validation substitue le contexte local au contexte distant de schema.org.
Les exemples publiés doivent continuer à référencer https://schema.org, qui est
ce que lisent les moteurs de recherche. Le contexte local sert uniquement à
rendre la validation reproductible et indépendante du réseau.

Usage
    python3 outils/valider.py exemples/01-representation-opera.jsonld
    python3 outils/valider.py exemples/*.jsonld
    python3 outils/valider.py --attendu-invalide exemples/invalides/*.jsonld
"""

import json
import pathlib
import sys

from pyshacl import validate
from rdflib import Graph

RACINE = pathlib.Path(__file__).resolve().parent.parent
VERSION = "v0.1"
FORMES = RACINE / "normatif" / "formes" / VERSION / "cidsv.shapes.ttl"
CONTEXTE = RACINE / "normatif" / "contexte" / VERSION / "cidsv.jsonld"


def charger_contexte():
    return json.loads(CONTEXTE.read_text(encoding="utf-8"))["@context"]


def graphe_depuis(fichier, contexte):
    doc = json.loads(pathlib.Path(fichier).read_text(encoding="utf-8"))
    doc["@context"] = contexte
    graphe = Graph()
    graphe.parse(data=json.dumps(doc), format="json-ld")
    return graphe


def main(args):
    attendu_invalide = "--attendu-invalide" in args
    fichiers = [a for a in args if not a.startswith("--")]

    if not fichiers:
        print(__doc__)
        return 2

    contexte = charger_contexte()
    formes = Graph().parse(str(FORMES), format="turtle")
    echecs = 0

    for fichier in fichiers:
        print(f"--- {fichier}")
        try:
            donnees = graphe_depuis(fichier, contexte)
        except json.JSONDecodeError as erreur:
            print(f"    ECHEC  JSON invalide, {erreur}")
            echecs += 1
            continue

        conforme, _, rapport = validate(
            donnees, shacl_graph=formes, advanced=True, inference="none"
        )

        if attendu_invalide:
            if conforme:
                print("    ECHEC  ce fichier aurait du etre rejete, "
                      "la regle correspondante est inactive")
                echecs += 1
            else:
                messages = [l.strip() for l in rapport.splitlines()
                            if "Message:" in l]
                print(f"    rejete comme attendu, {len(messages)} message(s)")
                for m in messages:
                    print(f"      {m}")
        else:
            if conforme:
                print(f"    conforme, {len(donnees)} triplets")
            else:
                print(rapport)
                echecs += 1

    print()
    if echecs:
        print(f"==> {echecs} fichier(s) en echec")
        return 1
    print(f"==> {len(fichiers)} fichier(s) conforme(s) au resultat attendu")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
