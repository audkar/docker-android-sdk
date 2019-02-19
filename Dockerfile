FROM openjdk:8-jdk-alpine
MAINTAINER Audrius Karosevicius <audrius.karosevicius@gmail.com>

ENV ANDROID_HOME /opt/android-sdk
ENV PATH "${ANDROID_HOME}/tools/bin:/opt/gtk/bin:${PATH}"

RUN GLIBC_VERSION="2.29-r0" \
    && apk update \
    && apk upgrade \
    && apk add --no-cache --virtual=.build-dependencies bash wget git unzip curl \
    && wget https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub -O /etc/apk/keys/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk -O /tmp/glibc.apk \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk -O /tmp/glibc-bin.apk \
    && apk add --no-cache /tmp/glibc.apk /tmp/glibc-bin.apk \
    && rm -rf /tmp/* \
    && rm -rf /var/cache/apk/*

#Releases https://dl.google.com/android/repository/repository2-1.xml
RUN SDK_BUILD="4333796" SDK_CHECKSUM="8c7c28554a32318461802c1291d76fccfafde054" \
    && wget -q https://dl.google.com/android/repository/sdk-tools-linux-"$SDK_BUILD".zip \
    && echo "$SDK_CHECKSUM *sdk-tools-linux-$SDK_BUILD.zip" | sha1sum -c - \
    && mkdir -p /opt \
    && unzip -qq sdk-tools-linux-"$SDK_BUILD".zip -d /opt/android-sdk \
    && rm sdk-tools-linux-"$SDK_BUILD".zip \
    && yes | sdkmanager --licenses \
    && yes | sdkmanager "build-tools;28.0.3" \
    && chmod -R 777 $ANDROID_HOME \
    && touch /root/.android/repositories.cfg

