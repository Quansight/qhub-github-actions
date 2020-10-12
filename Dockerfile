FROM continuumio/anaconda3:2020.02

RUN apt-get update --fix-missing && \
    apt-get install -y  bash ca-certificates curl git jq

COPY ["src", "/src/"]

ENTRYPOINT ["/src/main.sh"]
