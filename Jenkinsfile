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

             ansiColor('xterm') {
           sh 'terraform init' 
           
         }        
        }
       }                   
      

 

  // Run terraform plan
stage('plan ') {
    node {
       withCredentials([[
      
     $class: 'VaultTokenCredentialBinding', 
        // This token is the name of the GitHub Token you stored on Jenkins 
   credentialsId: 'vault-github-access-token']])  
        // This is the name of the vault server that you launced  
   //vaultAddr: 'http://d5ee48b1.ngrok.io'
         {    ansiColor('xterm') {
  
        // values will be masked
        sh 'echo TOKEN=$VAULT_TOKEN'
        sh 'echo ADDR=$VAULT_ADDR'
           //Below is the identification required by 
        sh 'terraform plan -var="TOKEN=$VAULT_TOKEN"' 
           
         }        
        }
       }                   
      }                  
      
  
  

  if (env.BRANCH_NAME == 'master') {
    
    // Run terraform apply
stage('apply') {
    node {
   
    def secrets = [
        [path: 'kv-v1/new', engineVersion: 1, secretValues: [
            [envVar: 'testing', vaultKey: 'githubtoken']]]]

    // optional configuration, if you do not provide this the next higher configuration
    // (e.g. folder or global) will be used
    def configuration = [vaultUrl: 'http://d5ee48b1.ngrok.io',
                         vaultCredentialId: '403token',
                         engineVersion: 1]
    // inside this block your credentials will be available as env variables
    withVault([configuration: configuration, vaultSecrets: secrets]) {
        sh 'echo $testing'
      sh 'terraform apply -auto-approve -var="TOKEN=$testing"'
      
      // terraform apply -var-file="testing.tfvars"
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
      
      $class: 'VaultTokenCredentialBinding', 
   credentialsId: 'vault-github-access-token', 
   vaultAddr: 'http://d5ee48b1.ngrok.io']]) 
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
