<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageTitle" value="사용자 정보 수정" scope="request" />
<jsp:include page="../layout/header.jsp" />

<div class="row justify-content-center">
    <div class="col-md-8">
        <div class="card">
            <div class="card-header">
                <h4 class="card-title mb-0">
                    <i class="fas fa-user-edit"></i> 사용자 정보 수정
                </h4>
            </div>
            <div class="card-body">
                <form method="post" action="<c:url value='/users/${user.id}' />">
                    <div class="mb-3">
                        <label for="username" class="form-label">
                            <i class="fas fa-user"></i> 사용자명 *
                        </label>
                        <input type="text" 
                               class="form-control" 
                               id="username" 
                               name="username" 
                               value="${user.username}"
                               required 
                               placeholder="사용자명을 입력하세요">
                        <div class="form-text">영문, 숫자, 언더스코어만 사용 가능합니다.</div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="email" class="form-label">
                            <i class="fas fa-envelope"></i> 이메일 *
                        </label>
                        <input type="email" 
                               class="form-control" 
                               id="email" 
                               name="email" 
                               value="${user.email}"
                               required 
                               placeholder="이메일 주소를 입력하세요">
                    </div>
                    
                    <div class="mb-3">
                        <label for="fullName" class="form-label">
                            <i class="fas fa-id-card"></i> 성명 *
                        </label>
                        <input type="text" 
                               class="form-control" 
                               id="fullName" 
                               name="fullName" 
                               value="${user.fullName}"
                               required 
                               placeholder="전체 이름을 입력하세요">
                    </div>
                    
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <a href="<c:url value='/users/${user.id}' />" class="btn btn-secondary">
                            <i class="fas fa-times"></i> 취소
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> 저장
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" /> 