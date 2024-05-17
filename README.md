*Jeanne BLANC et Mathis PLANCHET*

# Comment lancer le projet ?

**NOUS SUPPOSONS QUE VOTRE GCLOUD ET KUBECTL SONT CORRECTEMENT CONFIGURÉS**

## Préparation de GCP:

- Créer un cluster kubernetes en utilisant la commande suivante : `gcloud container clusters create cluster --machine-type n2-standard-2 --num-nodes 3 --zone europe-west9-b`
- Depuis le dashboard Google Cloud Platform, créer un Artefact Repository dans la zone `europe-west9b`.

## Construction des images docker et envoi vers le dépot GCP
- Se placer dans le dossier racine du projet
- Exécuter la commande suivante pour construire les images : ```docker-compose build docker-compose.yml```
- Afin de pouvoir s'authentifier auprès du registry, il faut exécuter ensuite la commande : ```gcloud auth configure-docker europe-west9-docker.pkg.dev```
- Push des images vers le dépot distant :```docker-compose push```

## Mise en place des vms servant à postgresql
- Se placer dans le dossier racine du projet
- Exécuter le script suivant : scripts/create_vm_instance.sh (ce script est conçu pour créer les 2 machines virtuelles servant aux bases de données postgresql et servant également à configurer automatiquement les noms de domaine postgres-primary.mathisplanchet.com et postgres-standby.mathisplanchet avec les ip des vms)
- Copier l'ip externe de la vm `postgres-primary` et remplacer celle présente dans le fichier k8s_ressources/k8s_endpointSlice.yaml
- Copier l'ip externe de la vm `postgres-standby` et remplacer celle présente dans le fichier k8s_ressources/db-replica/k8s_endpointSlice.yaml

## Configuration des vms avec ansible
- Se placer dans le dossier `ansible`
- Exécuter la commande `ansible-playbook deploy_postgres_with_replication.yaml`

## Mise en place de l'infrastrucutre kubernetes
- Se placer dans le dossier racine du projet
- Exécuter la commande `kubectl apply -f k8s_ressources` (crée les ressources kubernetes du namespace default)
- Exécuter la commande `kubectl apply -f k8s_ressources/db-replica` (crée les ressources kubernetes du namespace db-replica)

## Accéder aux sites web
- Exécuter la commande `kubectl get svc -A`
- Pour accéder au site web de soumission de vote, copier la valeur de l'ip exterieur du loadbalancer nommée `vote` (si c'est en <pending>, relancer la commande jusqu'à ce que ça ne le soit plus) dans votre navigateur
- Pour accéder au site web de consultation des votes, copier la valeur de l'ip exterieur du loadbalancer nommée `result` (Si il est en <pending>, relancer la commande jusqu'à ce que ça ne le soit plus) dans votre navigateur
- **L'AFFICHAGE DES VOTES PEUT PARFOIS PRENDRE UN PEU DE TEMPS**

## Optionnel
### Lancer le seeder
- Se placer à la racine du projet
- Exécuter la commande `kubectl apply -f k8s_jobs/k8s_seeder.yaml`
