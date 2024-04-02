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
    agent any
    stages {
        stage ('Build application') {
            steps {
                sh 'pwd'
                sh 'ls -la'
                sh 'docker --version'
                // sh 'ls -la /etc/docker/'
                sh 'docker build -t go-backend .'
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
