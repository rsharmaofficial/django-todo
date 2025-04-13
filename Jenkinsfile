pipeline {
    agent any
    stages {
        
        stage('Clone Code from GitHub') {
            steps {
                echo 'Step 1: Cloning Code...'
                git url: 'https://github.com/rsharmaofficial/django-todo.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                echo 'Step 2: Building Docker Image...'
                sh 'docker build -t django-todo .'
            }
        }

        stage('Login to DockerHub') {
            steps {
                echo 'Step 3: Logging into DockerHub...'
                withCredentials([usernamePassword(credentialsId: "dockerhub-credentials-id", passwordVariable: "dockerhubpass", usernameVariable: "dockerhubuser")]) {
                    sh "docker tag django-todo ${env.dockerhubuser}/django-todo:latest"
                    sh "docker login -u ${env.dockerhubuser} -p ${dockerhubpass}"
                    sh "docker push ${env.dockerhubuser}/django-todo:latest"
                }
            }
        }

      stage('Deploy with Docker Compose') {
    steps {
        echo 'Step 4: Restarting Docker container...'
        sh '''
            docker-compose down || true
            docker-compose pull
            docker-compose up -d
        '''
    }
}


    }
}
