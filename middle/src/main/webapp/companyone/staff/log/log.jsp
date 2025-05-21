<%@page import="test.dao.Com1EmpLogDao"%>
<%@page import="test.dto.Com1EmpLogDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//int empno = (int)session.getAttribute("empno");
	session.setAttribute("current_page", "log");

	Com1EmpLogDto dto = new Com1EmpLogDto();
	//dto.setEmpno(empno);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출퇴근 페이지</title>
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<style>
	.container2 {
        max-width: 800px;
        margin: 40px auto;
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        border: 1px solid black;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    .time-container{
    	text-align: center;
    }
    .clock h1{
    	font-size:70px;
    	font-weight:bold;
    	padding: 30px 0 60px 0;
    }
	.button-container {
        display: flex;
        justify-content: space-around;
        margin-top: 30px;
    }
    .btn {
        padding: 20px 30px; 
        font-size: 30px;
        width: 200px;
    }
    .btn:disabled {
        background-color: #ccc; 
        cursor: not-allowed; 
    }
    
</style>
</head>
<body>
	<%@ include file="/include/header.jsp" %>	
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	<div class="container2">
		<h1>출/퇴근</h1>
		<div class="time-container">
			<div class="clock">
        		<h1>00:00:00</h1>
   			</div>
			<div class="btn-container d-flex justify-content-around">
				<button id="startBtn" class="btn btn-primary">출근</button>
				<button id="endBtn" class="btn btn-primary">퇴근</button>
			</div>
		</div>
		<br>
		<a href="logTable.jsp">근태 기록 확인</a> 
	</div>
	<div class="position-fixed bottom-0 w-100">
  		<jsp:include page="/include/footer.jsp" />
  	</div>
  	<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
	<script>
		//시간 함수
		function Time(){
		    const date = new Date();
		    const hour = date.getHours(); //시
		    const minute = date.getMinutes(); //분
		    const second = date.getSeconds(); //초
		    $(".clock h1").text(`\${hour}:\${minute}:\${second}`);
		    return `\${hour}:\${minute}:\${second}`;
		}
		//시계 표현
		function show(){
		    Time();
		    setInterval(Time,1000);
		}
		show();
		
		// 초기 상태 설정: 퇴근 버튼 비활성화
		endBtn.disabled = true;
		
		//출근 버튼 클릭 시
		$("#startBtn").click(() => {
            startBtn.disabled = true;
            endBtn.disabled = false;
            $.ajax({
                url: 'workStartLog.jsp',
                method: 'post',
                data: {
                    empno: '${empno}',
                },
                success: (res) => {
                    alert("출근 완료!");
                },
                error: (err) => {
                    console.error("출근 기록 실패:", err);
                    startBtn.disabled = false;
                    endBtn.disabled = true;
                }
            });
        });

        // 퇴근 버튼 클릭 시
        $("#endBtn").click(() => {
            $.ajax({
                url: 'workEndLog.jsp',
                method: 'post',
                data: {
                    empno: '${empno}',
                },
                success: (res) => {
                    alert("퇴근 완료!");
                    startBtn.disabled = false;
                    endBtn.disabled = true;
                },
                error: (err) => {
                    console.error("퇴근 기록 실패:", err);
                    startBtn.disabled = true;
                    endBtn.disabled = false;
                }
            });
        });
    </script>
</body>
</html>