<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>점장 홈페이지</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
<style>
	.col{
		height: 150px;
	}
	.col .card-body{
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.card{
		transition: background-color 0.3s ease-in-out;
	}
	.card:hover{
		background-color: #28A745; 
        color: white;
        transition: background-color 0.3s ease-in-out, color 0.3s ease-in-out;
	}
	.card-title{
		font-size: 1.5rem;
		font-weight: normal;
	}
	
</style>	
</head>
<body class="d-flex flex-column min-vh-100">
<%@ include file="/include/header.jsp" %>	
		<jsp:include page="/include/navbar.jsp"></jsp:include>
		<div class="main flex-grow-1">
		<div class="container">
			<h1 class="mb-5">점장 인덱스 페이지</h1>
			<div class="row row-cols-1 row-cols-md-2 g-4 ">
				<%--개인 정보 보기 --%>
				<div class="col">
					<div class="card text-center h-100">
						<div class="card-body">
							<h5 class="card-title">개인정보조회</h5>
						</div>
						<a href="${pageContext.request.contextPath}/companyone/admin/info/view.jsp"
							class="stretched-link"></a>
					</div>
				</div>
				
				<%--매출관리 --%>
				<div class="col">
					<div class="card text-center h-100">
						<div class="card-body">
							<h5 class="card-title">매출관리</h5>
						</div>
						<a href="${pageContext.request.contextPath}/companyone/admin/sale/insertForm.jsp"
							class="stretched-link"></a>
					</div>
				</div>
			
				<%--직원 관리 --%>
				<div class="col">
					<div class="card text-center h-100">
						<div class="card-body">
							<h5 class="card-title">직원관리</h5>
						</div>
					<a href="${pageContext.request.contextPath}/companyone/admin/staffstatus/view.jsp" class="stretched-link"></a>
					</div>
				</div>
				<%--직원 스케줄  --%>
				<div class="col">
					<div class="card text-center h-100">
						<div class="card-body">
							<h5 class="card-title">직원스케줄관리</h5>
						</div>
					<a href="${pageContext.request.contextPath}/companyone/admin/staffschedule/view.jsp?storenum="${session.storenum}" class="stretched-link"></a>
					</div>
				</div>
				
				<%--직원월급 --%>
				<div class="col">
					<div class="card text-center h-100">
						<div class="card-body">
							<h5 class="card-title">직원월급</h5>
						</div>
					<a href="${pageContext.request.contextPath}/companyone/admin/staffsalary/view.jsp" class="stretched-link"></a>
					</div>
				</div>
				<%--상담문의--%>
				<div class="col">
					<div class="card text-center h-100">
						<div class="card-body">
							<h5 class="card-title">사원승인</h5>
						</div>
						<a href="${pageContext.request.contextPath}/companyone/admin/accept/acceptStaff.jsp" class="stretched-link"></a>
					</div>
				</div>

			</div>
		</div>
	</div>
	<jsp:include page="/include/footer.jsp" />
</body>
</html>