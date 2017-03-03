FROM openjdk:8-jdk
MAINTAINER Audrius Karosevicius <audrius.karosevicius@gmail.com>

ENV SDK_VERSION=r25.2.5
ENV ANDROID_HOME=/opt/android-sdk

RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends wget \
    && wget -q https://dl.google.com/android/repository/tools_"$SDK_VERSION"-linux.zip \
    && unzip -qq tools_"$SDK_VERSION"-linux.zip -d /opt/android-sdk \
    && rm tools_"$SDK_VERSION"-linux.zip \
    && mkdir "$ANDROID_HOME/licenses" || true \
    && echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > "$ANDROID_HOME/licenses/android-sdk-license" \
    && echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > "$ANDROID_HOME/licenses/android-sdk-preview-license" \
    && chmod -R 777 $ANDROID_HOME
