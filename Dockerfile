FROM openjdk:24-jdk-slim AS base

# Cài wget + tar
RUN apt-get update && apt-get install -y wget tar && rm -rf /var/lib/apt/lists/*

# Cài Tomcat
RUN wget https://archive.apache.org/dist/tomcat/tomcat-10/v10.0.27/bin/apache-tomcat-10.0.27.tar.gz \
    && tar xzf apache-tomcat-10.0.27.tar.gz \
    && mv apache-tomcat-10.0.27 /usr/local/tomcat \
    && rm apache-tomcat-10.0.27.tar.gz

ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH="$CATALINA_HOME/bin:$PATH"

# Copy war vào Tomcat
RUN rm -rf /usr/local/tomcat/webapps/*
COPY ch04_ex1_survey_sol.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["sh", "-c", "$CATALINA_HOME/bin/catalina.sh run"]
