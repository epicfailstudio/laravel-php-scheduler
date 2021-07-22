pipeline {
    agent {
        node {
            label 'master'
        }
    }
    options {
        timestamps()
        disableConcurrentBuilds()
    }
    environment {
        PACKAGE = 'laravel-php-scheduler'
        VERSION = '7.4php'
        REGISTRY = "epicfailstudio/laravel-php-scheduler"
    }
    stages {
        stage('Checkout') {
            steps {
                echo "Workspace cleanup";
                step([$class: 'WsCleanup'])

                echo "Git checkout";
                checkout scm
            }
        }
        stage( "Build" ){
            steps {
                echo "Build Machines";

                sh "docker build --no-cache --tag $PACKAGE:$BUILD_NUMBER ./"
            }
        }
        stage( "Release" ){
            steps {
                sh "docker image tag $PACKAGE:$BUILD_NUMBER $REGISTRY:latest"
                sh "docker image tag $PACKAGE:$BUILD_NUMBER $REGISTRY:$VERSION"

                sh "docker image push --all-tags $REGISTRY"
            }
        }
        stage( "Cleanup" ){
            steps {
                sh "docker rmi $REGISTRY:latest"
                sh "docker rmi $REGISTRY:$VERSION"
                sh "docker rmi laravel-php-scheduler:$BUILD_NUMBER"
            }
        }
    }
    post{
        failure {
            emailext recipientProviders: [brokenBuildSuspects(), brokenTestsSuspects()],
                    subject: '[Jenkins] Build failed: $PROJECT_NAME - #$BUILD_NUMBER',
                    to: 'mario@epicfail.sk',
                    body: '''Check console output at $BUILD_URL to view the results.

${CHANGES}

 --------------------------------------------------
${BUILD_LOG, maxLines=100, escapeHtml=false}''';
        }
        unstable {
            emailext recipientProviders: [brokenBuildSuspects(), brokenTestsSuspects()],
                    subject: '[Jenkins] Unstable build: $PROJECT_NAME - #$BUILD_NUMBER',
                    to: 'mario@epicfail.sk',
                    body: '''Check console output at $BUILD_URL to view the results.

${CHANGES}

 --------------------------------------------------
${BUILD_LOG, maxLines=100, escapeHtml=false}'''
        }
    }
}