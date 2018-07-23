node {
   def mvnHome
   stage('Preparation') { // for display purposes
      // Get some code from a GitHub repository
      git 'https://github.com/108lirik/CI-CD-demo.git'
      // Get the Maven tool.
      // ** NOTE: This 'M3' Maven tool must be configured
      // **       in the global configuration.           
      mvnHome = tool 'my_maven'
   }
   stage('Build') {
      // Run the maven build
      if (isUnix()) {
         sh "'${mvnHome}/bin/mvn' -Dmaven.test.failure.ignore clean package -Dv=${BUILD_NUMBER}"
      } else {
         bat(/"${mvnHome}\bin\mvn" -Dmaven.test.failure.ignore clean package/)
      }
      
      sh "mv -f /var/lib/jenkins/workspace/jar_pipe/target/*.jar ./app.jar"
      
   }
   stage('Artifu') {
       def server = Artifactory.server 'my_artifactory'
       def uploadSpec = """{
       "files": [
       {
      "pattern": "target/*.jar",
      "target": "libs-release-local"
       }
       ]
       }"""

   server.upload(uploadSpec)
   }
   stage('Build2') {
      // Run docker build

      docker.withRegistry('http://localhost:5000') {
              def testImage = docker.build("app:${env.BUILD_ID}")

              testImage.push()
          }
    }
    
    stage('Ansibla'){
        sh "ansible env -i /vagrant/ansible/hosts -u vagrant -m ping"
    }
       
}
      
//   stage('Results') {
 //     junit '**/target/surefire-reports/TEST-*.xml'
 //     archive 'target/*.jar'
   
//
//   }
//}
