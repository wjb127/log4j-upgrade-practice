<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageTitle" value="사용자 상세정보" scope="request" />
<jsp:include page="../layout/header.jsp" />

<div class="row justify-content-center">
    <div class="col-md-8">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h4 class="card-title mb-0">
                    <i class="fas fa-user"></i> 사용자 상세정보
                </h4>
                <div>
                    <a href="<c:url value='/users/${user.id}/edit' />" class="btn btn-outline-primary btn-sm">
                        <i class="fas fa-edit"></i> 수정
                    </a>
                    <a href="<c:url value='/users' />" class="btn btn-outline-secondary btn-sm">
                        <i class="fas fa-list"></i> 목록
                    </a>
                </div>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-3">
                        <div class="text-center">
                            <div class="avatar-placeholder bg-primary text-white rounded-circle d-inline-flex align-items-center justify-content-center" 
                                 style="width: 120px; height: 120px; font-size: 3rem;">
                                ${user.username.substring(0,1).toUpperCase()}
                            </div>
                            <h5 class="mt-3">${user.fullName}</h5>
                            <p class="text-muted">@${user.username}</p>
                        </div>
                    </div>
                    <div class="col-md-9">
                        <h5><i class="fas fa-info-circle text-primary"></i> 기본 정보</h5>
                        
                        <table class="table table-borderless">
                            <tr>
                                <td class="fw-bold" style="width: 30%;">
                                    <i class="fas fa-hashtag text-muted"></i> 사용자 ID
                                </td>
                                <td>${user.id}</td>
                            </tr>
                            <tr>
                                <td class="fw-bold">
                                    <i class="fas fa-user text-muted"></i> 사용자명
                                </td>
                                <td><code>${user.username}</code></td>
                            </tr>
                            <tr>
                                <td class="fw-bold">
                                    <i class="fas fa-envelope text-muted"></i> 이메일
                                </td>
                                <td>
                                    <a href="mailto:${user.email}" class="text-decoration-none">
                                        ${user.email}
                                    </a>
                                </td>
                            </tr>
                            <tr>
                                <td class="fw-bold">
                                    <i class="fas fa-id-card text-muted"></i> 성명
                                </td>
                                <td>${user.fullName}</td>
                            </tr>
                            <tr>
                                <td class="fw-bold">
                                    <i class="fas fa-calendar-plus text-muted"></i> 등록일
                                </td>
                                <td>
                                    <fmt:formatDate value="${user.createdAt}" pattern="yyyy년 MM월 dd일 HH:mm" />
                                </td>
                            </tr>
                            <tr>
                                <td class="fw-bold">
                                    <i class="fas fa-calendar-edit text-muted"></i> 최종 수정일
                                </td>
                                <td>
                                    <fmt:formatDate value="${user.updatedAt}" pattern="yyyy년 MM월 dd일 HH:mm" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                
                <hr>
                
                <div class="d-flex justify-content-between">
                    <form method="post" action="<c:url value='/users/${user.id}/delete' />" 
                          onsubmit="return confirm('정말로 이 사용자를 삭제하시겠습니까?');">
                        <button type="submit" class="btn btn-outline-danger">
                            <i class="fas fa-trash"></i> 사용자 삭제
                        </button>
                    </form>
                    
                    <div>
                        <a href="<c:url value='/users/${user.id}/edit' />" class="btn btn-primary">
                            <i class="fas fa-edit"></i> 정보 수정
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" /> 