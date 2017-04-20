FROM centos:7
MAINTAINER Audrius Karosevicius <audrius.karosevicius@gmail.com>

ENV ANDROID_HOME=/opt/android-sdk \
    JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk

RUN yum -y install wget unzip \
    && yum -y remove git \
    && yum -y install epel-release \
    && yum -y install https://centos7.iuscommunity.org/ius-release.rpm \
    && yum -y install git2u java-1.8.0-openjdk-devel \
    && yum clean all

#Releases https://dl.google.com/android/repository/repository2-1.xml
RUN SDK_BUILD="3859397" SDK_CHECKSUM="7eab0ada7ff28487e1b340cc3d866e70bcb4286e" \
    && wget -q https://dl.google.com/android/repository/sdk-tools-linux-"$SDK_BUILD".zip \
    && echo "$SDK_CHECKSUM *sdk-tools-linux-$SDK_BUILD.zip" | sha1sum -c - \
    && unzip -qq sdk-tools-linux-"$SDK_BUILD".zip -d /opt/android-sdk \
    && rm sdk-tools-linux-"$SDK_BUILD".zip \
    && yes | $ANDROID_HOME/tools/bin/sdkmanager --licenses \
    && chmod -R 777 $ANDROID_HOME
