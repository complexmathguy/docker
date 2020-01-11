##--------------------------------------------------------------
##
##  realMethods Confidential
##
##  2019 realMethods, Inc.
##  All Rights Reserved.
##
##  This file is subject to the terms and conditions defined in
##  file 'license.txt', which is part of this source code package.
##
##  Contributors :
##        realMethods Inc - General Release
##--------------------------------------------------------------
FROM registry.redhat.io/ubi8/ubi

LABEL "name"="realMethods DevOps Project Generator"
LABEL "vendor"="realMethods"
LABEL "version"="1.2"
LABEL "release"="0098"
LABEL "summary"="Model-driven tool for generating tech stack specific DevOp projects"
LABEL "description"="realMethods introduces "Project-as-Code", as single YAML file used to automate the creation of all automated aspects of DevOps include all source $

USER root

RUN yum -y update
RUN yum -y install java-1.8.0-openjdk-devel
RUN yum -y install maven git wget tar nano make gcc gcc-c++ gettext

#####################################################
## handle install of dos2unix manually
#####################################################
ADD dos2unix-7.3.3/ .
RUN make prefix=/usr/local install
RUN dos2unix

######################################################
## Install tomcat9
######################################################
ARG TOMCAT_VERSION=9.0.30
RUN wget http://apache.mirrors.ionfish.org/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/apache-tomcat-${TOMCAT_VERSION}.tar.gz
RUN tar -zxpvf apache-tomcat-${TOMCAT_VERSION}.tar.gz -C /usr/local/
RUN cd /usr/local/
RUN mv apache-tomcat-${TOMCAT_VERSION}.tar.gz apache-tomcat-${TOMCAT_VERSION}
RUN mv /usr/local/apache-tomcat-${TOMCAT_VERSION} /usr/local/tomcat
RUN echo "export CATALINA_HOME='/usr/local/tomcat/'" >> ~/.bashrc
RUN source ~/.bashrc

######################################################
## update maven to 3.6
######################################################
RUN wget http://www.realmethods.com/app/apache-maven-3.6.0-bin.tar.gz -P /tmp
RUN tar xf /tmp/apache-maven-*.tar.gz -C /opt
RUN ln -s /opt/apache-maven-3.6.0 /opt/maven
ENV M2_HOME=/opt/maven
ENV MAVEN_HOME=/opt/maven
ENV PATH="${M2_HOME}/bin:${PATH}"

######################################################
##  final session prep
######################################################
ARG appName=realmethods
ARG warfile=${appName}.war
COPY README.md .
COPY ${warfile} /usr/local/tomcat/webapps
COPY catalina.properties /usr/local/tomcat/conf
COPY server.xml /usr/local/tomcat/conf
RUN mkdir licenses
COPY ./licenses licenses

# make the app war the root war so all default requests are directed to it
RUN mv /usr/local/tomcat/webapps/${appName}.war /usr/local/tomcat/webapps/ROOT.war
RUN mv /usr/local/tomcat/webapps/ROOT /usr/local/tomcat/webapps/ROOT_OLD

RUN chmod g+rwx -R /usr/local/tomcat/conf
RUN chmod g+rwx -R /usr/local/tomcat/logs

# run tomcat
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
