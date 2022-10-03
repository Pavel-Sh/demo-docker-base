pipeline {
    agent any

    stages {

        stage('Build Base Images') {
            steps {
                script {
                    def props = readProperties file:'tag.properties'
                    def tag17 = props['java17tag']
                    sh """sudo docker build --tag 748392735374.dkr.ecr.us-west-2.amazonaws.com/base:$tag17 ."""
                }
            }
        }

        stage('Push Base Images to Nexus') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'aws', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                        def props = readProperties file:'tag.properties'
                        def tag17 = props['java17tag']
                        sh '''
                           aws configure set aws_access_key_id ${USERNAME}
                           aws configure set aws_secret_access_key ${PASSWORD}
                           aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 748392735374.dkr.ecr.us-west-2.amazonaws.com
                           docker push 748392735374.dkr.ecr.us-west-2.amazonaws.com/base:$tag17
                        '''
                    }
                }
            }
        }
    }
}
