<%@page import="test.dao.Com1CeoDao"%>
<%@page import="test.dto.Com1CeoDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
	int empno=(int)session.getAttribute("empno");
	//Com1CeoDao dao = Com1CeoDao.getInstance();
	//Com1CeoDto dto = dao.getData(empno);
	Com1CeoDto dto = Com1CeoDao.getInstance().getData(empno);
	
	// 로그인한 사용자의 정보를 DB에서 가져오기 (예시)
	//Com1CeoDto ceoInfo = Com1CeoDao.getInstance().getData(empno); // 사원번호를 이용하여 CEO 정보를 조회

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/ceo/protected/updateform_ceo</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
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
</style>
</head>
<body>
	<%@ include file="/include/header.jsp" %>
	<%-- 관리자 페이지 전용 네비바: 관리자 페이지 이동을 쉽게 하기 위함 --%>
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	<div class="container2" id="app">
		<h3>회원 정보 수정 양식</h3>
		<form action="update.jsp" method="get" id="callupdateForm" @submit.prevent="onSubmit" novalidate>
			<div class="mb-2">
				<label class="form-label" for="ename">이름</label>
				<input v-model="ename" :class="{'is-valid': isEnameValid && isEnameDirty, 'is-invalid': !isEnameValid && isEnameDirty}"
					@input="onEnameInput" class="form-control" type="text" name="ename" id="ename" value="<%=dto.geteName() %>" required/>
				<div class="invalid-feedback">이름을 올바르게 입력하세요.</div>
			</div>
			<div class="mb-2">
				<label class="form-label" for="ecall">연락처</label> 
				<input class="form-control" @input="onEcallInput" :class="{'is-invalid': !isEcallValid && isEcallDirty, 'is-valid':isEcallValid}"
					type="text" name="ecall" id="ecall" v-model="ecall" value="<%=dto.geteCall() %>" required/>
				<small class="form-text">하이픈(-)을 포함하여 기재해주세요.</small>
				<div class="invalid-feedback">전화번호 형식에 맞지 않습니다.</div>
			</div>
			<div class="mb-2">
				    <label class="form-label" for="password">기존 비밀번호</label> 
				    <input class="form-control" @input="onPwdInput"
				        :class="{
				            'is-invalid':!isOriginPwdMatch && isOriginPwdMatchDirty, 
				            'is-valid': isOriginPwdMatchDirty && isOriginPwdMatch
				        }"
				        type="password" name="password" id="password" v-model="password" required/>
				    <div class="invalid-feedback" v-if="!isOriginPwdMatch && isOriginPwdMatchDirty">비밀번호가 일치하지 않습니다.</div>
				</div>
				<div class="mb-2">
				    <label class="form-label" for="newPassword">새 비밀번호 (선택사항)</label> 
				    <input class="form-control" type="password" name="newPassword" id="newPassword"
				        @input="onNewPwdInput" v-model="newPassword"
				        :class="{
				            'is-invalid': (!isNewPwdValid && isNewPwdDirty) || (isSameOriginPwd && isSameOriginPwdDirty), 
				            'is-valid': isNewPwdValid && !isSameOriginPwd
				        }"/>
				    <small class="form-text">영문자, 숫자, 특수문자를 포함하여 최소 8자리 이상 입력하세요.</small>
				    <div class="invalid-feedback" v-if="!isNewPwdValid && isNewPwdDirty">비밀번호 형식이 올바르지 않습니다.</div>
				    <div class="invalid-feedback" v-if="isSameOriginPwd && isSameOriginPwdDirty">기존 비밀번호와 같습니다.</div> 
				</div>
				<div class="mb-2">
					<label class="form-label" for="newPassword2">새 비밀번호 확인</label> 
					<input class="form-control" type="password" id="newPassword2" 
					    @input="onNewPwdConfirmInput" v-model="newPassword2"
					    :class="{'is-invalid': !isNewPwdMatch && isNewPwdMatchDirty, 'is-valid': isNewPwdMatch && isNewPwdMatchDirty}" />
					<div class="invalid-feedback">비밀번호가 일치하지 않습니다.</div>
				</div>
			<button class="btn btn-success" type="submit" :disabled="!(isOriginPwdMatch&&((isEcallValid&isEcallDirty)||(isEnameValid&&isEnameDirty)||(isNewPwdMatchDirty&&isNewPwdMatch)))">수정하기</button>
		</form>
	</div>
		
	<div class="position-fixed bottom-0 w-100">
	<%@ include file="/include/footer.jsp" %>
  	</div>
  	
  	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	<script>
		new Vue({
			el:"#app",
			data:{
				ename:"<%=dto.geteName()%>",
	            ecall:"<%=dto.geteCall()%>",
	            password: "",  
	            isPwdValid:false,
	            isNewPwdValid:false,
	            isEcallValid:false,
	            isEnameValid: true,
	            isEnameDirty: false,
	            newPassword:"",
	            newPassword2:"",
	            isNewPwdMatch: false,
	            isNewPwdMatchDirty: false,
	            isEcallDirty:false,
	            isPwdDirty:false,  // 비밀번호 입력란에 한 번이라도 입력했는지 여부
	            isNewPwdDirty:false, // 새 비밀번호 입력란에 한 번이라도 입력했는지 여부
	            isSameOriginPwd: false, // 기존 비밀번호와 새 비밀번호 비교
		        isSameOriginPwdDirty: false,
		        isOriginPwdMatch: false,
		        isOriginPwdMatchDirty: false
	        },
			methods:{
				onEnameInput(e) {
					this.isEnameValid = false;
					this.ename = e.target.value; 
	                const reg_ename = /^[가-힣]{2,5}$/; 
	                this.isEnameDirty = true;
	                
	                if(this.isEnameDirty){
	                	this.isEnameValid = reg_ename.test(this.ename);
	                }
	            },
				onEcallInput(){
					//현재까지 입력한 비밀번호
					
					//공백이 아닌 한글자가 한번이상 반복 되어야 통과 되는 정규표현식
					const reg_ecall=/^01[016789]-\d{3,4}-\d{4}$/;
					this.isEcallDirty = true;
					this.isEcallValid = reg_ecall.test(this.ecall);
					
					if (this.isEcallValid) {
	                    fetch("../../../checkEcall", {
	                        method: 'POST',
	                        headers: {
	                            'Content-Type': 'application/x-www-form-urlencoded'
	                        },
	                        body: 'ecall=' + encodeURIComponent(this.ecall) + '&role=' + encodeURIComponent('CEO')
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
				onPwdInput(e) {
	                const enteredPwd = e.target.value;
	                //const reg_pwd = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[\W_]).{8,}$/;

	                //this.isPwdDirty = true;
	                //this.isPwdValid = reg_pwd.test(enteredPwd);

	                // 기존 비밀번호와 입력한 비밀번호 비교
	                this.isOriginPwdMatchDirty = true;
	                this.isOriginPwdMatch = (enteredPwd =="<%=dto.getePwd()%>");
	            },
	            onNewPwdInput() {
	                const reg_pwd = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[\W_]).{8,}$/;
	                this.isNewPwdDirty = true;
	                this.isNewPwdValid = reg_pwd.test(this.newPassword); 
	                this.isSameOriginPwdDirty = true; 
	                this.isSameOriginPwd = this.newPassword === this.password; 
	            },
				onNewPwdConfirmInput() {
				    this.isNewPwdMatch = this.newPassword === this.newPassword2 && this.newPassword2.trim() !== ""; 
				    this.isNewPwdMatchDirty = true; 
				},
				onSubmit(event) {
	            	if (this.password==this.newPassword){
						alert("새 비밀번호가 기존 비밀번호와 같습니다.")
						event.preventDefault();
						return;
					}
				    if(this.isNewPwdDirty && this.isNewPwdMatchDirty){
	            		if (this.newPassword != this.newPassword2) {
				        	alert("비밀번호 확인란이 입력되지 않았습니다.");
				        	event.preventDefault(); 
				        	return;
				    	}
				    	if (!this.isNewPwdMatch) {
				        	alert("비밀번호가 일치하지 않습니다.");
				        	event.preventDefault();
				        	return;
				    	} 
				    }
				    document.getElementById("callupdateForm").submit();
				}
		}});
	</script>
</body>
</html>