FROM alpine:3.8

# Set versions
ARG GCLOUD_VERSION=269.0.0
ARG PACKER_VERSION=1.5.5

# Install required packages
RUN apk --no-cache add curl ca-certificates python jq bash py-yaml gettext

# Install gcloud
RUN curl -LO https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz
RUN tar xvfz /google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz; rm /google-cloud-sdk-${GCLOUD_VERSION}-linux-x86_64.tar.gz
RUN ln -s /google-cloud-sdk/bin/gcloud /usr/local/bin/gcloud
RUN ln -s /google-cloud-sdk/bin/gsutil /usr/local/bin/gsutil
RUN ln -s /google-cloud-sdk/bin/bq /usr/local/bin/bq

# Install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
RUN chmod +x ./kubectl
RUN mv ./kubectl /usr/local/bin/kubectl

# Install Packer
RUN wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -O packer.zip &&\
    unzip packer.zip -d /usr/local/bin &&\
    rm -f packer.zip

COPY entrypoint.yaml /
COPY docker-entrypoint.py /
COPY startup.sh /

RUN chmod +x /startup.sh
RUN chmod +x /docker-entrypoint.py

ENTRYPOINT ["/docker-entrypoint.py"]

CMD ["/startup.sh"]
