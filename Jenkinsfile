pipeline {
    checkout master
    agent { docker 'haskell:latest' }
    stages {
        stage('build') {
            steps {
                sh 'cabal configure && cabal install'
            }
        }
    }
}
