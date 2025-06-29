FROM openjdk:8
EXPOSE 8082
ADD target/petclinic.war petclinic.war
ENTRYPOINT ["java","-jar","/petclinic.war"]
#I can wait to start buiding AWS code pipelines for deployments
