@Library('pipeline@master') _

pipeline {
  agent { label 'docker' }
  options {
    skipDefaultCheckout()
    disableConcurrentBuilds()
    timeout(time: 1, unit: 'HOURS')
  }
  parameters {
    string(defaultValue: "a1dutch", description: '', name: 'REPOSITORY')
    string(defaultValue: "", description: '', name: 'VERSION')
  }
  environment {
    ARTIFACT_VERSIONED="${REPOSITORY}/apt-cacher:${VERSION}"
    ARTIFACT_LATEST="${REPOSITORY}/apt-cacher:latest"
  }
  stages {
    stage('Validate') {
      steps {
        script {
            if (!VERSION) {
              throw new Exception("Version must be supplied, version: '${VERSION}'")
            }
        }
      }
    }
    stage('Checkout') {
      steps {
        checkout(scm)
      }
    }
    stage('Build') {
      steps {
        sh("docker build -t ${ARTIFACT_VERSIONED} .")
        sh("docker tag ${ARTIFACT_VERSIONED} ${ARTIFACT_LATEST}")
        sh("docker push ${ARTIFACT_VERSIONED}")
        sh("docker push ${ARTIFACT_LATEST}")
      }
    }
  }
}
