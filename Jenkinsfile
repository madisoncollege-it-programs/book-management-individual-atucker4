pipeline { 
    agent any  

    tools { 
        maven 'maven3.8.6' 
        jdk 'jdk11' 
    }
    stages{
        stage ('Build Application') {
            steps {
                sh 'mvn -B -DskipTests clean package' 
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t at/bookmanagement .'
            }
        }
        
        stage('Push Docker Image to ECR') {
            steps {
                script {
                    sh "aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 381492124763.dkr.ecr.us-east-1.amazonaws.com"
                    sh "docker tag bookmanagement:latest 381492124763.dkr.ecr.us-east-1.amazonaws.com/bookmanagement:latest"
                    sh "docker push 381492124763.dkr.ecr.us-east-1.amazonaws.com/bookmanagement:latest"
                }
            }
        }

        stage('Update ECS Task'){
            steps {
                script {
                    sh "aws ecs update-service --service BookManagementService --cluster BookManagementCluster --force-new-deployment"
                    sh "aws ecs wait services-stable --cluster BookManagementCluster --services BookManagementService"
                }

            }

        }
    }
}

