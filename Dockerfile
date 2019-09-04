FROM alpine:latest

# Install required packages
RUN apk --no-cache add curl ca-certificates python jq bash

# Install gcloud
RUN curl -LO https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-245.0.0-linux-x86_64.tar.gz
RUN tar xvfz /google-cloud-sdk-245.0.0-linux-x86_64.tar.gz; rm /google-cloud-sdk-245.0.0-linux-x86_64.tar.gz
RUN ln -s /google-cloud-sdk/bin/gcloud /usr/local/bin/gcloud
RUN ln -s /google-cloud-sdk/bin/gsutil /usr/local/bin/gsutil

COPY docker-entrypoint.py /
COPY startup.sh /

RUN chmod +x /startup.sh
RUN chmod +x /docker-entrypoint.py

ENTRYPOINT ["/docker-entrypoint.py"]

CMD ["/startup.sh"]
