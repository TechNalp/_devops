_Jeanne BLANC et Mathis PLANCHET_

# Comment lancer le projet KUBERNETES

## Lancer la création d'un cluster kubernetes

- Executer la commande suivant : `gcloud container clusters create cluster --machine-type n2-standard-2 --num-nodes 3 --zone europe-west9-b`

**LA SUITE PEUT ÊTRE EFFECTUER PENDANT QUE LE CLUSTER DÉMARRE**

## Créer et connecter votre dépot d'image google cloud à docker

- Créer un artifact registry depuis le dashboard de google cloud platform dans la zone `europe-9-b`
- Utiliser la commande suivante: `gcloud auth configure-docker europe-west9-docker.pkg.dev`

## Construire et pusher les images docker

- Se mettre à la racine du projet
- Executer la commande `docker compose build`
- Executer la commande `docker compose push`

**IL FAUT QUE LE CLUSTER KUBERNETES EST FINI DE DÉMARRER AVANT DE FAIRE LA SUITE**

## Lancer toutes les ressources kubernetes

- Se mettre à la racine du projet
- Executer : `kubectl apply - f k8s_volumeClaim`
- Executer : `kubectl apply - f k8s_ressources`

## Voir les sites web

- Executer la commande `kubectl get svc`
- Récupérer les address ip externe des services `result` et `vote` et les utiliser pour se connecter (ne pas oublier d'ajouter le bon port).

## Activer le seeder

- Se mettre à la racine du projet
- Executer la commande: `kubectl apply -f k8s_jobs`
