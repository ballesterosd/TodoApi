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

        stage('Stop and Remove Existing Container') {
            steps {
                script {
                    String existingContainerOutput = sh(script: "docker ps -a -q --filter ancestor=${DOCKER_IMAGE_NAME}", returnStdout: true)
                    if (existingContainerOutput != null) {
                        def existingContainerIds = existingContainerOutput.split("\n")
                        for (existingContainerId in existingContainerIds) {
                            echo "Deteniendo y eliminando el contenedor existente con ID ${existingContainerId}..."
                            sh "docker stop $existingContainerId"
                            sh "docker rm $existingContainerId"
                            echo "Contenedor existente detenido y eliminado con éxito."
                        }
                    }
                }
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
                    docker.image("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}").withRun("-p 5273:5273") {
                        def existingContainerId = sh(script: "docker ps -q --filter ancestor=${DOCKER_IMAGE_NAME}", returnStdout: true)
                        echo "Ejecutando el contenedor Docker... ${existingContainerId}"                        
                        sh "docker exec ${existingContainerId} curl -X GET http://localhost:5273/api/TodoItems"
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