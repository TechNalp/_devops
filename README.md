_Jeanne BLANC et Mathis PLANCHET_

# Comment lancer le projet DOCKER + DOCKER COMPOSE?

## Build des images docker

- Se mettre à la racine du projet
- Executer la commande `docker compose build`

## Lancement des containers avec docker compose

- Se mettre à la racine du projet
- Executer la commande `docker compose up`

#####**IL PEUT Y AVOIR UN PETIT DELAI AVANT TOUT LES CONTAINERS SOIT ALLUMER (À CAUSE DES DEPENDS_ON)**

## Voir que les healthchecks sont bien présent

- Executer la commande `docker compose ps`, il est bien indiqué pour les votes, redis et postgres qu'ils sont healthly

## Voir les sites web

- Attendre que tous les containers soit allumés (il est normale que le container seeder s'arrête au bout d'un moment)
- Pour voir le site web de soumission des votes, mettre http://localhost:8000 dans votre navigateur
- Pour voir le site web de consultation des votes, mettre http://localhost:4000
