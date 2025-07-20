# Jenkins 설정 가이드

## 📋 개요

이 프로젝트는 Log4j 업그레이드 연습을 위한 Jenkins 파이프라인을 포함합니다.

## 🚀 Jenkins 시작 방법

### 1. 자동 설정 (권장)

```bash
# 프로젝트 루트 디렉토리에서 실행
./jenkins/setup.sh
```

### 2. 수동 설정

```bash
# 1. Jenkins 이미지 빌드
docker build -t log4j-jenkins ./jenkins/

# 2. Docker Compose로 실행
docker-compose up -d

# 3. Jenkins 접속
# 브라우저에서 http://localhost:8081 접속
```

## 🔐 접속 정보

- **URL**: http://localhost:8081
- **관리자 계정**: admin
- **비밀번호**: admin123

## 🛠️ Jenkins 관리 명령어

### 콘솔 접속
```bash
docker exec -it log4j-jenkins bash
```

### 로그 확인
```bash
docker-compose logs -f jenkins
```

### Jenkins 중지
```bash
docker-compose down
```

### Jenkins 재시작
```bash
docker-compose restart jenkins
```

### Jenkins 데이터 완전 삭제
```bash
docker-compose down -v
docker rmi log4j-jenkins
```

## 📁 Jenkins 구성 요소

### 📂 디렉토리 구조
```
jenkins/
├── Dockerfile          # 커스텀 Jenkins 이미지
├── plugins.txt          # 설치할 플러그인 목록
├── jenkins.yaml         # Configuration as Code 설정
├── setup.sh            # 자동 설정 스크립트
└── README-Jenkins.md   # 이 파일
```

### 🔧 주요 설정

1. **Java 17** 및 **Maven 3.9** 사전 설치
2. **Blue Ocean** UI 포함
3. **Configuration as Code** 적용
4. **Docker** 지원
5. **Git** 연동

## 🏗️ 파이프라인 구성

### 파이프라인 단계

1. **환경 정보** - Java, Maven 버전 확인
2. **소스 체크아웃** - Git에서 소스 코드 가져오기
3. **Log4j 의존성 검사** - 현재 Log4j 버전 확인
4. **컴파일** - Maven 컴파일
5. **테스트** - 단위 테스트 실행
6. **패키징** - JAR 파일 생성
7. **보안 검사** - OWASP 의존성 검사
8. **애플리케이션 시작 테스트** - 실제 구동 테스트

### 파이프라인 실행 방법

1. Jenkins 웹 UI 접속 (http://localhost:8081)
2. "New Item" 클릭
3. "Pipeline" 선택
4. Pipeline script from SCM 선택
5. Git 리포지토리 URL 입력: `https://github.com/wjb127/log4j-upgrade-practice.git`
6. Script Path: `Jenkinsfile`
7. 저장 후 "Build Now" 클릭

## 🔍 Log4j 업그레이드 시나리오

### 현재 상태 확인
- Log4j 1.2.17 사용 (취약한 버전)
- 의존성 트리에서 확인 가능

### 업그레이드 단계
1. `pom.xml`에서 Log4j 버전 업데이트
2. 필요시 설정 파일 수정 (`log4j.properties` → `log4j2.xml`)
3. 코드에서 deprecated API 수정
4. 테스트 실행으로 정상 작동 확인
5. 보안 검사로 취약점 해결 확인

## 🚨 문제 해결

### Jenkins 시작 안됨
```bash
# 로그 확인
docker-compose logs jenkins

# 포트 충돌 해결
sudo lsof -i :8081
# 다른 포트 사용 시 docker-compose.yml 수정
```

### 권한 문제
```bash
# Docker 그룹에 사용자 추가
sudo usermod -aG docker $USER

# 재로그인 후 확인
groups
```

### 메모리 부족
```bash
# Docker 메모리 할당 증가
# Docker Desktop > Settings > Resources > Memory
```

## 📚 추가 학습 자료

- [Jenkins Pipeline 문법](https://www.jenkins.io/doc/book/pipeline/syntax/)
- [Configuration as Code 플러그인](https://plugins.jenkins.io/configuration-as-code/)
- [Log4j 업그레이드 가이드](https://logging.apache.org/log4j/2.x/manual/migration.html)
- [OWASP Dependency Check](https://owasp.org/www-project-dependency-check/)

## 💡 팁

1. **Blue Ocean 사용**: 더 나은 파이프라인 시각화
2. **Webhook 설정**: Git push 시 자동 빌드
3. **병렬 실행**: 여러 환경에서 동시 테스트
4. **아티팩트 저장**: 빌드 결과물 보관
5. **알림 설정**: 빌드 결과 이메일/Slack 알림 