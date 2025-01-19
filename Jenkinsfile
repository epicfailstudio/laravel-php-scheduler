pipeline {
    agent any
    options {
        timestamps()
        disableConcurrentBuilds()
    }
    environment {
        PACKAGE = 'laravel-php-scheduler'
        VERSION = '8.2php'
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
        stage( "Buildx" ){
            steps {
                echo "Build Machines";

                sh "docker buildx build --push --no-cache --platform linux/arm64/v8,linux/amd64 --tag $REGISTRY:$VERSION --tag $REGISTRY:latest  --builder container ./"
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