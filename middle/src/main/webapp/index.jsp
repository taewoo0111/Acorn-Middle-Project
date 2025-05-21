<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<%
    String message = request.getParameter("message");
    if ("success".equals(message)) {
%>
    <script>
        alert("성공! 메인페이지로 이동합니다!");
        window.location.href = "index.jsp";
    </script>
<%
    }
%>

<html>
<head>
    <meta charset="UTF-8"> <!-- UTF-8 인코딩 설정 -->
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>프랜차이즈 관리 시스템</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
    <style>
        body {
            background-color: #f4f6f9;
        }
        header {
            background-color: #2c3e50;
            color: #fff;
        }
        footer {
            background-color: #2c3e50;
            color: #fff;
        }
        
        /* 부드러운 스크롤 효과 추가 */
        html {
            scroll-behavior: smooth;
        }
    </style>
    
    <!-- 상호명 변경 스크립트 -->
	<script>
	    function changeStoreName() {
	        const newName = prompt("새로운 상호명을 입력하세요:");
	        if (newName) {
	            document.getElementById("store-name").textContent = newName;
	        }
	    }
	</script>
</head>

<body>
	<!-- 부트스트랩 컨테이너 -->
	<div class="container mt-5">
	    <!-- 상호명 및 설명 -->
	    <div class="row justify-content-center mb-5">
	        <div class="col-md-12 text-center">
	            <h1 class="display-4 text-primary">프랜차이즈 관리 시스템</h1>
	            <p class="lead">효율적인 관리와 빠른 의사결정을 돕는 시스템입니다.</p>
	            <button class="btn btn-warning btn-lg" onclick="changeStoreName()">상호명 변경</button>
	            <p id="store-name" class="h4 mt-3">우리매장</p> <!-- 유동적인 상호명 -->
	        </div>
	    </div>
	
	    <!-- 기능 카드 섹션 -->
	    <div class="row">
	        <!-- CEO 입장 -->
	        <div class="col-md-4 mb-4">
	            <div class="card shadow-lg border-primary text-center">
	                <div class="card-header bg-primary text-white">
	                    <h5 class="card-title"><a href="#section1" class="justify-content-center align-items-center" style="text-decoration: none;"><span style="color:white">CEO 입장</span></a></h5>
	                </div>
	                <div class="card-body">
	                    <ul class="list-unstyled">
	                        <li><a href="#" class="btn btn-outline-primary btn-block mb-2 w-100 d-flex justify-content-center align-items-center">직원 관리</a></li>
	                        <li><a href="#" class="btn btn-outline-primary btn-block mb-2 w-100 d-flex justify-content-center align-items-center">매출 관리</a></li>
	                        <li><a href="#" class="btn btn-outline-primary btn-block mb-2 w-100 d-flex justify-content-center align-items-center">가입 승인</a></li>
	                        <li><a href="#" class="btn btn-outline-primary btn-block mb-2 w-100 d-flex justify-content-center align-items-center">퇴사자 관리</a></li>
	                    </ul>
	                </div>
	            </div>
	        </div>
	
	        <!-- 점장 입장 -->
	        <div class="col-md-4 mb-4">
	            <div class="card shadow-lg border-success text-center">
	                <div class="card-header bg-success text-white">
	                    <h5 class="card-title"><a href="#section2" class="justify-content-center align-items-center" style="text-decoration: none;"><span style="color:white">점장 입장</span></a></h5>
	                </div>
	                <div class="card-body">
	                    <ul class="list-unstyled">
	                        <li><a href="#" class="btn btn-outline-success btn-block mb-2 w-100 d-flex justify-content-center align-items-center">개인정보 조회</a></li>
	                        <li><a href="#" class="btn btn-outline-success btn-block mb-2 w-100 d-flex justify-content-center align-items-center">매출 관리</a></li>
	                        <li><a href="#" class="btn btn-outline-success btn-block mb-2 w-100 d-flex justify-content-center align-items-center">사원 승인</a></li>
	                        <li><a href="#" class="btn btn-outline-success btn-block mb-2 w-100 d-flex justify-content-center align-items-center">직원 관리</a></li>
	                        <li><a href="#" class="btn btn-outline-success btn-block mb-2 w-100 d-flex justify-content-center align-items-center">직원 스케줄</a></li>
	                        <li><a href="#" class="btn btn-outline-success btn-block mb-2 w-100 d-flex justify-content-center align-items-center">직원 월급</a></li>
	                    </ul>
	                </div>
	            </div>
	        </div>
	
	        <!-- 직원 입장 -->
	        <div class="col-md-4 mb-4">
	            <div class="card shadow-lg border-warning text-center">
	                <div class="card-header bg-warning text-white">
	                    <h5 class="card-title"><a href="#section3" style="text-decoration: none;"><span style="color:white">직원 입장</span></a></h5>
	                </div>
	                <div class="card-body">
	                    <ul class="list-unstyled">
	                        <li><a href="#" class="btn btn-outline-warning btn-block mb-2 w-100 d-flex justify-content-center align-items-center">프로필 관리</a></li>
	                        <li><a href="#" class="btn btn-outline-warning btn-block mb-2 w-100 d-flex justify-content-center align-items-center">스케줄 조회</a></li>
	                        <li><a href="#" class="btn btn-outline-warning btn-block mb-2 w-100 d-flex justify-content-center align-items-center">출/퇴근</a></li>
	                        <li><a href="#" class="btn btn-outline-warning btn-block mb-2 w-100 d-flex justify-content-center align-items-center">급여 계산</a></li>
	                    </ul>
	                </div>
	            </div>
	        </div>
	    </div>
		
		<!-- 공지사항 섹션 -->
	    <div class="row mb-4">
	        <div class="col-md-12">
	            <div class="card shadow-lg">
	                <div class="card-header bg-dark text-white">
	                    <h5 class="card-title">공지사항</h5>
	                </div>
	                <div class="card-body">
	                    <ul>
	                        <li>2025년 신년 이벤트 안내</li>
	                        <li>가맹점 운영 규정 업데이트</li>
	                        <li>새로운 가맹점 추가 및 관리 방법</li>
	                    </ul>
	                </div>
	            </div>
	        </div>
	    </div>
	    
	    <!--섹션1 (CEO 페이지 소개)-->
		<div class="card shadow-lg border-primary" style="margin-top: 20px; margin-bottom:30px;">
			<section id="section1" class="bg-light" style="color: black; margin-bottom: 30px; padding: 20px; border-radius: 8px;">
			    <div class="container">
			        <div class="row align-items-center">
			            <div class="col-md-6 text-end">
			                <h3>가입 승인</h3>
			                <p>점장들이 웹을 사용 가능하도록<br />
			                	가입을 승인합니다.
			                </p>
			            </div>
			            <div class="col-md-6">
			                <img src="https://media.istockphoto.com/id/2015223595/ko/%EB%B2%A1%ED%84%B0/%EC%A0%9C%ED%95%9C-%EA%B5%AC%EC%97%AD-%EA%B8%88%EC%A7%80-%ED%91%9C%EC%A7%80%ED%8C%90.jpg?s=1024x1024&w=is&k=20&c=3r9AX3UE5PAUzhw3oLiBe37LeaSxWZR3Pwt99oe83O4="
			                		alt="설명 이미지" class="img-fluid" style="border-radius: 8px; margin-top: 20px;">
			            </div>
			        </div>
			    </div>
			    <div class="container">
			        <div class="row align-items-center">
			            <div class="col-md-6">
			                <img src="https://plus.unsplash.com/premium_vector-1682307882545-5bc2546ed322?q=80&w=1480&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
			                		alt="설명 이미지" class="img-fluid" style="border-radius: 8px; margin-top: 20px; ">
			            </div>
			            <div class="col-md-6 text-start">
			                <h3>직원 현황 조회</h3>
			                <p>현재 직원 목록을 조회할 수 있습니다.<br />
			                	점장 / 직원 / 각 지점 별 직원<br />
			                	개인정보를 확인할 수 있습니다.
			                </p>
			            </div>
			        </div>
			    </div>
			    <div class="container">
			        <div class="row align-items-center">
			            <div class="col-md-6 text-end">
			                <h3>매출 관리</h3>
			                <p>
							    연매출, 월매출, 일매출을 손쉽게 조회할 수 있습니다.<br />
							    원하는 기간을 선택하여 매출 흐름을 한눈에 파악하고, 데이터를 비교 분석할 수 있습니다.<br />
							    직관적인 인터페이스를 통해 빠르고 정확한 매출 정보를 확인하세요.
							</p>
			            </div>
			            <div class="col-md-6">
			                <img src="https://media.istockphoto.com/id/1325166649/ko/%EB%B2%A1%ED%84%B0/%EC%82%AC%EC%97%85%EA%B0%80%EB%B3%B5%EA%B5%AC-%EB%B0%8F-%EC%84%B1%EC%9E%A5-%EA%B8%B0%EC%97%85%EC%9D%80-%EC%9C%84%EA%B8%B0%EC%97%90%EC%84%9C-%EC%82%B4%EC%95%84%EB%82%A8%EC%8A%B5%EB%8B%88%EB%8B%A4.jpg?s=1024x1024&w=is&k=20&c=BO9lv1OHdNc6bvUFoq4dqI2oAoI3xXiu0HyWitr_esQ="
			                		alt="설명 이미지" class="img-fluid" style="border-radius: 8px; margin-top: 20px;">
			            </div>
			        </div>
			    </div>
			    <div class="container">
			        <div class="row align-items-center">
			            <div class="col-md-6">
			                <img src="https://media.istockphoto.com/id/528438296/ko/%EB%B2%A1%ED%84%B0/%EC%86%90-%ED%98%88%EC%A0%84-%EC%8A%A4%ED%85%9C%ED%94%84-%EC%9E%88%EB%8A%94-%ED%8C%A8%EC%8A%A4%ED%8F%AC%ED%8A%B8.jpg?s=1024x1024&w=is&k=20&c=x-gzEg5M8wEqlvRUVelRaTVA6oMbPMtX09tLxyGajNA="
			                		alt="설명 이미지" class="img-fluid" style="border-radius: 8px; margin-top: 20px; width: 100%; height: 250px; object-fit: cover;">
			            </div>
			            <div class="col-md-6 text-start">
			                <h3>퇴사 관리</h3>
			                <p>퇴사 처리를 진행합니다.
			                	<br /> 퇴사자의 목록을 확인할 수 있고,
			                	<br /> 만약의 경우 복귀 시킬 수도 있습니다.
			                </p>
			            </div>
			        </div>
			    </div>
			</section>
		</div>
		
		<!--섹션2 (점장 페이지 소개)-->
		<div class="card shadow-lg border-success" style="margin-top: 20px; margin-bottom:30px">
			<section id="section2" class="bg-light" style="color: black; margin-bottom: 30px; padding: 20px; border-radius: 8px;">
			    <div class="container">
			        <div class="row align-items-center">
			            <div class="col-md-6">
			                <img src="https://plus.unsplash.com/premium_photo-1681487814165-018814e29155?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
			                		alt="설명 이미지" class="img-fluid" style="border-radius: 8px; margin-top: 20px;">
			            </div>
			            <div class="col-md-6 text-start">
			                <h3>프로필 관리</h3>
							<p>
								점장의 가입 정보를 조회하고 수정할 수 있는 기능을 제공합니다.<br /> 등록된 정보를 손쉽게 확인하고, 필요한
								경우 직접 수정하여 최신 상태로 유지할 수 있습니다.<br /> 간편한 인터페이스를 통해 빠르고 정확한 정보
								관리를 지원합니다.
							</p>
						</div>
			        </div>
			    </div>
			    <div class="container">
			        <div class="row align-items-center">
			        	<div class="col-md-6 text-start">
			                <h3>매출 관리</h3>
			                <p>
							    연매출, 월매출, 일매출을 손쉽게 조회할 수 있습니다.<br />
							    원하는 기간을 선택하여 매출 흐름을 한눈에 파악하고, 데이터를 비교 분석할 수 있습니다.<br />
							    직관적인 인터페이스를 통해 빠르고 정확한 매출 정보를 확인하세요.
							</p>
			            </div>
			            <div class="col-md-6">
			                <img src="https://images.unsplash.com/photo-1591696205602-2f950c417cb9?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
			                		alt="설명 이미지" class="img-fluid" style="border-radius: 8px; margin-top: 20px;">
			            </div>
			        </div>
			    </div>
			    <div class="container">
			        <div class="row align-items-center">
			        	<div class="col-md-6">
			                <img src="https://images.unsplash.com/photo-1641122669951-3e2aff778d3b?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
			                		alt="설명 이미지" class="img-fluid" style="border-radius: 8px; margin-top: 20px;">
			            </div>
			        	<div class="col-md-6 text-end">
			                <h3>직원 관리</h3>
			                <p>
				                직원의 기본 정보(이름, 연락처, 이메일 등)와 급여, 수당, 근무 시간을 확인하고 관리할 수 있습니다.  
				                또한, 근로계약서를 확인하거나 근무 시간을 변경하는 기능도 제공합니다.
				            </p>
			            </div>
			        </div>
			    </div>
			    
			</section>
		</div>
		
		<!--섹션3 (직원 페이지 소개)-->
		<div class="card shadow-lg border-warning" style="margin-top: 20px; margin-bottom:30px">
			<section id="section3" class="bg-light" style="color: black; margin-bottom: 30px; padding: 20px; border-radius: 8px;">
			    <div class="container">
			        <div class="row align-items-center">
			            <div class="col-md-6 text-end">
			                <h3>프로필 관리</h3>
			                <p>프로필 관리 페이지에 대한 설명
			                	<br /> 직원 본인에 대한 전체적인 정보를 조회할 수 있습니다.<br />
			                	매장명,호점,사원번호,개인정보를 한 눈에 확인할 수 있습니다.<br /> 
			                	개인 정보에 관한 수정도 가능하며 근로계약서 확인도 가능합니다.
			                </p>
			            </div>
			            <div class="col-md-6">
			                <img src="https://media.istockphoto.com/id/502416015/ko/%EB%B2%A1%ED%84%B0/%EC%95%84%EB%B0%94%ED%83%80.jpg?s=612x612&w=0&k=20&c=Q3ysWAVKW_aJgBd0VpyD8h4-8wb5MA_dZL9O5RYd_dk="
			                		alt="설명 이미지" class="img-fluid" style="border-radius: 8px; margin-top: 20px;">
			            </div>
			        </div>
			    </div>
			    <div class="container">
			        <div class="row align-items-center">
			            <div class="col-md-6">
			                <img src="https://media.istockphoto.com/id/1420323259/ko/%EC%82%AC%EC%A7%84/%EC%BA%98%EB%A6%B0%EB%8D%94%EC%97%90%EC%84%9C-%EC%98%A8%EB%9D%BC%EC%9D%B8-%EC%98%88%EC%95%BD-%EB%B0%8F-%EC%98%88%EC%95%BD.jpg?s=612x612&w=0&k=20&c=9PSqdhkf8rwfiTArlOOVf6Jw-GYdVgrORLbEdtRhUEo="
			                		alt="설명 이미지" class="img-fluid" style="border-radius: 8px; margin-top: 20px;">
			            </div>
			            <div class="col-md-6 text-start">
			                <h3>스케줄 조회</h3>
			                <p>스케줄 조회 페이지에 대한 설명 
			                	<br /> 올려진 근무표를 확인하고 자신의 스케줄을 확인할 수 있습니다.
			                </p>
			            </div>
			        </div>
			    </div>
			    <div class="container">
			        <div class="row align-items-center">
			            <div class="col-md-6 text-end">
			                <h3>출/퇴근</h3>
			                <p>출퇴근 페이지에 대한 설명 
			                	<br /> 자신의 출/퇴근을 기록할 수 있어 후에 조회나 회사에서 급여관리에 관해 보다 수월하게 관리를 진행할 수 있습니다.
			                </p>
			            </div>
			            <div class="col-md-6">
			                <img src="https://media.istockphoto.com/id/1088177456/ko/%EB%B2%A1%ED%84%B0/%EC%82%AC%EC%97%85-%EA%B3%84%ED%9A%8D%EC%9D%98-%EA%B5%AC%ED%98%84-%EC%9C%84%ED%95%9C-worktime%EC%9D%98-%ED%9A%A8%EC%9C%A8%EC%A0%81%EC%9D%B8-%EC%82%AC%EC%9A%A9-%EC%A7%81%EC%9E%A5%EC%9D%98-%EC%B5%9C%EA%B3%A0-%EB%B3%B4%EA%B8%B0%EC%9D%98-%EB%B2%A1%ED%84%B0%EC%9E%85%EB%8B%88%EB%8B%A4.jpg?s=2048x2048&w=is&k=20&c=RCvTCOg6MAsx13Rpn50ZY4Ajb8KHUy5ME85xU4AqpXs="
			                		alt="설명 이미지" class="img-fluid" style="border-radius: 8px; margin-top: 20px;">
			            </div>
			        </div>
			    </div>
			    <div class="container">
			        <div class="row align-items-center">
			            <div class="col-md-6">
			                <img src="https://media.istockphoto.com/id/1389255223/ko/%EB%B2%A1%ED%84%B0/%EA%B8%89%EC%97%AC-%EA%B8%89%EC%97%AC-%EC%8B%9C%EC%8A%A4%ED%85%9C-%EC%98%A8%EB%9D%BC%EC%9D%B8-%EC%86%8C%EB%93%9D-%EA%B3%84%EC%82%B0-%EB%B0%8F-%EC%9E%90%EB%8F%99-%EC%A7%80%EB%B6%88-%EC%82%AC%EB%AC%B4%EC%8B%A4-%ED%9A%8C%EA%B3%84-%EA%B4%80%EB%A6%AC-%EB%98%90%EB%8A%94-%EC%9D%BC%EC%A0%95-%EA%B8%89%EC%97%AC-%EB%82%A0%EC%A7%9C-%EC%A7%81%EC%9B%90-%EC%9E%84%EA%B8%88-%EA%B0%9C%EB%85%90-%EC%98%A8%EB%9D%BC%EC%9D%B8-%EA%B8%89%EC%97%AC-%EC%BB%B4%ED%93%A8%ED%84%B0%EC%99%80-%ED%95%A8%EA%BB%98-%EC%84%9C-%EC%82%AC%EC%97%85%EA%B0%80.jpg?s=612x612&w=0&k=20&c=ZneAnVJfCPpBJyTlTQBypydYL6J6qhNgXPsT4-iEtC4="
			                		alt="설명 이미지" class="img-fluid" style="border-radius: 8px; margin-top: 20px;">
			            </div>
			            <div class="col-md-6 text-start">
			                <h3>급여 계산</h3>
			                <p>급여 계산 페이지에 대한 설명 
			                	<br /> 월급과 시급을 따로 계산할 수 있으며 자신의 월급에 대해 편하게 조회가 가능합니다.
			                </p>
			            </div>
			        </div>
			    </div>
			</section>
		</div>
	</div>
	<script>
	document.body.addEventListener('click', function() {
		console.log("click!");
		  // 페이지가 하단에 있으면
		 window.scrollTo({top:0});
	});
	</script>
	<%@ include file="/include/footer.jsp" %>
</body>
</html>