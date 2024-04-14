pipeline {
    agent {
        label "linux-agent"
    }
    stages {
        stage('Git Checkout') {
            steps {
             echo 'Checking out our code'
            git branch: 'main', url: 'https://github.com/ooghenekaro/Petclinic-tomcat-deploy.git'
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
        timeout(time: 8, unit: "MINUTES") {
        input message: 'Can i deploy to prod ?', parameters: [choice(choices: ['Yes', 'No'], name: 'Prod-approval')], submitter: 'Anil-admin'
        }
        stage('Deploy') {
            steps {
                echo "Deploying our war file into our tomcat prod server"
               sshagent(['tomcat-pipeline']) {
                     sh "scp -o StrictHostKeyChecking=no target/petclinic.war tomcat@18.132.193.183:/opt/tomcat/webapps"
                }
            }
        }    
        
    }
}
