<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageTitle" value="소개" scope="request" />
<jsp:include page="layout/header.jsp" />

<div class="row">
    <div class="col-md-8">
        <div class="card">
            <div class="card-header">
                <h4 class="card-title mb-0">
                    <i class="fas fa-info-circle"></i> Log4j 업그레이드 연습 프로젝트
                </h4>
            </div>
            <div class="card-body">
                <p class="lead">
                    이 프로젝트는 취약한 Log4j 1.2.x 버전에서 최신 버전으로 업그레이드하는 과정을 
                    연습하기 위해 만들어진 Spring 웹 애플리케이션입니다.
                </p>
                
                <h5><i class="fas fa-target text-primary"></i> 목적</h5>
                <ul>
                    <li>Log4j 1.2.x의 보안 취약점 이해</li>
                    <li>안전한 업그레이드 프로세스 학습</li>
                    <li>의존성 관리 및 설정 마이그레이션 연습</li>
                    <li>실제 프로덕션 환경 시뮬레이션</li>
                </ul>
                
                <h5><i class="fas fa-cogs text-primary"></i> 기술 스택</h5>
                <div class="row">
                    <div class="col-md-6">
                        <h6>현재 사용 중 (취약한 버전)</h6>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">
                                <i class="fas fa-bug text-warning"></i> Log4j 1.2.17
                            </li>
                            <li class="list-group-item">
                                <i class="fas fa-leaf text-success"></i> Spring Framework 4.3.30
                            </li>
                            <li class="list-group-item">
                                <i class="fas fa-coffee text-info"></i> Java 8
                            </li>
                            <li class="list-group-item">
                                <i class="fas fa-database text-secondary"></i> H2 Database
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-6">
                        <h6>업그레이드 목표</h6>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">
                                <i class="fas fa-shield-alt text-success"></i> Log4j 2.x 또는 Logback
                            </li>
                            <li class="list-group-item">
                                <i class="fas fa-leaf text-success"></i> Spring Boot 2.x+
                            </li>
                            <li class="list-group-item">
                                <i class="fas fa-coffee text-info"></i> Java 11+
                            </li>
                            <li class="list-group-item">
                                <i class="fas fa-code text-primary"></i> 현대적인 설정 방식
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <div class="col-md-4">
        <div class="card mb-3">
            <div class="card-header bg-danger text-white">
                <h6 class="card-title mb-0">
                    <i class="fas fa-exclamation-triangle"></i> 보안 경고
                </h6>
            </div>
            <div class="card-body">
                <p class="card-text">
                    <small>
                        Log4j 1.2.x는 다음과 같은 심각한 보안 취약점이 있습니다:
                    </small>
                </p>
                <ul class="small">
                    <li>CVE-2019-17571: 원격 코드 실행</li>
                    <li>CVE-2020-9488: 정보 유출</li>
                    <li>여러 DoS 취약점</li>
                </ul>
                <p class="text-danger small">
                    <strong>프로덕션 환경에서는 절대 사용하지 마세요!</strong>
                </p>
            </div>
        </div>
        
        <div class="card">
            <div class="card-header bg-success text-white">
                <h6 class="card-title mb-0">
                    <i class="fas fa-rocket"></i> 업그레이드 이점
                </h6>
            </div>
            <div class="card-body">
                <ul class="small">
                    <li>향상된 보안성</li>
                    <li>더 나은 성능</li>
                    <li>비동기 로깅 지원</li>
                    <li>유연한 설정 옵션</li>
                    <li>Lambda 지원</li>
                    <li>자동 설정 리로드</li>
                </ul>
            </div>
        </div>
    </div>
</div>

<div class="row mt-4">
    <div class="col-md-12">
        <div class="card">
            <div class="card-header">
                <h5 class="card-title mb-0">
                    <i class="fas fa-map text-primary"></i> 업그레이드 로드맵
                </h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-3">
                        <div class="text-center">
                            <div class="bg-danger text-white rounded-circle d-inline-flex align-items-center justify-content-center" 
                                 style="width: 60px; height: 60px;">
                                <i class="fas fa-exclamation-triangle"></i>
                            </div>
                            <h6 class="mt-2">1. 현재 상태</h6>
                            <small class="text-muted">Log4j 1.2.x<br>취약점 존재</small>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="text-center">
                            <div class="bg-warning text-dark rounded-circle d-inline-flex align-items-center justify-content-center" 
                                 style="width: 60px; height: 60px;">
                                <i class="fas fa-search"></i>
                            </div>
                            <h6 class="mt-2">2. 분석</h6>
                            <small class="text-muted">의존성 분석<br>영향도 평가</small>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="text-center">
                            <div class="bg-info text-white rounded-circle d-inline-flex align-items-center justify-content-center" 
                                 style="width: 60px; height: 60px;">
                                <i class="fas fa-wrench"></i>
                            </div>
                            <h6 class="mt-2">3. 마이그레이션</h6>
                            <small class="text-muted">설정 변경<br>코드 수정</small>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="text-center">
                            <div class="bg-success text-white rounded-circle d-inline-flex align-items-center justify-content-center" 
                                 style="width: 60px; height: 60px;">
                                <i class="fas fa-check"></i>
                            </div>
                            <h6 class="mt-2">4. 완료</h6>
                            <small class="text-muted">안전한 버전<br>테스트 완료</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="layout/footer.jsp" /> 