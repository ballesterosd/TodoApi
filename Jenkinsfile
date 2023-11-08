pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = "ballesterosd/tp7" 
        DOCKER_IMAGE_TAG = "${env.BUILD_NUMBER}"
    }

    stages{
        stage('Clone repository') {
            steps {
                checkout scm
            }
        }

        stage('Build image') {
            steps {   
                docker.build("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}")
            }
        }

        stage('Test') {
            steps {
                docker.image("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}").withRun('-p 8080:5273') {
                    sh "docker exec ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} curl -X 'GET' 'http://localhost:5273/api/TodoItems'"
                }
            }
        }

        stage('Push image') {
            steps {
                docker.withRegistry('https://index.docker.io/v1/', 'hub.docker') {
                    docker.image("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}").push()
                }
            }
        }
    }
}