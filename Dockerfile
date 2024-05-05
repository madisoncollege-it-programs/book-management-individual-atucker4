FROM tomcat:9.0.74-jdk11
COPY target/BookManagement.war /usr/local/tomcat/webapps/BookManagement.war