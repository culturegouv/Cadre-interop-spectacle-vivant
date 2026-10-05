#!/usr/bin/env bash
#
# Valide un ou plusieurs fichiers JSON-LD contre les règles du cadre.
#
# Usage
#   ./outils/valider.sh exemples/01-representation-opera.jsonld
#   ./outils/valider.sh exemples/*.jsonld
#
set -euo pipefail
RACINE="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ "$#" -eq 0 ]; then
  echo "Usage : $0 fichier.jsonld [fichier2.jsonld ...]"
  exit 1
fi

echo "==> Vérification de la syntaxe JSON"
for fichier in "$@"; do
  if python3 -m json.tool "${fichier}" > /dev/null; then
    echo "    ok  ${fichier}"
  else
    echo "    ÉCHEC  ${fichier} n'est pas un JSON valide"
    exit 1
  fi
done

echo "==> Validation SHACL"
python3 "${RACINE}/outils/valider.py" "$@"
