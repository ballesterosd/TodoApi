node {
    def app
    stage('Clone repository') {
        checkout scm
    }

    stage('Build image') {
       app = docker.build("ballesterosd/tp7")
    }

    // stage('Test image') {
    //     app.inside {
    //         sh 'echo "Tests passed"'
    //     }
    // }

    stage('Push image') {
        docker.withRegistry('https://index.docker.io/v1/', 'git') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }
}