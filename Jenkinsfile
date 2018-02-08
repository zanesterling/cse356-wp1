pipeline {
    agent { docker 'haskell:latest' }
    stages {
        stage('build') {
            steps {
                sh 'cabal user-config init'
                sh 'cabal update && cabal configure && cabal install'
            }
        }
    }
}
