#docker volume create db-data
#docker build -t postgres_service_image ./postgres
#docker run --name postgres_service -d -v `pwd`/healthchecks:/healthchecks -v db-data:/var/lib/postgresql/data  -p 5432:5432 postgres_service_image

FROM postgres:15-alpine

ENV POSTGRES_PASSWORD=postgres

USER postgres