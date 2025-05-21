<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 

<%
	int empno = Integer.parseInt(request.getParameter("empno"));
	String returnurl = request.getParameter("returnurl");
	Com1EmpDao dao=Com1EmpDao.getInstance();
	Com1EmpDto dto= dao.getData(empno);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근무시간 수정폼</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
<style>
	.containers {
        max-width: 600px;
        margin: 40px auto;
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        border: 1px solid black;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
    .invalid-feedback{
		display:none;
		color: red; 
	}
</style>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
<%@ include file="/include/header.jsp" %>
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	<%--main컨텐츠감싸기 --%>
	<div class="main flex-grow-1">  
		<div class="containers" id ="app">
		
			<h1>근무시간 급여변경</h1>
			<form action="salUpdate.jsp?returnurl=<%=returnurl%>" method="post" id="myForm">
			
				<div class="mb-3">
					<label class="form-label">회사ID</label> 
					<input class="form-control" type="text" name="comid" value="<%=dto.getComId()%>" readonly />
				</div>
				<div class="mb-3">
					<label class="form-label">소속지점</label> 
					<input class="form-control" type="text" name="storenum" value="<%=dto.getStoreNum()%>" readonly />
				</div>
				<div class="mb-3">
					<label class="form-label">사원번호</label> 
					<input class="form-control" type="text" name="empno" value="<%=dto.getEmpNo()%>" readonly />
				</div>
				<div class="mb-3">
					<label class="form-label">이름</label> 
					<input class="form-control" type="text" name="ename" value="<%=dto.geteName()%>" readonly />
				</div>
				<p style="color: green">알바는 시급과 근무시간만 기입 / 직원은 월급만 기입해주세요</p>
				<div class="mb-3">
					<label class="form-label">월급</label> 
					<input class="form-control" type="text" name="sal" id="sal" required oninput="salInput()"
						v-model="sal" @input="validatesal" 
						:class="{'is-invalid': !issalValid && issalDirty, 'is-valid': issalValid}"/>
					<div class="invalid-feedback">양수를 입력하세요.</div>
					<div class="valid-feedback">직원은 월급만 입력해주세요.</div>
				</div>
				<div class="mb-3">
					<label class="form-label">시급</label> 
					<input class="form-control" type="text" name="hsal" id="hsal" required oninput="hsalInput()"
						v-model="hsal"  @input="validatehsal"
						:class="{'is-invalid': !ishsalValid && ishsalDirty, 'is-valid': ishsalValid}"/>
						<div class="invalid-feedback">양수를 입력하세요.(시급과 근무시간을 함께 입력하세요)</div>
				</div>
				<div class="mb-3">
					<label class="form-label">근무시간</label> 
					<input class="form-control" type="text" name="worktime" id="worktime" required oninput="hsalInput()"
						v-model="worktime" @input="validateworktime"
						:class="{'is-invalid': !isworktimeValid && isworktimeDirty, 'is-valid': isworktimeValid}"/>
						<div class="invalid-feedback">양수를 입력하세요.(시급과 근무시간을 함께 입력하세요)</div>
				</div>
				<div class="d-flex justify-content-between">
					<button class="btn btn-success" type="submit" id="subBtn" 
						:disabled="!(issalValid && ishsalValid && isworktimeValid)"
					>수정하기</button>
					<a href="<%=returnurl%>" class="btn btn-danger btn-block mb-2">돌아가기</a>
				</div>
			</form>
	
		</div>
	</div> <%--메인 --%>
	<%--푸터 --%>
	<jsp:include page="/include/footer.jsp" />
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	<script>
    new Vue({
        el: "#app",
        data: {
            sal: "<%=dto.getSal()%>",
            hsal: "<%=dto.getHsal()%>",
            worktime: "<%=dto.getWorktime()%>",
			
            issalDirty: false,
            issalValid: false,
            
            ishsalValid: false,
            ishsalDirty: false,
            
            isworktimeValid: false,
            isworktimeDirty: false,
        },
        methods: {
            validatesal() {
            	this.hsal= "0";
            	this.worktime= "0";
            	this.ishsalValid = true;
            	this.isworktimeValid = true;
            	
            	this.issalDirty = true;
                const reg= /^[1-9]\d*$/;
                this.issalValid = reg.test(this.sal);
                
            },
            validatehsal() {
            	this.sal= "0";
                this.ishsalDirty = true;
                const reg= /^[1-9]\d*$/;
                this.ishsalValid = reg.test(this.hsal);     
                this.isworktimeValid = reg.test(this.worktime);
                
                if (this.ishsalValid || this.isworktimeValid) {
			        this.issalValid = true;
			    } 
            },
            validateworktime() {
            	this.sal= "0";
                this.isworktimeDirty = true;
                const reg= /^[1-9]\d*$/;
                this.isworktimeValid = reg.test(this.worktime);  
                this.ishsalValid = reg.test(this.hsal); 
                
                if (this.ishsalValid && this.isworktimeValid) {
			        this.issalValid = true;
			    } 
                /*else {
			        this.issalValid = false;
			    }*/
            }
        }
    }); 
	//뷰
	
	/*
    function salInput() {
        let sal = document.getElementById("sal");
        let hsal = document.getElementById("hsal");
        let worktime = document.getElementById("worktime");

        if (sal.value.trim() !== ""  ) {
            hsal.setAttribute("readonly","");
            worktime.setAttribute("readonly","");
            hsal.value = "0";
            worktime.value = "0";
        	
        } else {
            hsal.removeAttribute("readonly");
           	worktime.removeAttribute("readonly");
        }
    }

    function hsalInput() {
        let sal = document.getElementById("sal");
        let hsal = document.getElementById("hsal");
        let worktime = document.getElementById("worktime");

        if ( hsal.value.trim() !== "" || worktime.value.trim() !== "" ) {
        	sal.setAttribute("readonly","");
            
            sal.value = "0";
        }
        else {
        	sal.removeAttribute("readonly");
        }
    }
    
    */
    
    

	
    
</script>

</body>
</html>
