<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="pageTitle" value="사용자 관리" scope="request" />
<jsp:include page="../layout/header.jsp" />

<div class="d-flex justify-content-between align-items-center mb-4">
    <h2><i class="fas fa-users"></i> 사용자 관리</h2>
    <a href="<c:url value='/users/new' />" class="btn btn-primary">
        <i class="fas fa-plus"></i> 새 사용자 추가
    </a>
</div>

<div class="row mb-3">
    <div class="col-md-6">
        <div class="card bg-primary text-white">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <h4 class="card-title">${totalCount}</h4>
                        <p class="card-text">총 사용자 수</p>
                    </div>
                    <div class="align-self-center">
                        <i class="fas fa-users fa-3x opacity-75"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-6">
        <div class="card bg-success text-white">
            <div class="card-body">
                <div class="d-flex justify-content-between">
                    <div>
                        <h4 class="card-title">활성</h4>
                        <p class="card-text">시스템 상태</p>
                    </div>
                    <div class="align-self-center">
                        <i class="fas fa-check-circle fa-3x opacity-75"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="card">
    <div class="card-header">
        <h5 class="card-title mb-0">
            <i class="fas fa-list"></i> 사용자 목록
        </h5>
    </div>
    <div class="card-body">
        <c:choose>
            <c:when test="${empty users}">
                <div class="text-center py-5">
                    <i class="fas fa-user-slash fa-3x text-muted mb-3"></i>
                    <h5 class="text-muted">등록된 사용자가 없습니다</h5>
                    <p class="text-muted">새 사용자를 추가해보세요.</p>
                    <a href="<c:url value='/users/new' />" class="btn btn-primary">
                        <i class="fas fa-plus"></i> 첫 번째 사용자 추가
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th><i class="fas fa-hashtag"></i> ID</th>
                                <th><i class="fas fa-user"></i> 사용자명</th>
                                <th><i class="fas fa-envelope"></i> 이메일</th>
                                <th><i class="fas fa-id-card"></i> 성명</th>
                                <th><i class="fas fa-calendar"></i> 등록일</th>
                                <th><i class="fas fa-cogs"></i> 작업</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <tr>
                                    <td>${user.id}</td>
                                    <td>
                                        <strong>${user.username}</strong>
                                    </td>
                                    <td>
                                        <i class="fas fa-envelope text-muted"></i> ${user.email}
                                    </td>
                                    <td>${user.fullName}</td>
                                    <td>
                                        <small class="text-muted">
                                            <fmt:formatDate value="${user.createdAt}" pattern="yyyy-MM-dd HH:mm" />
                                        </small>
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            <a href="<c:url value='/users/${user.id}' />" 
                                               class="btn btn-sm btn-outline-primary" 
                                               title="상세보기">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                            <a href="<c:url value='/users/${user.id}/edit' />" 
                                               class="btn btn-sm btn-outline-secondary" 
                                               title="수정">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <button type="button" 
                                                    class="btn btn-sm btn-outline-danger" 
                                                    title="삭제"
                                                    onclick="confirmDelete(${user.id}, '${user.username}')">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<!-- 삭제 확인 모달 -->
<div class="modal fade" id="deleteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">
                    <i class="fas fa-exclamation-triangle text-warning"></i> 삭제 확인
                </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p>정말로 사용자 <strong id="deleteUsername"></strong>를 삭제하시겠습니까?</p>
                <p class="text-muted">이 작업은 되돌릴 수 없습니다.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <form id="deleteForm" method="post" style="display: inline;">
                    <button type="submit" class="btn btn-danger">
                        <i class="fas fa-trash"></i> 삭제
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
function confirmDelete(userId, username) {
    document.getElementById('deleteUsername').textContent = username;
    document.getElementById('deleteForm').action = '${pageContext.request.contextPath}/users/' + userId + '/delete';
    
    var modal = new bootstrap.Modal(document.getElementById('deleteModal'));
    modal.show();
}
</script>

<jsp:include page="../layout/footer.jsp" /> 