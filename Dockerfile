FROM openjdk:8-jdk
MAINTAINER Audrius Karosevicius <audrius.karosevicius@gmail.com>

ENV ANDROID_HOME=/opt/android-sdk-linux

RUN apt-get update -qq \
    && apt-get install -y --no-install-recommends wget \
    && wget -qO- https://dl.google.com/android/android-sdk_r24.4.1-linux.tgz | tar xz -C /opt \
    && mkdir "$ANDROID_HOME/licenses" || true \
    && echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > "$ANDROID_HOME/licenses/android-sdk-license" \
    && echo -e "\n8933bad161af4178b1185d1a37fbf41ea5269c55" > "$ANDROID_HOME/licenses/android-sdk-preview-license"
