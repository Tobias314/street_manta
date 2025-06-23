node {
      def app
      stage('Clone repository') {
            checkout scm
      }
      stage('Build image') {
            app = docker.build('street_manta')
      }
      stage('Test image') {
            sh """
                  docker run --rm  street_manta:latest /street_manta/backend/test.sh
            """
      }
      stage('Push image') {
            docker.withRegistry('http://localhost:90',) {
                  app.push('latest')
            }
      }
      stage('Deploy') {
            sh 'docker pull localhost:90/street_manta:latest'
            sh 'docker compose -f docker-compose.yml up -d'
      //sh 'docker stop street_manta || true'
      //sh 'docker rm street_manta || true'
      //sh 'docker run -l "traefik.http.routers.my-container.rule=Host(`redpielabs.com`)" --name street_manta -d -p 8888:8888 localhost:90/street_manta:latest'
      }
}
