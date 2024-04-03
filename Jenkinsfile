// pipeline {
//     agent any

//     stages {
//         stage('Hello') {
//             steps {
//                 echo 'Hello World'
//             }
//         }
//     }
// }

pipeline {
    agent { docker { image "gcr.io/kaniko-project/executor:v1.14.0-debug" } }
    stages {
        stage ('Build application') {
            steps {
                sh 'pwd'
                sh 'ls -la'
                sh 'docker --version'
                // sh 'ls -la /etc/docker/'
                sh '/kaniko/executor --context . --dockerfile Dockerfile'
                // build -t go-backend .'
                // sh 'docker run back-app -p 3333:3333 -p 4444:4444 go-backend'
            }
        }
        stage ('Build and publish the image') {
            agent { docker { image "gcr.io/kaniko-project/executor:v1.14.0-debug" } }
            steps {
                script {
                    sh '/kaniko/executor  \
                        --context . \
                        --dockerfile Dockerfile \
                        --destination=docker.io/library/go-backend \
                        -v=debug'
                    if (returnStatus == 0) {
                        echo 'Successfully built and published Docker image'
                    }
                    else {
                        error 'Container exited'
                    }
                }
            }
        }
    }
}

//docker run --name jenkins-blueocean --restart=on-failure --detach --network jenkins --env DOCKER_HOST=tcp://docker:2376 --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 --volume jenkins-data:/var/jenkins_home --volume jenkins-docker-certs:/certs/client:ro -v /var/run/docker.sock:/var/run/docker.sock --publish 8080:8080 --publish 50000:50000 myjenkins-blueocean:2.440.2-1