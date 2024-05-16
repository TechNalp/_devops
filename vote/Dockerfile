#docker build -t vote_service_image ./vote
#docker run --name vote_service --rm  -p 5001:5000 vote_service_image

FROM python:3.11-slim

RUN mkdir /app
WORKDIR /app
COPY . .

RUN pip install -r requirements.txt; apt-get update && apt-get install --no-install-recommends -y curl

ENTRYPOINT [ "python" ]

CMD ["app.py"]
