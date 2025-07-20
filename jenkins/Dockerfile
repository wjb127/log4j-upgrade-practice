FROM jenkins/jenkins:lts

# 루트 권한으로 패키지 설치
USER root

# Maven과 Java 17 설치
RUN apt-get update && \
    apt-get install -y \
    maven \
    openjdk-17-jdk \
    curl \
    git \
    docker.io && \
    rm -rf /var/lib/apt/lists/*

# Java 17을 기본 Java로 설정
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Jenkins 사용자로 변경
USER jenkins

# 플러그인 미리 설치
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN jenkins-plugin-cli --plugin-file /usr/share/jenkins/ref/plugins.txt

# 기본 설정 파일 복사
COPY jenkins.yaml /var/jenkins_home/casc_configs/jenkins.yaml

# 포트 노출
EXPOSE 8080
EXPOSE 50000 