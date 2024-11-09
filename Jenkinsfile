pipeline {
    agent any
    tools {
        maven 'my_mvn'
    }
    stages {
        stage("Checkout") {   
            steps {               	 
                git branch: 'main', url: 'https://github.com/nholuongut/manik-calculator.git'        	 
            }    
        }
        stage('Maven Clean') {
            steps {
                sh "mvn clean"  	 
            }
        }
        stage('Maven Build') {
            steps {
                sh "mvn compile"  	 
            }
        }
        stage("Unit Test") {          	 
            steps {  	 
                sh "mvn test"          	 
            }
        }
        stage("SonarQube Analysis") {
            steps {
                withCredentials([usernamePassword(credentialsId: 'sonarqube', passwordVariable: 'password', usernameVariable: 'username')]) {
                    withSonarQubeEnv('sonarqube-server') {
                        sh "mvn verify sonar:sonar -Dsonar.host.url=http://34.239.105.136:9000 -Dsonar.login=${username} -Dsonar.password=${password}"
                    }
                }
            }
        }
        stage("Maven Package") {
            steps {
                sh "mvn package"
            }
        }
        stage("Deploy On Server") {          	 
            steps {  	 
                deploy adapters: [tomcat9(credentialsId: 'tomcat-9', path: '', url: 'http://34.239.105.136:8090')], contextPath: '/manik-calculator', war: '**/target/*.war'         	 
            }
        }  	
    }
    post {
        always {
            junit 'target/surefire-reports/*.xml'
        }
        success {
            echo "App URL: http://34.239.105.136:8090/manik-calculator/"
        }
    }
}
