#!/bin/bash

echo "=== Log4j Upgrade Practice - Jenkins 설정 ==="

# Docker가 설치되어 있는지 확인
if ! command -v docker &> /dev/null; then
    echo "Docker가 설치되어 있지 않습니다. Docker를 먼저 설치해주세요."
    exit 1
fi

# Docker Compose가 설치되어 있는지 확인
if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose가 설치되어 있지 않습니다. Docker Compose를 먼저 설치해주세요."
    exit 1
fi

# 현재 디렉토리 확인
if [ ! -f "docker-compose.yml" ]; then
    echo "docker-compose.yml 파일을 찾을 수 없습니다. 프로젝트 루트 디렉토리에서 실행해주세요."
    exit 1
fi

echo "1. 기존 Jenkins 컨테이너 중지 및 제거..."
docker-compose down

echo "2. Jenkins 이미지 빌드..."
docker build -t log4j-jenkins ./jenkins/

echo "3. Jenkins 컨테이너 시작..."
docker-compose up -d

echo "4. Jenkins 시작 대기 중..."
sleep 30

echo "5. Jenkins 초기 비밀번호 확인..."
INITIAL_PASSWORD=$(docker exec log4j-jenkins cat /var/jenkins_home/secrets/initialAdminPassword 2>/dev/null || echo "설정된 관리자 계정 사용")

echo ""
echo "=== Jenkins 설정 완료! ==="
echo ""
echo "Jenkins 접속 정보:"
echo "  URL: http://localhost:8081"
echo "  관리자 계정: admin"
echo "  비밀번호: admin123"
echo ""
if [ "$INITIAL_PASSWORD" != "설정된 관리자 계정 사용" ]; then
    echo "초기 설정용 비밀번호: $INITIAL_PASSWORD"
fi
echo ""
echo "Jenkins 콘솔 접속 방법:"
echo "  docker exec -it log4j-jenkins bash"
echo ""
echo "Jenkins 로그 확인:"
echo "  docker-compose logs -f jenkins"
echo ""
echo "Jenkins 중지:"
echo "  docker-compose down"
echo ""
echo "Jenkins 재시작:"
echo "  docker-compose restart jenkins"
echo ""

# Jenkins가 완전히 시작될 때까지 대기
echo "Jenkins 서비스 상태 확인 중..."
for i in {1..12}; do
    if curl -s http://localhost:8081 > /dev/null; then
        echo "✅ Jenkins가 성공적으로 시작되었습니다!"
        break
    else
        echo "⏳ Jenkins 시작 대기 중... ($i/12)"
        sleep 10
    fi
done

echo ""
echo "브라우저에서 http://localhost:8081 접속하여 Jenkins를 사용하세요!" 