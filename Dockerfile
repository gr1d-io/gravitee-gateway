FROM graviteeio/gateway:1.22.1
MAINTAINER Gr1d Team <http://gr1d.io>

USER root

# maven
RUN apk add --update git maven openjdk8

# policies
RUN cd /tmp/ \
    && git clone https://github.com/gr1d-io/gravitee-policy-javascript.git \
    && cd gravitee-policy-javascript \
    && mvn clean package --batch-mode -DskipTest \
    && mv target/gravitee-policy-javascript-1.8.0.zip /opt/graviteeio-gateway/plugins/ \
    && cd .. \
    && rm -rf gravitee-policy-javascript

RUN cd /tmp/ \
    && git clone https://github.com/gr1d-io/gravitee-policy-keychain.git \
    && cd gravitee-policy-keychain \
    && mvn clean package --batch-mode -DskipTest \
    && mv target/gravitee-policy-keychain-1.8.0.zip /opt/graviteeio-gateway/plugins/ \
    && cd .. \
    && rm -rf gravitee-policy-keychain

RUN cd /tmp/ \
    && git clone https://github.com/gr1d-io/gravitee-policy-keychain-headerinjection.git \
    && cd gravitee-policy-keychain-headerinjection \
    && mvn clean package --batch-mode -DskipTest \
    && mv target/gravitee-policy-keychain-headerinjection-1.0.0.zip /opt/graviteeio-gateway/plugins/ \
    && cd .. \
    && rm -rf gravitee-policy-keychain-headerinjection

RUN cd /tmp/ \
    && git clone https://github.com/gr1d-io/gravitee-policy-access-token.git \
    && cd gravitee-policy-access-token \
    && mvn clean package --batch-mode -DskipTest \
    && mv target/gravitee-policy-keychain-access-token-1.0.0.zip /opt/graviteeio-gateway/plugins/ \
    && cd .. \
    && rm -rf gravitee-policy-access-token

RUN cd /tmp/ \
    && git clone https://github.com/gr1d-io/gravitee-policy-keychain-queryinjection.git \
    && cd gravitee-policy-keychain-queryinjection \
    && mvn clean package --batch-mode -DskipTest \
    && mv target/gravitee-policy-keychain-queryinjection-1.0.0.zip /opt/graviteeio-gateway/plugins/ \
    && cd .. \
    && rm -rf gravitee-policy-keychain-queryinjection

RUN cd /tmp/ \
    && git clone https://github.com/gr1d-io/gravitee-policy-debug.git \
    && cd gravitee-policy-debug \
    && mvn clean package --batch-mode -DskipTest \
    && mv target/gravitee-policy-debug-1.0.0.zip /opt/graviteeio-gateway/plugins/ \
    && cd .. \
    && rm -rf gravitee-policy-debug

RUN rm -rf /tmp/*

RUN apk del git maven openjdk8
RUN apk cache clean

# user permisson
RUN chown -R gravitee:gravitee ${GRAVITEEIO_HOME}

USER 1000

WORKDIR ${GRAVITEEIO_HOME}

# final touches
EXPOSE 8082
VOLUME ["/opt/graviteeio-gateway/logs"]
CMD ["./bin/gravitee"]