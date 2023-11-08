node {
    def app
    stage('Clone repository') {
        checkout scm
    }

    stage('Build image') {
       app = docker.build("ballesterosd/tp7")
    }

    stage('Test image') {
        app.inside {
            sh 'echo "Tests passed"'
        }
    }

    stage('Push image') {
        docker.withRegistry('https://registry.hub.docker.com', 'git') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
}

//https://index.docker.io/v1/  