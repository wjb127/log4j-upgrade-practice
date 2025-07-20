<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageTitle" value="홈" scope="request" />
<jsp:include page="layout/header.jsp" />

<div class="row">
    <div class="col-md-8">
        <div class="jumbotron bg-light p-5 rounded-3">
            <h1 class="display-4">
                <i class="fas fa-bug text-warning"></i> Log4j 업그레이드 연습
            </h1>
            <p class="lead">
                이 프로젝트는 취약한 Log4j 1.2.x 버전에서 최신 버전으로 업그레이드하는 연습을 위한 
                Spring 웹 애플리케이션입니다.
            </p>
            <hr class="my-4">
            <p>
                현재 Log4j 1.2.17 버전을 사용하고 있으며, 이는 보안 취약점이 있는 버전입니다.
                pom.xml 수정을 통해 최신 버전으로 업그레이드를 연습해보세요.
            </p>
            <a class="btn btn-primary btn-lg" href="<c:url value='/users' />" role="button">
                <i class="fas fa-users"></i> 사용자 관리 시작하기
            </a>
        </div>
    </div>
    
    <div class="col-md-4">
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h5 class="card-title mb-0">
                    <i class="fas fa-info-circle"></i> 시스템 정보
                </h5>
            </div>
            <div class="card-body">
                <ul class="list-group list-group-flush">
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <span><i class="fas fa-users text-primary"></i> 총 사용자 수</span>
                        <span class="badge bg-primary rounded-pill">${totalUsers}</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <span><i class="fas fa-code text-success"></i> Spring 버전</span>
                        <small class="text-muted">4.3.30</small>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <span><i class="fas fa-shield-alt text-warning"></i> Log4j 버전</span>
                        <small class="text-warning">1.2.17 (취약)</small>
                    </li>
                    <li class="list-group-item d-flex justify-content-between align-items-center">
                        <span><i class="fas fa-database text-info"></i> 데이터베이스</span>
                        <small class="text-muted">H2 (메모리)</small>
                    </li>
                </ul>
            </div>
        </div>
        
        <div class="card mt-3">
            <div class="card-header bg-warning text-dark">
                <h6 class="card-title mb-0">
                    <i class="fas fa-exclamation-triangle"></i> 보안 알림
                </h6>
            </div>
            <div class="card-body">
                <p class="card-text">
                    <small>
                        Log4j 1.2.x는 여러 보안 취약점이 발견된 레거시 버전입니다. 
                        최신 Log4j 2.x 또는 Logback으로 업그레이드하는 것을 권장합니다.
                    </small>
                </p>
                <a href="<c:url value='/about' />" class="btn btn-warning btn-sm">
                    <i class="fas fa-info"></i> 자세히 보기
                </a>
            </div>
        </div>
    </div>
</div>

<div class="row mt-4">
    <div class="col-md-12">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">
                    <i class="fas fa-list-check"></i> 업그레이드 체크리스트
                </h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <h6><i class="fas fa-clipboard-list"></i> 준비 단계</h6>
                        <ul class="list-unstyled">
                            <li><i class="fas fa-check text-success"></i> 현재 Log4j 버전 확인 (1.2.17)</li>
                            <li><i class="fas fa-check text-success"></i> 의존성 분석</li>
                            <li><i class="fas fa-check text-success"></i> 백업 생성</li>
                            <li><i class="fas fa-times text-danger"></i> 테스트 케이스 작성</li>
                        </ul>
                    </div>
                    <div class="col-md-6">
                        <h6><i class="fas fa-wrench"></i> 업그레이드 단계</h6>
                        <ul class="list-unstyled">
                            <li><i class="fas fa-times text-danger"></i> pom.xml 수정</li>
                            <li><i class="fas fa-times text-danger"></i> 설정 파일 마이그레이션</li>
                            <li><i class="fas fa-times text-danger"></i> 코드 수정</li>
                            <li><i class="fas fa-times text-danger"></i> 테스트 및 검증</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="layout/footer.jsp" /> 