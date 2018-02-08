pipeline {
    agent { docker 'haskell:latest' }
    stages {
        stage('build') {
            steps {
                sh 'cabal user-config update'
                sh 'cabal update && cabal configure && cabal install'
            }
        }
    }
}
