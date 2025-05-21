<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- formatNumber 태그를 사용하기 위해 필요한 JSTL 라이브러리 추가 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	session.setAttribute("current_page", "salary");

	int empno = (int)session.getAttribute("empno");
	
	Com1EmpDto dto = Com1EmpDao.getInstance().getData(empno);
	//급여 값이 입력되지 않은 경우(int 는 기본값이 0) 페이지 이동 
	if(dto.getSal()==0 && dto.getHsal()==0){
%>
	<script>
		alert("월급 또는 시급 이 입력되지 않았습니다. 메인페이지로 이동합니다.");
		window.location.href = "../staffMain.jsp";
	</script>
<% 
	} else {
		int sal = dto.getSal();
		int hsal = dto.getHsal();
		
		//한번만 사용되는 중요하지 않은 값은 session 보다는 pageContext scope 에 저장
		session.setAttribute("sal", sal);
		session.setAttribute("hsal", hsal);

	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>급여 계산</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<style>
	html, body {
	    height: 100%;
	    margin: 0;
	    display: flex;
	    flex-direction: column;
	}
	.container2 {
		flex-grow: 1;
		max-width: 800px;
		margin: 10px auto;
		background-color: #fff;
		padding: 20px;
		border-radius: 8px;
		border: 1px solid black;
		box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	}
    .tab-button {
        padding: 10px 20px;
        cursor: pointer;
        font-weight: bold;
        background-color: #f1f1f1;
        border: 1px solid #ddd;
        transition: background-color 0.3s ease;
    }

    .active-tab {
        background-color: #dcdcdc; 
        border-bottom: 2px solid #999; 
    }
    .tab-content {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }
    .result {
    	display: none;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
    }
    th, td {
        padding: 6px 9px;
        border: 1px solid #ddd;
        text-align: center;
    }
    th {
        background-color: #c8c8c8;
    }    
    button:hover {
        background-color: grey;
    }

	.salary-label {
	    padding: 10px;
	    width: 100%;
	    display: block;
	}
	.hsalary-label {
	    padding: 8px;
	    width: 100%;
	    display: block;
	}
	
	.disabled {/*비활성화 상태*/
	    background-color: #ddd !important;
	    color: #999 !important;
	    cursor: not-allowed !important;
	}
	.footer {
	    text-align: center;
	    width: 100%;
	    margin-top: 25px;
	}
</style>
</head>
<body class="d-flex flex-column min-vh-100">
	<%@ include file="/include/header.jsp" %>	
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	<div class="container2">
	   <div class="container flex-fill" style="width: 600px; height:650px; margin-top: 10px;">
	       <div class="d-inline-block tab-button" id="salTab" onclick="switchTab('sal')">월급</div>
	       <div class="d-inline-block tab-button" id="hsalTab" onclick="switchTab('hsal')">시급</div>
	   
	       <div class="tab-content" id="salContent" style="padding: 20px; background-color: #fff; border-top: 1px solid #ddd; display: none;">
	           <h3><strong>${ename }</strong> 님 월급으로 급여 계산</h3>
	           <button class="btn btn-dark" id="salBtn" style="padding: 10px;" onclick="show('sal')">급여 조회</button>
	           <div class="result" id="sal">
	           	   <label class="salary-label">기본급: <fmt:formatNumber value="${sal}" type="number"/> 원</label>
	         	   <label class="salary-label">국민연금: <fmt:formatNumber value="${sal * 0.045}" type="number"/> 원</label>
	               <label class="salary-label">건강보험료: <fmt:formatNumber value="${sal * 0.035}" type="number"/> 원</label>
	               <label class="salary-label">장기요양보험료: <fmt:formatNumber value="${sal * 0.0045}" type="number"/> 원</label>
	               <label class="salary-label">고용보험료: <fmt:formatNumber value="${sal * 0.0009}" type="number"/> 원</label>
	               <label class="salary-label">--------------------------------------</label>
	               <label class="salary-label">지급액 계: <fmt:formatNumber value="${sal}" type="number"/> 원</label>
	               <label class="salary-label">공제액 계: <fmt:formatNumber value="${sal * 0.0854}" type="number"/> 원</label>
	               <label class="salary-label"><strong>실수령 액: <fmt:formatNumber value="${sal * 0.9146}" type="number"/> 원</strong></label>
	               <label class="salary-label">지급일: 2025년 02월 15일</label>
	           </div>
	       </div>
	   
	       <div class="tab-content" id="hsalContent" style="padding: 20px; background-color: #fff; border-top: 1px solid #ddd; display: none;">
	           <h3><strong>${ename }</strong> 님 시급으로 급여 계산</h3>
			   <form id="inputForm">
				   <label for="week1">1주차:</label>
		           <input type="number" id="week1" name="week1" min="0" step="0.01" placeholder="1주차 근무시간 입력"/><br>
				   
				   <label for="week2">2주차:</label>
				   <input type="number" id="week2" name="week2" min="0" step="0.01" placeholder="2주차 근무시간 입력"/><br>
				   
				   <label for="week3">3주차:</label>
				   <input type="number" id="week3" name="week3" min="0" step="0.01" placeholder="3주차 근무시간 입력"/><br>
				   
				   <label for="week4">4주차:</label>
				   <input type="number" id="week4" name="week4" min="0" step="0.01" placeholder="4주차 근무시간 입력"/><br>
				   
				   <label for="week5">5주차:</label>
				   <input type="number" id="week5" name="week5" min="0" step="0.01" placeholder="5주차 근무시간 입력"/><br>
		
		           <button class="btn btn-dark" id="hsalBtn" style="padding: 10px;" onclick="show('hsal')">급여 조회</button>
	           </form>
			   <div class="result" id="hsal">
					<label>주차별 근무시간 및 주휴수당</label>
	           		<table id="hsalTable">
						<thead>
							<tr>
								<th>주차</th>
								<th>근무시간</th>
								<th>주휴수당</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								
							</tr>
						</tbody>
					</table>
	           	    <label class="hsalary-label">기본 시급: <fmt:formatNumber value="${hsal }" type="number"/> 원</label>
	           	    <label class="hsalary-label">총 기본급: <span id="totalPay">0</span> 원</label>
	         	    <label class="hsalary-label">총 주휴수당: <span id="totalOvertimePay">0</span> 원</label>
	                <label class="hsalary-label">총 급여: <span id="totalSal">0</span> 원</label>
	                <label class="hsalary-label">--------------------------------------</label>
	                <label class="hsalary-label">세율: 8.3 % </label>
	                <label class="hsalary-label"><strong>세율적용 급여: <span id="actualSal">0</span> 원</strong></label>
	           </div>      
	       </div>
	   </div>	
	</div>
    <footer class="footer">
        <jsp:include page="/include/footer.jsp" />
    </footer>
    
   <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>   
   <script>
   		//switchTab 함수 정의
		function switchTab(tab) {
		    const tabs = ['sal', 'hsal'];
	
		    tabs.forEach(t => {
		        document.getElementById(t + 'Content').style.display = (t == tab) ? 'block' : 'none';
		        document.getElementById(t + 'Tab').classList.toggle('active-tab', t == tab);
		    });
		}
	   
   	   //페이지 로딩 시 switchTab 호출하여 월급 또는 시급에 따라 활성탭 결정
	   window.onload = function () {
		    let sal = ${sal };
		    let hsal = ${hsal };
	
		    if (sal == 0) {
		        document.getElementById("salTab").classList.add("disabled");
		        document.getElementById("salTab").style.pointerEvents = "none";  // 클릭 방지
		        switchTab('hsal');  // 시급 탭 활성화
		    } else if (hsal == 0) {
		        document.getElementById("hsalTab").classList.add("disabled");
		        document.getElementById("hsalTab").style.pointerEvents = "none"; // 클릭 방지
		        switchTab('sal');  // 월급 탭 활성화
		    } else {
		        switchTab('sal'); // 기본 설정 월급 탭 활성화
		    }
		};

		// 급여 조회 버튼 누르면 내용 표시
	    function show(content) {
	  	  
	 	   const contents = ['sal', 'hsal'];
	 	   
	 	   document.getElementById(content).style.display = 'block'; 
	 	   
	    }
	       
	   // 폼 제출 버튼 클릭 시 처리
       $('#hsalBtn').click(function(event) {
           event.preventDefault();  // 폼 제출 방지

		   var hours = [];
           for (let i = 1; i <= 5; i++) {
               var time = $('#week' + i).val();
               if (time) {
                   hours.push(time);
               } else {
                   alert('모든 주차별 근무시간을 입력해주세요!');
                   $('#hsal').hide();
                   return;
               }
           }

		   var hourlyRate = ${hsal };  // 시급 값
		   
           // AJAX 요청 보내기
           $.ajax({
               type: 'POST',
               url: 'calculateSalary.jsp',  // 근무시간과 시급을 처리할 JSP 파일
               data: { hours: hours.join(","), hourlyRate: hourlyRate },
               success: function(response) {
                   // 서버에서 받은 응답으로 테이블 업데이트
                   $('#hsalTable tbody').append(response.tableRow);
                   $('#totalPay').text(response.totalPay);
				   $('#totalOvertimePay').text(response.totalOvertimePay);
				   $('#totalSal').text(response.totalSal);
				   $('#actualSal').text(response.actualSal);

                   // 입력 폼 숨기기
              	   $('#inputForm').hide();
               },
               error: function() {
                   alert("에러가 발생했습니다.");
                   $('input[type="number"]').val(''); //입력 필드 초기화
                   $('#hsal').hide();
                   return;
               }
           });
       });
	</script>

</body>
</html>