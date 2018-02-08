pipeline {
    checkout master
    agent { docker 'haskell:latest' }
    stages {
        stage('build') {
            steps {
                sh 'cabal update && cabal configure && cabal install'
            }
        }
    }
}
