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

        stage('Deploy Docker Container') {
            steps {
                sh """
                if [ "\$(docker ps -q -f name=${CONTAINER_NAME})" ]; then
                    echo "🚫 Container '${CONTAINER_NAME}' is already running. Skipping run."
                else
                    docker rm -f ${CONTAINER_NAME} || true
                    echo "🚀 Starting new Docker container..."
                    docker run -d --name ${CONTAINER_NAME} -p ${APP_PORT}:8080 ${IMAGE_NAME}
                fi
                """
            }
        }

        stage('Show Container Status') {
            steps {
                echo "📦 Current Docker containers:"
                sh "docker ps -a --filter name=${CONTAINER_NAME}"
            }
        }
    }
}
