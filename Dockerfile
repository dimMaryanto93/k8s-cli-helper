FROM alpine:3.18
LABEL org.label-schema.schema-version=1.23.0 maintaners="software.dimas_m@icloud.com"

ARG KUBECTL_VERSION=v1.23.14
ARG HELM_VERSION=v3.12.0

USER root
RUN apk add wget curl gettext jq git

RUN curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
RUN install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

RUN wget https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz && \
tar -zxvf helm-${HELM_VERSION}-linux-amd64.tar.gz && \
mv linux-amd64/helm /usr/local/bin/helm

ENTRYPOINT ["kubectl", "version", "--client"]