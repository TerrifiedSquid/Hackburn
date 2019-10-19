// Jenkinsfile
// 

try {
  stage('checkout') {
    node {
      cleanWs()
      checkout scm
   }
  }


  // Run terraform init 
  stage('init') {
      node {
       withCredentials([[
      
  //   $class: 'AmazonWebServicesCredentialsBinding',
  //      credentialsId: 'awsCredentials',
  //    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
  //    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'],
                        
  //  [
      $class: 'VaultTokenCredentialBinding', 
   credentialsId: 'vault-github-access-token', 
   vaultAddr: 'http://c909c28c.ngrok.io']]) 
         {    ansiColor('xterm') {
  
        // values will be masked
        sh 'echo TOKEN=$VAULT_TOKEN'
        sh 'echo ADDR=$VAULT_ADDR'
           sh 'terraform init' 
           
         }        
        }
       }                   
      }

 

  // Run terraform plan
  stage('plan ') {
    node {
       withCredentials([[
      
 //    $class: 'AmazonWebServicesCredentialsBinding',
//        credentialsId: 'awsCredentials',
 //     accessKeyVariable: 'AWS_ACCESS_KEY_ID',
 //     secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'],
                        
  //  [
     $class: 'VaultTokenCredentialBinding', 
   credentialsId: 'vault-github-access-token', 
   vaultAddr: 'http://c909c28c.ngrok.io']]) 
         {    ansiColor('xterm') {
  
        // values will be masked
        sh 'echo TOKEN=$VAULT_TOKEN'
        sh 'echo ADDR=$VAULT_ADDR'
        sh 'terraform plan' 
           
         }        
        }
       }                   
      }
  
  

  if (env.BRANCH_NAME == 'master') {
    
    // Run terraform apply
stage('apply') {
      node {
       withCredentials([[
      
   //  $class: 'AmazonWebServicesCredentialsBinding',
  //      credentialsId: 'awsCredentials',
   //   accessKeyVariable: 'AWS_ACCESS_KEY_ID',
   //   secretKeyVariable: 'AWS_SECRET_ACCESS_KEY' ],
                        
  //  [
      $class: 'VaultTokenCredentialBinding', 
   credentialsId: 'vault-github-access-token', 
   vaultAddr: 'http://c909c28c.ngrok.io']]) 
         {    ansiColor('xterm') {
  
      //  values will be masked
        sh 'echo TOKEN=$githubtoken'
        sh 'echo ADDR=$VAULT_ADDR' 
           
           
        // sh 'terraform apply -auto-approve'
           
      
    //    sh 'vault-github-access-token' githubtoken
           
         }        
        }
       }                   
      }
    
    //Second apply stage 
    stage('apply 2') {
    node {
    // define the secrets and the env variables
    // engine version can be defined on secret, job, folder or global.
    // the default is engine version 2 unless otherwise specified globally.
  //    withCredentials([[
  //    $class: 'VaultTokenCredentialBinding', 
 //  credentialsId: 'vault-github-access-token', 
 //  vaultAddr: 'http://c909c28c.ngrok.io']])
      
      
    def secrets = [
        [path: 'kv-v1/new', engineVersion: 1, secretValues: [
            [envVar: 'testing', vaultKey: 'githubtoken'],
            [envVar: 'testing_again', vaultKey: 'githubtoken']]],
      //  [path: 'kv-v1/new', engineVersion: 2, secretValues: [
       //     [vaultKey: 'githubtoken']]]
    ]

    // optional configuration, if you do not provide this the next higher configuration
    // (e.g. folder or global) will be used
    def configuration = [vaultUrl: 'http://c909c28c.ngrok.io',
                         vaultCredentialId: '403token',
                         engineVersion: 1]
    // inside this block your credentials will be available as env variables
    withVault([configuration: configuration, vaultSecrets: secrets]) {
        sh 'echo $testing'
        sh 'echo $testing_again'
        sh 'echo $another_test'
      sh 'terraform apply -auto-approve -var="TOKEN=403token"'
    }
}
         }
    
    
    
    
    // End of "if" statement 
     } 
  

   // Run terraform show
    stage('show') {
    // Token addition
      node {
       withCredentials([[
      
 //    $class: 'AmazonWebServicesCredentialsBinding',
 //       credentialsId: 'awsCredentials',
 //     accessKeyVariable: 'AWS_ACCESS_KEY_ID',
  //    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'],
                        
   // [
      $class: 'VaultTokenCredentialBinding', 
   credentialsId: 'vault-github-access-token', 
   vaultAddr: 'http://c909c28c.ngrok.io']]) 
         {    ansiColor('xterm') {
  
        // values will be masked
        sh 'echo TOKEN=$VAULT_TOKEN'
        sh 'echo ADDR=$VAULT_ADDR'
           sh 'terraform show' 
           
         }        
        }
       }                   
      }
      
    
    
    
    
  currentBuild.result = 'SUCCESS'
}
catch (org.jenkinsci.plugins.workflow.steps.FlowInterruptedException flowError) {
  currentBuild.result = 'ABORTED'
}
catch (err) {
  currentBuild.result = 'FAILURE'
  throw err
}
finally {
  if (currentBuild.result == 'SUCCESS') {
    currentBuild.result = 'SUCCESS'
  }
}
