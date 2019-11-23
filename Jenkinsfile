pipeline {
  agent any
  stages {
    stage('Cloning GitHub repo and running Python tests') {
      steps {
        sh """
		git clone https://github.com/kastilochagin/student-exam2.git landing 
		cd landing 
		python3 -m venv venv
		. venv/bin/activate
		pip install -e '.[test]'
		coverage run -m pytest 
		coverage report
		deactivate			
		"""
        }
      }	  
	  
	stage('Building Docker image') {
	  steps {
		sh 'docker build -t kastilochagin/priv:app .'
		}
	}
	  
	stage('Logining to DockerHub and pushing the Docker image') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'DockerHub', usernameVariable: 'DockerHubUser', passwordVariable: 'DockerHubPassword')]) {
          sh "docker login -u ${env.DockerHubUser} -p ${env.DockerHubPassword}"
          sh 'docker push kastilochagin/priv:app_version${env.BUILD_ID}'
        }
      }
    }
	  
	stage('Landing directory removal') {
	  steps {
		sh """
		cd ..
		rm -rf landing
		"""
		}
	}
	 
  }
   
}