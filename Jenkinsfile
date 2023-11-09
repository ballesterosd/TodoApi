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
                script{
                    echo "Construyendo la imagen Docker..."
                    docker.build("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}")
                    echo "Imagen Docker construida con éxito."
                    sh "docker images" // Listar las imágenes de Docker
                }
            }
        }

        stage('Run Container and Test') {
            steps {
                script {
                    echo "Ejecutando el contenedor Docker..."
                    docker.image("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}").withRun('-p 5273:5273') {
                        sh "docker ps" // Listar los contenedores en ejecución
                        sh "docker exec ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} curl -X GET http://localhost:5273/api/TodoItems"
                    }
                    echo "Contenedor Docker ejecutado con éxito."
                }
            }
        }        

        stage('Push image') {
            steps {
                script{                
                    echo "Subiendo la imagen Docker a DockerHub..."
                    docker.withRegistry('https://index.docker.io/v1/', 'hub.docker') {
                        docker.image("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}").push()
                    }
                    echo "Imagen Docker subida con éxito."
                }
            }
        }
    }
}