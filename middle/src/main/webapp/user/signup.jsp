<%@page import="test.dao.Com1Dao"%>
<%@page import="test.dao.UsingDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<%
	List<Integer> comIdList= UsingDao.getInstance().getComIdList();
	List<Integer> storeNumList = Com1Dao.getInstance().getStoreNumList();
	
	String message = request.getParameter("message");
    if ("fail".equals(message)) {
%>
	<script>
        alert("실패! 다시 회원가입 페이지로 이동합니다!");
        window.location.href = "signup.jsp";
    </script>
<%
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
<style>
#app {
	padding: 20px;
}
</style>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
<%@ include file="/include/header.jsp"%>

	<div class="container mt-4 mb-4 flex-fill" id="app">
		<h1>회원가입</h1>
		<form action="${pageContext.request.contextPath}/signup" method="post"
			id="signupForm" novalidate>
			<div class="mb-2">
				<label for="comid" class="form-label">매장</label> <select
					v-model="comid" class="form-control" id="comid" name="comid"
					required>
					<option value="">선택하세요</option>
					<% 
            		if (comIdList != null && !comIdList.isEmpty()) {
                	for (int comidtmp : comIdList) { 
        		%>
					<option value="<%= comidtmp %>"><%= comidtmp %></option>
					<% 
                		} 
            		} else { 
        		%>
					<option disabled>등록된 매장이 없습니다</option>
					<% 
            	} 
        		%>
				</select>
			</div>
			<div class="mb-2">
				<label for="storenum" class="form-label">영업점</label> <select
					v-model="storenum" class="form-control" id="storenum"
					name="storenum" required>
					<option value="">선택하세요</option>
					<% for (int storenumtmp : storeNumList) { %>
					<option value="<%= storenumtmp %>"><%=storenumtmp %></option>
					<% } %>
				</select>
			</div>
			<!-- 이름 입력 -->
			<div class="mb-2">
				<label class="form-label" for="ename">이름</label> <input
					v-model="ename"
					:class="{'is-valid': isEnameValid, 'is-invalid': !isEnameValid && isEnameDirty}"
					@input="onEnameInput" class="form-control" type="text" name="ename"
					id="ename" required />
				<div class="invalid-feedback">이름을 올바르게 입력하세요.</div>
			</div>
			<!-- 역할 선택 -->
			<div class="mb-2">
				<label class="form-label" for="role">역할</label> <select
					v-model="role" class="form-control" name="role" id="role" required>
					<option value="">선택하세요</option>
					<option value="ADMIN">점장</option>
					<option value="STAFF">직원</option>
				</select>
			</div>
			<!-- 비밀번호 입력 -->
			<div class="mb-2">
				<label class="form-label" for="pwd">비밀번호</label> <input
					v-model="pwd" @input="onPwdInput"
					:class="{'is-valid': isPwdValid, 'is-invalid': !isPwdValid && isPwdDirty}"
					class="form-control" type="password" name="pwd" id="pwd" /> 
				<small class="form-text">영문자, 숫자, 특수문자를 포함하여 최소 8자리 이상 입력하세요.</small>
			</div>

			<ul class="text-danger small">
				<li :class="{'text-success': hasLetter}">영문자 포함</li>
				<li :class="{'text-success': hasNumber}">숫자 포함</li>
				<li :class="{'text-success': hasSpecial}">특수문자 포함</li>
				<li :class="{'text-success': hasMinLength}">최소 8자리 이상</li>
			</ul>

			<div class="mb-2">
				<label class="form-label" for="pwd2">비밀번호 확인</label> <input
					v-model="pwd2" @input="onPwd2Input"
					:class="{'is-valid': isPwd2Valid, 'is-invalid': !isPwd2Valid && isPwd2Dirty}"
					class="form-control" type="password" id="pwd2" />
				<div class="invalid-feedback">비밀번호가 일치하지 않습니다.</div>
			</div>

			<!-- 전화번호 입력 -->
			<div class="mb-2">
				<label class="form-label" for="ecall">전화번호</label> <input
					v-model="ecall" @input="onEcallInput"
					:class="{'is-valid':isEcallValid,'is-invalid':!isEcallValid && isEcallDirty}"
					class="form-control" type="tel" name="ecall" id="ecall" required />
				<small class="form-text">하이픈(-)을 포함하여 기재해주세요.</small>
				<div class="invalid-feedback">전화번호를 확인하세요.</div>
			</div>

			<!-- 이메일 입력 -->
			<div class="mb-2">
				<label class="form-label" for="email">이메일</label> <input
					v-model="email" @input="onEmailInput"
					:class="{'is-valid': isEmailValid, 'is-invalid': !isEmailValid && isEmailDirty}"
					class="form-control" type="email" name="email" id="email" />
				<div v-if="!isEmailValid && isEmailDirty" class="invalid-feedback">
					이메일 형식에 맞게 입력하세요.</div>
				<div v-if="isEmailValid && !isEmailAvailable"
					class="invalid-feedback">이미 등록된 이메일입니다.</div>
				<div v-if="isEmailValid && isEmailAvailable" class="valid-feedback">
					사용 가능한 이메일입니다.</div>
			</div>
			<button class="btn btn-dark" type="submit"
				v-bind:disabled="!isEnameValid || !isPwdValid || !isEmailValid || role === '' || storenum === '' || comid === ''">
				가입</button>
		</form>
	</div>

	<%@ include file="/include/footer.jsp"%>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	<script>
	
    new Vue({
        el:"#app",
        data:{
            ename: "",
            pwd: "",
            pwd2:"",
            role:"",
            isEnameValid: false,
            isEnameDirty: false,
            isPwd2Valid: false,
            isPwd2Dirty: false,
            isEcallValid: false,
            isEcallDirty: false,
            isEmailValid: false,
            isEmailDirty: false,
            isEmailValid: false,
            isPwdValid: false,
            isPwdDirty: false,
            hasLetter: false,  
            hasNumber: false,  
            hasSpecial: false, 
            hasMinLength: false,
           	comid:"",
           	storenum:"",
           	ecall:"",
           	email:""
        },
        methods:{
            onEnameInput() {
                const reg_ename = /^[가-힣]{2,5}$/; 
                this.isEnameDirty = true;
                this.isEnameValid = reg_ename.test(this.ename);
            },
            onPwdInput() {
                this.isPwdDirty = true;
                const regLetter = /[A-Za-z]/;
                const regNumber = /\d/;
                const regSpecial = /[\W_]/;
                const regMinLength = /^.{8,}$/;

                this.hasLetter = regLetter.test(this.pwd);
                this.hasNumber = regNumber.test(this.pwd);
                this.hasSpecial = regSpecial.test(this.pwd);
                this.hasMinLength = regMinLength.test(this.pwd);
                this.isPwdValid = this.hasLetter && this.hasNumber && this.hasSpecial && this.hasMinLength;
                // this.onPwd2Input();
            },
            onPwd2Input() {
                this.isPwd2Dirty = true;
                this.isPwd2Valid = this.pwd === this.pwd2; 
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
                        body: 'ecall=' + encodeURIComponent(this.ecall) + '&role=' + encodeURIComponent('ADMIN')
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
                        body: 'email=' + encodeURIComponent(this.email) + '&role=' + encodeURIComponent('ADMIN')
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
            }
    	} 
    });
</script>
</body>
</html>
