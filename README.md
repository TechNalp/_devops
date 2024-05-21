_Jeanne BLANC et Mathis PLANCHET_

# PROJET ANSIBLE

**(Nous supposons que vous avez déjà mis vos images docker sur le dépot de GPC)**

## Etape 1 (Mise en place d'une bdd)

- Se mettre dans le dossier `ansible/etape1`
- Créer une instance VM sur google cloud platform, directement depuis le dashboard ou avec la commande suivante:
  `gcloud compute instances create postgres \
--image-family=debian-12 \
--image-project=debian-cloud \
--machine-type=e2-medium \
--zone=europe-west9-b`

- Modifier le fichier `ansible/etape1/inventories/all.yaml` en modifiant `ansible_host`par l'address ip externe de votre vm, modifier `ansible_user` par le nom d'utilisateur de votre vm et modifier `ansible_ssh_private_key_file` en mettant le chemin vers la clé ssh de google cloud platform

- Créer une règle de parefeu sur GCP ouvrnant le port `5432` en indiquant dans cette règle que les vms concerné ont le tag `db-server`.

- Executer la commande suivante: `gcloud compute instances add-tags postgres --zone=europe-west9-b  --tags=db-server`

- Modifier l'ip présente dans `kubernetes/k8s_endpointSlice.yaml` en mettant l'ip externe de votre vm.

- Être dans le dossier `ansible/etape1` et lancer la commande `ansible-playbook deploy_postgres.yaml`

- Lancer les ressources kubernetes avec la commande `kubectl apply -f kubernetes`

## Etape 2 (Mise en place backup avec ou sans stream)

- Se mettre dans le dossier `ansible/etape2`
- Si vous ne l'avez pas fait pour l'étape 1, modifiez les informations de `ansible/etape2/inventories/all.yaml`

- S'assurer que l'ip présente dans `kubernetes/k8s_endpointSlice.yaml` est la bonne.

- S'assurer que le fichier `ansible/etape3/inventories/all.yaml` est bien configuré pour votre vm et votre clé ssh

Nous supposons que vous avez créé et configuré la vm comme indiqué à l'étape 1.

- Si nécessaire relancer la commande `ansible-playbook deploy_postgres.yaml`

- Ne pas oublié de lancer les ressources kubernetes si ce n'est pas déjà fait avec la commande `kubectl apply -f kubernetes`

- Vous pouvez lancer le seeder pour remplir la bdd si vous le souhaitez en éxecutant la commande `kubectl apply -f k8s_jobs`

#### Backup sans stream

- Executer le playbook `backup_postgres.yaml` avec la commande `ansible-playbook backup_postgres.yaml`. Normalement un dossier `backups` est apparu est un contient un fichier de dump.

#### Backup avec stream

_(Ce n'est pas un vrai stream dans le sens où tout le contenu du dump est stocké en mémoire avant d'être envoyé mais c'est un intermédiaire qui évite qu'un fichier de dump soit écrit sur le stockage du serveur)_

- Executer le playbook `backup_postgresStream.yaml` avec la commande `ansible-playbook backup_postgresStream.yaml`. Normalement un dossier `backups` est apparu (si il n'était pas déjà présent) est un contient un fichier de dump supplémentaire.

## Etape 3 (Configuration avancée)

- Se mettre dans le dossier `ansible/etape3`

- S'assurer que le fichier `ansible/etape3/inventories/all.yaml` est bien configuré pour votre vm et votre clé ssh

- S'assurer que l'ip présente dans `kubernetes/k8s_endpointSlice.yaml` est la bonne.

- Vous pouvez executer le playbook `deploy_postgresAdvanced.yaml` avec la commande `ansible-playbook deploy_postgresAdvanced.yaml`

## Etape 4 (Mise en place standby)

- Cette étape est présente sur projet finale sur la branche `main` (playbook `deploy_postgres_with_replication.yaml`)
