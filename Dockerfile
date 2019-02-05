FROM maven:3.6.0-jdk-8-alpine
MAINTAINER Gr1d Team <http://gr1d.io>

# maven
RUN apk add --update ca-certificates zip git unzip netcat-openbsd wget maven

# gravitee
ARG GRAVITEEIO_VERSION=1.22.1
ENV GRAVITEEIO_HOME /opt/graviteeio-gateway
RUN mkdir -p /opt/graviteeio-gateway

RUN wget https://download.gravitee.io/graviteeio-apim/distributions/graviteeio-full-${GRAVITEEIO_VERSION}.zip --no-check-certificate -P /tmp/ \
    && unzip /tmp/graviteeio-full-${GRAVITEEIO_VERSION}.zip -d /tmp/ \
    && mv /tmp/graviteeio-full-${GRAVITEEIO_VERSION}/graviteeio-gateway-${GRAVITEEIO_VERSION}/* ${GRAVITEEIO_HOME} \
    && rm -rf /tmp/*

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

# user permisson
RUN addgroup -g 1000 gravitee \
    && adduser -D -u 1000 -G gravitee -h ${GRAVITEEIO_HOME} gravitee \
    && chown -R gravitee:gravitee ${GRAVITEEIO_HOME}

USER 1000

WORKDIR ${GRAVITEEIO_HOME}

# final touches
EXPOSE 8082
VOLUME ["/opt/graviteeio-gateway/logs"]
CMD ["./bin/gravitee"]