<%@page import="test.dao.UsingDao"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@page import="test.dto.Com1EmpDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int empno = (int) session.getAttribute("empno");
	Com1EmpDto dto = Com1EmpDao.getInstance().getData(empno);
	
	//int comid = dto.getComId();
	//String comname = UsingDao.getInstance().getComName(comid);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>프로필 수정</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<style>
	.container2 {
        max-width: 700px;
        margin: 40px auto;
        background-color: #fff;
        padding: 20px;
        border-radius: 8px;
        border: 1px solid black;
        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
    }
</style>
</head>
<body class="d-flex flex-column min-vh-100">
	<%@ include file="/include/header.jsp" %>	
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	<div class="main flex-grow-1" id="app">
		<div class="container2">
			<h1 class="mb-3">프로필 수정</h1>
			<form action="profileUpdate.jsp" method="post" id="myForm">
				<div class="mb-3">
					<label class="form-label">회사</label> <input class="form-control"
						type="text" name="comid" value="${comname }" readonly />
				</div>
				<div class="mb-3">
					<label class="form-label">사원 번호</label> <input class="form-control"
						type="text" name="empno" value="${empno }" readonly />
				</div>
				<div class="mb-3">
					<label class="form-label">이름</label> <input class="form-control"
						type="text" name="ename" value="${ename }" required />
				</div>
				<div class="mb-2">
					<label class="form-label" for="ecall">전화번호</label> <input
						v-model="ecall" @input="onEcallInput"
						:class="{'is-valid':isEcallValid,'is-invalid':!isEcallValid && isEcallDirty}"
						class="form-control" type="tel" name="ecall" id="ecall" required />
					<small class="form-text">하이픈(-)을 포함하여 기재해주세요.</small>
					<div class="invalid-feedback">전화번호를 확인하세요.</div>
				</div>
				<div class="mb-2">
					<label class="form-label" for="email">이메일</label> <input
						v-model="email" @input="onEmailInput"
						:class="{'is-valid': isEmailValid, 'is-invalid': !isEmailValid && isEmailDirty}"
						class="form-control" type="email" name="email" id="email"/>
					<div v-if="!isEmailValid && isEmailDirty" class="invalid-feedback">
						이메일 형식에 맞게 입력하세요.</div>
					<div v-if="isEmailValid && isEmailAvailable" class="valid-feedback">
						사용 가능한 이메일입니다.</div>
				</div>
				<div class="mb-3">
					<label class="form-label">기존 비밀번호</label> <input
						class="form-control" type="password" name="password" 
						v-model="password" @input="validateOldPassword"
						:class="{'is-invalid': !isPwdValid && isPwdDirty, 'is-valid': isPwdValid}" />
					<div class="valid-feedback">기존 비밀번호와 같습니다.</div>
				</div>
				<div class="mb-3">
					<label class="form-label">새 비밀번호 (선택사항)</label> <input
						class="form-control" type="password" name="newPassword"
						v-model="newPassword" @input="validateNewPassword"
						:class="{'is-invalid': !isNewPwdValid && isNewPwdDirty, 'is-valid': isNewPwdValid}" />
					<small class="form-text">비밀번호 변경을 원할 경우만 입력하세요.</small>
					<div class="invalid-feedback">영문자, 숫자, 특수문자를 포함하여 최소 8자리 이상 입력하세요.</div>
				</div>
				<div class="mb-3">
					<label class="form-label">새 비밀번호 확인</label> <input
						class="form-control" type="password" name="newPassword2"
						v-model="newPassword2" @input="validateNewPassword"
						:class="{'is-invalid': newPassword !== newPassword2 && newPassword2 !== '', 'is-valid': newPassword === newPassword2 && newPassword2 !== ''}" />
				</div>
				<button class="btn btn-success" type="submit"
					:disabled="!isPwdValid || (newPassword !== '' && !isNewPwdValid)">수정하기</button>
				
					<a class="btn btn-danger" href="${pageContext.request.contextPath }/companyone/staff/info/profileUpdateForm.jsp">리셋</a>
				
			</form>
		</div>
	</div>
	
  		<jsp:include page="/include/footer.jsp" />

	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	<script>
	    new Vue({
	        el: "#app",
	        data: {
	        	email:"<%=dto.getEmail()%>",
	        	ecall:"<%=dto.geteCall()%>",
	            password: "",
	            newPassword: "",
	            newPassword2: "",
	            //비밀번호 검증
	            isPwdValid: false,
	            isNewPwdValid: false,
	            isPwdDirty: false,
	            isNewPwdDirty: false,
	            //이메일과 전화번호
	            isEmailValid: false,
	            isEmailDirty: false,
	            isEmailValid: false,
	            isEcallValid: false,
	            isEcallDirty: false,
	            //전화번호 검증 표현식
	            hasLetter: false,
	            hasNumber: false,
	            hasSpecial: false,
	            hasMinLength: false,
	            hasSpace:false
	        },
	        methods: {
	            validateOldPassword() {
	                this.isPwdDirty = true;
	                
	                if(this.password==="<%=dto.getePwd()%>"){
	                	this.isPwdValid=true;
	                }else{
	                	this.isPwdValid=false;
	                }
	                
	            },
	            validateNewPassword() {
	                this.isNewPwdDirty = true;
	                const regLetter = /[A-Za-z]/;
	                const regNumber = /\d/;
	                const regSpecial = /[\W_]/;
	                const regMinLength = /^.{8,}$/;
	                const space = /\s/;
	
	                this.hasLetter = regLetter.test(this.newPassword);
	                this.hasNumber = regNumber.test(this.newPassword);
	                this.hasSpecial = regSpecial.test(this.newPassword);
	                this.hasMinLength = regMinLength.test(this.newPassword);
	                this.hasSpace = space.test(this.newPassword);
	                
	                this.isNewPwdValid = this.hasLetter && this.hasNumber && this.hasSpecial && this.hasMinLength && !this.hasSpace;
	                if(this.password==this.newPassword){
	                	alert("기존 비밀번호와 일치합니다.");
	                	location.href = "<%= request.getContextPath() %>/companyone/staff/info/profileUpdateForm.jsp";
	                }
	                
	            },
	            onEmailInput() {
	                const reg_email = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
	                this.isEmailDirty = true;
	                this.isEmailValid = reg_email.test(this.email);
	                
	                if (this.isEmailValid) {
	                    fetch("${pageContext.request.contextPath }/checkEmail", {
	                        method: 'POST',
	                        headers: {
	                            'Content-Type': 'application/x-www-form-urlencoded'
	                        },
	                        body: 'email=' + encodeURIComponent(this.email) + '&role=' + encodeURIComponent('STAFF')
	                    })
	                    .then(res => res.json())
	                    .then(data => {
	                        if (data.isDuplicate) {
	                        	alert("이미 등록된 이메일입니다.");
	                            this.isEmailValid = false;
	                            this.isEmailAvailable = false; 
	                            this.email = ''; 
	                        } else {
	                            this.isEmailAvailable = true; 
	                        }
	                    });
	                } else {
	                    this.isEmailAvailable = false;
	                    
	                }
	            },
	            onEcallInput() {
	                const reg_ecall = /^01[016789]-\d{3,4}-\d{4}$/;
	                this.isEcallDirty = true;
	                this.isEcallValid = reg_ecall.test(this.ecall);
	                
	                if (this.isEcallValid) {
	                    fetch("${pageContext.request.contextPath }/checkEcall", {
	                        method: 'POST',
	                        headers: {
	                            'Content-Type': 'application/x-www-form-urlencoded'
	                        },
	                        body: 'ecall=' + encodeURIComponent(this.ecall) + '&role=' + encodeURIComponent('STAFF')
	                    })
	                    .then(res => res.json())  
	                    .then(data => {
	                        if (data.isDuplicate) {
	                        	alert('이미 등록된 전화번호입니다.');  
	                            this.isEcallValid = false; 
	                            this.ecall = "";
	                        } else {
	                            alert('사용 가능한 전화번호입니다.'); 
	                        }
	                    })
	                    .catch(error => {
	                        alert('에러 발생: ' + error); 
	                    });
	                }  
	            }
	        }
	    });
	</script>
</body>
</html>