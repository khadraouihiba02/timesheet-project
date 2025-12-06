pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'khadraouihiba'
        DOCKERHUB_REPO = 'timesheet-khadraouihiba-4twin4'
        IMAGE_VERSION  = '1.1'
        K8S_NAMESPACE  = 'chap4'
        K8S_DEPLOYMENT = 'timesheet-dep'
        K8S_CONTAINER  = 'timesheet'
    }

    stages {
        stage('GIT') {
            steps {
                checkout scm
            }
        }

        stage('COMPILATION') {
            steps {
                sh './mvnw clean package -DskipTests'
            }
        }

        stage('INSTALLATION') {
            steps {
                sh """
                docker build -t ${DOCKERHUB_USER}/${DOCKERHUB_REPO}:${IMAGE_VERSION} .
                echo '${DOCKERHUB_PASSWORD}' | docker login -u '${DOCKERHUB_USER}' --password-stdin
                docker push ${DOCKERHUB_USER}/${DOCKERHUB_REPO}:${IMAGE_VERSION}
                """
            }
        }

        stage('DEPLOIEMENT') {
            steps {
                sh """
                kubectl set image deployment/${K8S_DEPLOYMENT} ${K8S_CONTAINER}=${DOCKERHUB_USER}/${DOCKERHUB_REPO}:${IMAGE_VERSION} -n ${K8S_NAMESPACE}
                kubectl rollout status deployment/${K8S_DEPLOYMENT} -n ${K8S_NAMESPACE}
                """
            }
        }
    }
}
