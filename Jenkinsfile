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
      tty: true
      command:
        - cat
      volumeMounts:
        - name: workspace-volume
          mountPath: /workspace
    - name: git
      image: alpine/git:2.40.1
      tty: true
      command:
        - cat
      volumeMounts:
        - name: workspace-volume
          mountPath: /workspace
  volumes:
    - name: workspace-volume
      emptyDir: {}
"""
    }
  }

  environment {
    ECR_REGISTRY = "020236748758.dkr.ecr.us-east-1.amazonaws.com"
    IMAGE_NAME   = "ecr-repo-18062025214500"
    IMAGE_TAG    = "v1.0.${BUILD_NUMBER}"
    COMMIT_EMAIL = "jenkins@localhost"
    COMMIT_NAME  = "jenkins"
  }
  stages {
    stage('Build & Push Docker Image') {
  steps {
    container('git') {
      withCredentials([usernamePassword(
          credentialsId: 'github-token',
          usernameVariable: 'GITHUB_USER',
          passwordVariable: 'GITHUB_PAT'
      )]) {
        sh '''
          git clone https://$GITHUB_USER:$GITHUB_PAT@github.com/$GITHUB_USER/goit-devops-hw.git
          cd goit-devops-hw
          git checkout lesson-fp
          cd django
          cp -r . /workspace/
        '''
      }
    }
    container('kaniko') {
      sh '''
        /kaniko/executor \
          --context /workspace \
          --dockerfile /workspace/Dockerfile \
          --destination=$ECR_REGISTRY/$IMAGE_NAME:$IMAGE_TAG \
          --cache=true
      '''
    }
  }
}

stage('Update Chart Tag in Git') {
  steps {
    container('git') {
      withCredentials([usernamePassword(
          credentialsId: 'github-token',
          usernameVariable: 'GITHUB_USER',
          passwordVariable: 'GITHUB_PAT'
      )]) {
        sh '''
          cd goit-devops-hw
          git checkout lesson-fp
          cd charts/django-app
          sed -i "s/tag: .*/tag: $IMAGE_TAG/" values.yaml
          git config user.email "$COMMIT_EMAIL"
          git config user.name "$COMMIT_NAME"
          git add values.yaml
          git commit -m "Update image tag to $IMAGE_TAG"
          git push origin lesson-fp
        '''
      }
    }
  }
}


  }
}