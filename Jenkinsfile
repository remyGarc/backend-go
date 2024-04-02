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
                sh 'docker build -t go-backend .'
                sh 'docker run back-app -p 3333:3333 -p 4444:4444 go-backend'
            }
        }
        stage ('Build and publish the image') {
            container('kaniko') {
                sh '/kaniko/executor  \
                    --destination=docker.io/library/go-backend \
                    --insecure \
                    --skip-tls-verify \
                    -v=debug'
                if ($? == '0') {
                    echo 'Successfully built and published Docker image'
                }
                else {
                    error("Container exited")
                }
            }
        }
    }
}
