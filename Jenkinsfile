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
            when {
              expression {
                currentBuild.result == null || currentBuild.result == 'SUCCESS' 
              }
            }

            steps {
                sh 'JENKINS_NODE_COOKIE=dontKillMe make deploy'
            }
        }
    }
}
