FROM google/cloud-sdk:slim

# Install packages
RUN apt update -y
RUN apt install -y \
    curl \
    jq

COPY docker-entrypoint.py /
COPY startup.sh /

RUN chmod +x /startup.sh
RUN chmod +x /docker-entrypoint.py

ENTRYPOINT ["/docker-entrypoint.py"]

CMD ["/startup.sh"]
