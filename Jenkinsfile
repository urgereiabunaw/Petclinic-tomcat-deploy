@Library('march-cohort-jenkins-lib')_
pipeline {
    agent {
        label "linux-agent"
    }
    stages {
        stage('Git Checkout') {
            steps {
         gitCheckout()
            }
        }
       stage ('Compile') {
                        steps {
                echo 'compiling our code'
               sh "mvn clean compile"             
 
              }
          }
        stage('Validate') {
            steps {
               echo "validating our maven build again" 
               sh "mvn clean validate"
            }
        }

      stage('Test') {
            steps {
               echo "running test on our maven build" 
               sh "mvn clean test"
            }
        }
       stage('Build') {
            steps {
                echo "packaging our project into a war file"
               sh "mvn clean install"
            }
        }

        stage('Deploy to DEV') {
            steps {
                echo "Deploying our war file into our tomcat dev server"
                sshagent(['tomcat-pipeline']) {
                     sh "scp -o StrictHostKeyChecking=no target/petclinic.war tomcat@18.132.193.183:/opt/tomcat/webapps"
                }
            }
        }    
        stage('Deploy to Stage') {
            steps {
                echo "Deploying our war file into our tomcat Stage server"

                timeout(time: 8, unit: "MINUTES") {
input message: 'Can i deploy to prod ?', parameters: [choice(choices: ['Yes', 'No'], name: 'Prod-approval')], submitter: 'Anil-admin', submitterParameter: 'admin'        }
                sshagent(['tomcat-pipeline']) {
                     sh "scp -o StrictHostKeyChecking=no target/petclinic.war tomcat@18.132.193.183:/opt/tomcat/webapps"
                }
            }
        }    
        
        stage('Deploy to Prod') {
            steps {
                echo "Deploying our war file into our tomcat prod server"

                timeout(time: 8, unit: "MINUTES") {
input message: 'Can i deploy to prod ?', parameters: [choice(choices: ['Yes', 'No'], name: 'Prod-approval')], submitter: 'Anil-admin', submitterParameter: 'admin'        }
                sshagent(['tomcat-pipeline']) {
                     sh "scp -o StrictHostKeyChecking=no target/petclinic.war tomcat@18.132.193.183:/opt/tomcat/webapps"
                }
            }
        }    
        
    }
}
