pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'make build'
            }
        }

        stage('test') {
            steps {
                sh 'make test'
            }
        }

        stage('deploy') {
            steps {
                sh 'make deploy'
            }
        }
    }
}
