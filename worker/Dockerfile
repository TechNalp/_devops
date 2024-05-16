#docker build -t worker_service_image ./worker
#docker run --name worker_service -d worker_service_image
FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:7.0 as builder

ARG TARGETPLATFORM
ARG TARGETARCH
ARG BUILDPLATFORM

RUN echo ${BUILDPLATFORM} ${TARGETARCH} ${TARGETPLATFORM}

RUN mkdir /app /source
COPY ./* /source
WORKDIR /source
RUN dotnet restore -a ${TARGETARCH}; 
RUN dotnet publish -c release -o /app -a ${TARGETARCH} --self-contained false --no-restore

FROM --platform=$TARGETPLATFORM mcr.microsoft.com/dotnet/runtime:7.0

WORKDIR /app
COPY --from=builder /app .

ENTRYPOINT ["dotnet"]

CMD ["Worker.dll"]
