pipeline {
    agent any
    
    environment {
        JAVA_HOME = '/usr/lib/jvm/java-17-openjdk-amd64'
        MAVEN_HOME = '/usr/share/maven'
        PATH = "${MAVEN_HOME}/bin:${JAVA_HOME}/bin:${env.PATH}"
    }
    
    tools {
        maven 'Maven-3.9'
        jdk 'Java-17'
    }
    
    options {
        buildDiscarder(logRotator(numToKeepStr: '10'))
        timeout(time: 30, unit: 'MINUTES')
        timestamps()
    }
    
    stages {
        stage('환경 정보') {
            steps {
                echo '=== 환경 정보 출력 ==='
                sh 'java -version'
                sh 'mvn -version'
                sh 'echo "JAVA_HOME: $JAVA_HOME"'
                sh 'echo "MAVEN_HOME: $MAVEN_HOME"'
            }
        }
        
        stage('소스 체크아웃') {
            steps {
                echo '=== 소스 코드 체크아웃 ==='
                checkout scm
                sh 'ls -la'
            }
        }
        
        stage('Log4j 의존성 검사') {
            steps {
                echo '=== Log4j 의존성 검사 ==='
                script {
                    sh 'mvn dependency:tree | grep -i log4j || echo "Log4j 의존성을 찾을 수 없습니다"'
                    sh 'mvn dependency:tree > dependency-tree.txt'
                    archiveArtifacts artifacts: 'dependency-tree.txt', allowEmptyArchive: true
                }
            }
        }
        
        stage('컴파일') {
            steps {
                echo '=== Maven 컴파일 ==='
                sh 'mvn clean compile -DskipTests'
            }
        }
        
        stage('테스트') {
            steps {
                echo '=== 단위 테스트 실행 ==='
                sh 'mvn test'
            }
            post {
                always {
                    junit allowEmptyResults: true, testResultsPattern: 'target/surefire-reports/*.xml'
                }
            }
        }
        
        stage('패키징') {
            steps {
                echo '=== JAR 파일 생성 ==='
                sh 'mvn package -DskipTests'
            }
        }
        
        stage('보안 검사') {
            steps {
                echo '=== Log4j 취약점 검사 ==='
                script {
                    // OWASP Dependency Check 실행 (옵션)
                    try {
                        sh 'mvn org.owasp:dependency-check-maven:check'
                        publishHTML([
                            allowMissing: false,
                            alwaysLinkToLastBuild: true,
                            keepAll: true,
                            reportDir: 'target',
                            reportFiles: 'dependency-check-report.html',
                            reportName: 'OWASP Dependency Check Report'
                        ])
                    } catch (Exception e) {
                        echo "OWASP Dependency Check 실행 중 오류: ${e.getMessage()}"
                    }
                }
            }
        }
        
        stage('애플리케이션 시작 테스트') {
            steps {
                echo '=== 애플리케이션 시작 테스트 ==='
                script {
                    sh """
                        # 백그라운드에서 애플리케이션 시작
                        nohup mvn spring-boot:run > app.log 2>&1 &
                        APP_PID=\$!
                        echo "애플리케이션 PID: \$APP_PID"
                        
                        # 애플리케이션이 시작될 때까지 대기
                        sleep 30
                        
                        # 헬스 체크
                        if curl -f http://localhost:8080/; then
                            echo "애플리케이션이 성공적으로 시작되었습니다"
                        else
                            echo "애플리케이션 시작 실패"
                            exit 1
                        fi
                        
                        # 애플리케이션 종료
                        kill \$APP_PID || true
                        sleep 5
                    """
                }
            }
            post {
                always {
                    archiveArtifacts artifacts: 'app.log', allowEmptyArchive: true
                }
            }
        }
    }
    
    post {
        always {
            echo '=== 빌드 완료 ==='
            cleanWs()
        }
        success {
            echo '=== 빌드 성공! ==='
        }
        failure {
            echo '=== 빌드 실패! ==='
        }
        unstable {
            echo '=== 빌드 불안정 ==='
        }
    }
} 