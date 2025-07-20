# Log4j 업그레이드 연습 프로젝트

취약한 Log4j 1.2.x 버전에서 최신 버전으로 업그레이드하는 과정을 연습하기 위한 Spring 웹 애플리케이션입니다.

## ⚠️ 보안 경고

이 프로젝트는 **의도적으로 취약한 Log4j 1.2.17 버전**을 사용합니다. 
**프로덕션 환경에서는 절대 사용하지 마세요!**

## 프로젝트 개요

### 현재 기술 스택 (취약한 버전)
- **Log4j 1.2.17** (보안 취약점 존재)
- Spring Framework 4.3.30
- Java 8
- H2 Database (메모리)
- JSP + JSTL
- Maven

### 주요 기능
- 사용자 관리 시스템 (CRUD)
- Log4j 1.2.x 로깅 시스템
- 웹 기반 UI
- 샘플 데이터 자동 생성

## 설치 및 실행

### 사전 요구사항
- Java 8 이상
- Maven 3.6 이상

### 실행 방법

1. **프로젝트 클론**
   ```bash
   git clone <repository-url>
   cd log4j-upgrade-practice
   ```

2. **Jenkins 설정 (선택사항)**
   Log4j 업그레이드를 Jenkins 파이프라인으로 연습하려면:
   
   ```bash
   # Jenkins 자동 설정 및 시작
   ./jenkins/setup.sh
   
   # Jenkins 접속: http://localhost:8081
   # 계정: admin / 비밀번호: admin123
   ```
   
   자세한 내용은 [Jenkins 설정 가이드](jenkins/README-Jenkins.md)를 참조하세요.

3. **Maven 의존성 설치**
   ```bash
   mvn clean install
   ```

4. **Tomcat 서버 실행**
   ```bash
   mvn tomcat7:run
   ```

5. **웹 브라우저에서 접속**
   ```
   http://localhost:8080
   ```

### 기본 사용자 데이터
애플리케이션 시작 시 다음 사용자들이 자동으로 생성됩니다:
- admin (admin@example.com) - 관리자
- user1 (user1@example.com) - 홍길동  
- user2 (user2@example.com) - 김철수

## 업그레이드 연습 가이드

### 1단계: 현재 상태 분석
```bash
# 현재 Log4j 버전 확인
mvn dependency:tree | grep log4j

# 보안 취약점 스캔
mvn org.owasp:dependency-check-maven:check
```

### 2단계: 백업 생성
```bash
# 현재 상태 백업
git add -A
git commit -m "백업: Log4j 1.2.x 버전"
```

### 3단계: pom.xml 수정 연습
다음 변경사항을 적용해보세요:

#### Option 1: Log4j 2.x로 업그레이드
```xml
<!-- 기존 Log4j 1.2.x 제거 -->
<!-- 
<dependency>
    <groupId>log4j</groupId>
    <artifactId>log4j</artifactId>
    <version>1.2.17</version>
</dependency>
-->

<!-- Log4j 2.x 추가 -->
<dependency>
    <groupId>org.apache.logging.log4j</groupId>
    <artifactId>log4j-core</artifactId>
    <version>2.20.0</version>
</dependency>
<dependency>
    <groupId>org.apache.logging.log4j</groupId>
    <artifactId>log4j-slf4j-impl</artifactId>
    <version>2.20.0</version>
</dependency>
```

#### Option 2: Logback으로 마이그레이션
```xml
<!-- 기존 Log4j 1.2.x 제거 -->
<!-- slf4j-log4j12도 함께 제거 -->

<!-- Logback 추가 -->
<dependency>
    <groupId>ch.qos.logback</groupId>
    <artifactId>logback-classic</artifactId>
    <version>1.2.12</version>
</dependency>
```

### 4단계: 설정 파일 마이그레이션

#### Log4j 2.x 설정 (log4j2.xml)
```xml
<?xml version="1.0" encoding="UTF-8"?>
<Configuration status="WARN">
    <Appenders>
        <Console name="Console" target="SYSTEM_OUT">
            <PatternLayout pattern="%d{yyyy-MM-dd HH:mm:ss} [%5p] %c{1}:%L - %m%n"/>
        </Console>
    </Appenders>
    <Loggers>
        <Logger name="com.example" level="DEBUG"/>
        <Root level="INFO">
            <AppenderRef ref="Console"/>
        </Root>
    </Loggers>
</Configuration>
```

#### Logback 설정 (logback.xml)
```xml
<configuration>
    <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss} [%5p] %c{1}:%L - %m%n</pattern>
        </encoder>
    </appender>
    
    <logger name="com.example" level="DEBUG"/>
    <root level="INFO">
        <appender-ref ref="STDOUT"/>
    </root>
</configuration>
```

### 5단계: 코드 수정
```java
// 기존 Log4j 1.2.x import 제거
// import org.apache.log4j.Logger;

// SLF4J 사용으로 변경 (권장)
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class UserService {
    // 기존
    // private static final Logger logger = Logger.getLogger(UserService.class);
    
    // 변경
    private static final Logger logger = LoggerFactory.getLogger(UserService.class);
}
```

### 6단계: 테스트 및 검증
```bash
# 애플리케이션 재시작
mvn clean tomcat7:run

# 로그 출력 확인
# 브라우저에서 기능 테스트
```

## 문제 해결

### 일반적인 문제들

1. **ClassNotFoundException**: 이전 Log4j 클래스가 남아있는 경우
   - `mvn clean` 후 재시도

2. **설정 파일 인식 안됨**: 
   - 파일명과 위치 확인 (src/main/resources/)
   - XML 문법 오류 확인

3. **의존성 충돌**:
   - `mvn dependency:tree`로 충돌 확인
   - exclusion 태그 사용

## 추가 학습 자료

- [Log4j 2 Migration Guide](https://logging.apache.org/log4j/2.x/manual/migration.html)
- [Logback Migration](http://logback.qos.ch/reasonsToSwitch.html)
- [OWASP Dependency Check](https://owasp.org/www-project-dependency-check/)

## 라이센스

이 프로젝트는 교육 목적으로만 사용되며, MIT 라이센스를 따릅니다. 