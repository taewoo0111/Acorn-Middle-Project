<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- 관리자 전용 네비바: 내 정보 보기 | 가입 승인 | 직원 현황 | 매출 관리 | 퇴사 관리 --%>
<c:choose>
	<c:when test="${role.equals('CEO') }">
		<ul class="mt-2 mb-5 nav justify-content-center nav-pills nav-fill">
			<li class="nav-item"><a
				class="nav-link ${current_page eq 'myinfo' ? 'active' : ''}"
				href="${pageContext.request.contextPath}/companyone/ceo/info/view.jsp">내
					정보 보기</a></li>
			<li class="nav-item"><a
				class="nav-link ${current_page eq 'view' ? 'active' : ''}"
				href="${pageContext.request.contextPath}/companyone/ceo/sale/view.jsp">매출
					관리</a></li>
			<li class="nav-item"><a
				class="nav-link ${current_page eq 'acceptForm' ? 'active' : ''}"
				href="${pageContext.request.contextPath }/companyone/ceo/accept/acceptForm.jsp">가입
					승인</a></li>
			<li class="nav-item"><a
				class="nav-link ${current_page eq 'manageForm' ? 'active' : ''}"
				href="${pageContext.request.contextPath}/companyone/ceo/employee/manageForm.jsp">직원
					현황</a></li>
			<li class="nav-item"><a
				class="nav-link ${current_page eq 'quitForm' ? 'active' : ''}"
				href="${pageContext.request.contextPath }/companyone/ceo/quit/quitForm.jsp">퇴사
					관리</a></li>
		</ul>
	</c:when>
	<c:when test="${role.equals('ADMIN') }">
		<%-- 점장 전용 네비바: 홈 | 개인정보조회 | 매출관리 | 사원승인 | 직원관리 | 직원스케줄 | 직원월급 --%>
		<ul class="mb-5 nav justify-content-center nav-pills nav-fill">
			<li class="nav-item"><a
				class="nav-link ${current_page eq 'infoview' ? 'active' : ''}"
				href="${pageContext.request.contextPath}/companyone/admin/info/view.jsp">개인정보조회</a>
			</li>
			<li class="nav-item"><a
				class="nav-link ${current_page eq 'saleview' ? 'active' : ''}"
				href="${pageContext.request.contextPath }/companyone/admin/sale/insertForm.jsp">매출관리</a>
			</li>
			<li class="nav-item"><a
				class="nav-link ${current_page eq 'acceptStaff' ? 'active' : ''}"
				href="${pageContext.request.contextPath}/companyone/admin/accept/acceptStaff.jsp">사원승인</a>
			</li>
			<li class="nav-item"><a
				class="nav-link ${current_page eq 'staffstatusview' ? 'active' : ''}"
				href="${pageContext.request.contextPath}/companyone/admin/staffstatus/view.jsp">직원관리</a>
			</li>
			<li class="nav-item"><a
				class="nav-link ${current_page eq 'staffscheduleview' ? 'active' : ''}"
				href="${pageContext.request.contextPath }/companyone/admin/staffschedule/view.jsp?storenum="${session.storenum }">직원스케줄</a>
			</li>
			<li class="nav-item"><a
				class="nav-link ${current_page eq 'staffsalaryview' ? 'active' : ''}"
				href="${pageContext.request.contextPath }/companyone/admin/staffsalary/view.jsp">직원월급</a>
			</li>
		</ul>
	</c:when>
	<c:when test="${role.equals('STAFF') }">
		<ul class="mb-5 nav justify-content-center nav-pills nav-fill">
			<li class="nav-item"><a
				class="nav-link ${current_page eq 'staffMain' ? 'active' : ''}"
				href="${pageContext.request.contextPath}/companyone/staff/staffMain.jsp">메인
					페이지</a></li>
			<li class="nav-item"><a
				class="nav-link ${current_page eq 'log' ? 'active' : ''}"
				href="${pageContext.request.contextPath }/companyone/staff/log/log.jsp">출/퇴근</a>
			</li>
			<li class="nav-item"><a
				class="nav-link ${current_page eq 'schedule' ? 'active' : ''}"
				href="${pageContext.request.contextPath}/companyone/staff/schedule/schedule.jsp">스케줄</a>
			</li>
			<li class="nav-item"><a
				class="nav-link ${current_page eq 'salary' ? 'active' : ''}"
				href="${pageContext.request.contextPath }/companyone/staff/salary/salary.jsp">급여
					계산</a></li>
			<li class="nav-item"><a
				class="nav-link ${current_page eq 'profile' ? 'active' : ''}"
				href="${pageContext.request.contextPath}/companyone/staff/info/profile.jsp">프로필
					관리</a></li>
		</ul>
	</c:when>
</c:choose>