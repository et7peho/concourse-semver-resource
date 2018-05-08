FROM debian:stretch
RUN apt-get update && apt-get install -y git jq
ADD https://github.com/fsaintjacques/semver-tool/blob/master/src/semver /usr/local/bin/semver
ADD assets/* /opt/resource/
ADD test.sh /usr/local/bin/test.sh
RUN chmod u+x /opt/resource/*
