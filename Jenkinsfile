pipeline {
  agent {
    kubernetes {
      yaml """
apiVersion: v1
kind: Pod
metadata:
  labels:
    some-label: jenkins-kaniko
spec:
  serviceAccountName: jenkins-sa
  containers:
    - name: kaniko
      image: gcr.io/kaniko-project/executor:v1.16.0-debug
      imagePullPolicy: Always
      command:
        - sleep
      args:
        - 99d
"""
    }
  }
  environment {
    ECR_REGISTRY = "804054839611.dkr.ecr.eu-central-1.amazonaws.com"
    IMAGE_NAME   = "ecr-repo-18062025214500"
    IMAGE_TAG    = "v1.0.${BUILD_NUMBER}"
    COMMIT_EMAIL = "jenkins@localhost"
    COMMIT_NAME  = "jenkins"
  }
  stages {
    stage('Build & Push Docker Image') {
      steps {
        container('kaniko') {
          sh '''
            /kaniko/executor \\
              --context `pwd` \\
              --dockerfile `pwd`/Dockerfile \\
              --destination=$ECR_REGISTRY/$IMAGE_NAME:$IMAGE_TAG \\
              --cache=true \\
              --insecure \\
              --skip-tls-verify
          '''
        }
      }
    }
    stage('Update Chart Tag in Git') {
      steps {
        container('git') {
          withCredentials([usernamePassword(credentialsId: 'github-token', usernameVariable: ${github_user}, passwordVariable: ${github_pat})]) {
            sh '''
              git clone https://${github_user}:${github_pat}@github.com/${github_user}/devops.git
              git checkout -b lesson-7
              cd devops/charts/django-app
              sed -i "s/tag: .*/tag: $IMAGE_TAG/" values.yaml
              git config user.email "$COMMIT_EMAIL"
              git config user.name "$COMMIT_NAME"
              git add values.yaml
              git commit -m "Update image tag to $IMAGE_TAG"
              git push origin lesson-7
            '''
          }
        }
      }
    }
  }
}