#!groovy

@Library(['pipeline-lib@master']) _

def gw(String opts) {
    sh "./gradlew -PBUILD_NUMBER=${BUILD_NUMBER} ${opts}"
}

properties([
    disableConcurrentBuilds()
])

node("slave-win2016") {
    currentBuild.description = "${env.NODE_NAME} - COMMIT_LEGACY: ${env.BRANCH_NAME}"
    def COMPOSANTS_DIR = "${env.WORKSPACE}\\composants"
    try {
        stage('Init') {
            echo "Setup env vars + Ant"
            
            env.ANT = "${tool 'Ant 1.9.4 + contrib 1.0b3'}"
            env.ANT_HOME = "${env.ANT}"
            env.BDSCOMMONDIR = "C:\\Users\\jenkins\\Documents\\RAD Studio\\7.0"
            env.COMP = "${COMPOSANTS_DIR}"
            env.SVN = "${env.WORKSPACE}"
            def SEARCH_PATH = [
                "C:\\Program Files (x86)\\Devart\\ODAC for RAD Studio 2010\\Bin",
                "C:\\Program Files (x86)\\Devart\\ODAC for RAD Studio 2010\\Lib",
                "${env.BDS}\\Imports",
                "${env.BDS}\\include",
                "${env.BDS}\\lib",
                "${env.BDS}\\Lib\\Indy10",
                "C:\\Users\\jenkins\\Documents\\RAD Studio\\7.0\\Dcp",
                "${env.WORKSPACE}\\bin",
                "${env.WORKSPACE}\\Composants\\Autres\\PerlRegex",
                "${env.WORKSPACE}\\Composants\\zlib",
                "${env.WORKSPACE}\\Lib",
                "${COMPOSANTS_DIR}\\AccesBD\\DISQLite\\D2010",
                "${COMPOSANTS_DIR}\\Bin",
                "${COMPOSANTS_DIR}\\Lib",
                "${COMPOSANTS_DIR}\\Librairies\\jcl\\lib\\d14",
                "${COMPOSANTS_DIR}\\Librairies\\jcl\\source\\include",
                "${COMPOSANTS_DIR}\\Librairies\\jvcl\\common",
                "${COMPOSANTS_DIR}\\Librairies\\jvcl\\lib\\D14",
                "${COMPOSANTS_DIR}\\Librairies\\jvcl\\Resources",
                "${COMPOSANTS_DIR}\\Librairies\\jwa\\Common",
                "${COMPOSANTS_DIR}\\Librairies\\jwa\\Includes",
                "${COMPOSANTS_DIR}\\Librairies\\jwa\\Packages\\bds10",
                "${COMPOSANTS_DIR}\\pi\\PIClasses",
                "${COMPOSANTS_DIR}\\pi\\PIDB",
                "${COMPOSANTS_DIR}\\pi\\PILGPI",
                "${COMPOSANTS_DIR}\\AccesBD\\ODAC\\Lib",
                "${COMPOSANTS_DIR}\\Librairies\\jwa\\Win32API",
                "${COMPOSANTS_DIR}\\Librairies\\Imaging",
                "${COMPOSANTS_DIR}\\Librairies\\Imaging\\JpegLib",
                "${COMPOSANTS_DIR}\\Librairies\\Imaging\\Zlib"
            ]
            env.DCC_UnitSearchPath = SEARCH_PATH.join(';')
            env.FrameworkVersion = 'v2.0.50727'
            env.PATH = "${env.PATH};C:\\Windows\\Microsoft.NET\\Framework\\${FrameworkVersion}"
        }
                
        stage('Checkout') {
            checkout scm
        }

        stage('Build') {
            gw("buildCommit")
        }

        stage('Publish') {
            withCredentials([usernamePassword(credentialsId: 'jenkins_ldap', usernameVariable: 'ARTIFACTORY_USER', passwordVariable: 'ARTIFACTORY_PASSWORD')]) {
                gw("publish -x buildCommit")
            }
        }
    } catch (e) {
        currentBuild.result = 'FAILURE'
        throw e
    } finally {
    }
}
