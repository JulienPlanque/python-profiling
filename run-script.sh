#!/bin/bash

IMAGE_NAME="mon-script-python"
SCRIPT_LIST="scripts.txt"

if [[ ! -f "$SCRIPT_LIST" ]]; then
  echo "Le fichier $SCRIPT_LIST n'existe pas."
  exit 1
fi

declare -A results

# Parcours de chaque ligne du fichier
while IFS= read -r script
do
  # Trim les espaces en début et fin de ligne
  script=$(echo "$script" | xargs)

  # Ignore les lignes vides
  if [[ -z "$script" ]]; then
    continue
  fi

  # Vérifiez si le script existe
  if [[ ! -f "$script" ]]; then
    echo "Le script $script n'existe pas."
    continue
  fi

  # Exécutez le conteneur Docker avec le script spécifié
  echo "Lancement du conteneur pour le script $script..."
  #docker run --rm --memory="4g" --memory-swap="6g" --cpus="2" -v "$PWD:/app" "$IMAGE_NAME" "$script"
  result=$(docker run --rm --memory="4g" --memory-swap="6g" --cpus="2" -v "$PWD:/app" "$IMAGE_NAME" "$script")
  docker_exit_code=$?

  # Vérifier le code de sortie de la commande Docker
  if [[ $docker_exit_code -ne 0 ]]; then
    echo "Échec du lancement du conteneur pour le script $script avec le code de sortie $docker_exit_code."
    exit $docker_exit_code
  fi
  
  # Stocker le résultat
  results["$script"]=$result
  echo "$result"


done < "$SCRIPT_LIST"

# Calculer et afficher les deltas
echo "Calcul des deltas :"
for script in "${!results[@]}"
do
  if [[ $script == *"Bad.py" ]]; then
    base_name="${script/Bad.py/}"
    good_script="${base_name}Good.py"
    if [[ -n ${results[$good_script]} ]]; then
      delta=$(awk "BEGIN {print ${results[$script]} - ${results[$good_script]}}")
      echo "Delta entre la mauvaise pratique et la bonne pratique de code pour la règle $base_name: $delta"
    fi
  fi
done

echo "Tous les scripts ont été exécutés avec succès."