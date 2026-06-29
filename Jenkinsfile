pipeline {
    agent any
    tools {
        maven 'maven'
    }

    environment {
        IMAGE_NAME = 'pagiii-app'
        CONTAINER_NAME = 'pagiii-app-container'
        APP_PORT = '8083'
    }

    stages {
        stage('Build JAR') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Run Docker Container If Not Running') {
            steps {
                script {
                    def isRunning = sh(script: "docker ps -q -f name=${CONTAINER_NAME}", returnStdout: true).trim()

                    if (isRunning) {
                        echo "🚫 Container '${CONTAINER_NAME}' is already running. Skipping run."
                    } else {
                        def exists = sh(script: "docker ps -a -q -f name=${CONTAINER_NAME}", returnStdout: true).trim()
                        if (exists) {
                            echo "🔁 Container exists but not running. Removing it..."
                            sh "docker rm ${CONTAINER_NAME}"
                        }

                        echo "🚀 Starting new Docker container..."
                        sh "docker run -d --name ${CONTAINER_NAME} -p ${APP_PORT}:8080 ${IMAGE_NAME}"
                    }
                }
            }
        }

        stage('Show Container Status') {
            steps {
                echo "📦 Current Docker containers:"
                sh "docker ps -a --filter name=${CONTAINER_NAME}"
            }
        }
    }

    post {
        success {
            echo "✅ Spring Boot container is handled successfully."
        }
        failure {
            echo "❌ Something went wrong with the deployment."
        }
        always {
            echo "ℹ️ Pipeline finished. Check logs above for final status."
        }
    }
}
