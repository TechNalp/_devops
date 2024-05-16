#!/bin/bash

gcloud compute instances create postgres-primary \
    --image-family=debian-12 \
    --image-project=debian-cloud \
    --machine-type=e2-medium \
    --zone=europe-west9-b \
    --metadata=startup-script='#! /bin/bash
  IP=`curl -s ipecho.net/plain`
  curl "https://dynamicdns.park-your-domain.com/update?host=postgres-primary&domain=mathisplanchet.com&password=72fdf4cf9d914c05968cde5842c0209d&ip=$IP"'


gcloud compute instances create postgres-standby \
    --image-family=debian-12 \
    --image-project=debian-cloud \
    --machine-type=e2-medium \
    --zone=europe-west9-b \
    --metadata=startup-script='#! /bin/bash
  IP=`curl -s ipecho.net/plain`
  curl "https://dynamicdns.park-your-domain.com/update?host=postgres-standby&domain=mathisplanchet.com&password=72fdf4cf9d914c05968cde5842c0209d&ip=$IP"'


gcloud compute instances add-tags postgres-primary --zone=europe-west9-b  --tags=db-server
gcloud compute instances add-tags postgres-standby --zone=europe-west9-b  --tags=db-server