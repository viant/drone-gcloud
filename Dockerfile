FROM alpine:latest

# Set gcloud version
ARG GCLOUD_VERSION=269.0.0

# Install required packages
RUN apk --no-cache add curl ca-certificates python jq bash py-yaml

# Install gcloud
RUN curl -LO https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz
RUN tar xvfz /google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz; rm /google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz
RUN ln -s /google-cloud-sdk/bin/gcloud /usr/local/bin/gcloud
RUN ln -s /google-cloud-sdk/bin/gsutil /usr/local/bin/gsutil

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl

COPY entrypoint.yaml /
COPY docker-entrypoint.py /
COPY startup.sh /

RUN chmod +x /startup.sh
RUN chmod +x /docker-entrypoint.py

ENTRYPOINT ["/docker-entrypoint.py"]

CMD ["/startup.sh"]
