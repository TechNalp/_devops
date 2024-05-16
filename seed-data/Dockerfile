FROM python:3.9-slim

RUN apt-get update && apt-get install --no-install-recommends -y apache2-utils; mkdir /usr/local/app
WORKDIR /usr/local/app

COPY . .

RUN python make-data.py

ENTRYPOINT [ "./generate-votes.sh" ]