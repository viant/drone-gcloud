FROM alpine:latest

# Install required packages
RUN apk --no-cache add curl ca-certificates python jq bash

# Install gcloud
RUN curl -LO https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-194.0.0-linux-x86_64.tar.gz
RUN tar xvfz /google-cloud-sdk-194.0.0-linux-x86_64.tar.gz; rm /google-cloud-sdk-194.0.0-linux-x86_64.tar.gz

# Install kubectl
RUN curl -Lo /kubectl https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod +x /kubectl

COPY docker-entrypoint.py /
COPY startup.sh /

RUN chmod +x /startup.sh
RUN chmod +x /docker-entrypoint.py

ENTRYPOINT ["/docker-entrypoint.py"]

CMD ["/startup.sh"]
