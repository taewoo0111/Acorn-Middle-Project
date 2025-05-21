<%@page import="test.dao.UsingDao"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@page import="test.dto.Com1EmpDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	int empno=(int)session.getAttribute("empno");
	Com1EmpDto empdto = Com1EmpDao.getInstance().getData(empno);
	String originpwd = empdto.getePwd();
	String comname=(String)session.getAttribute("comname");
	
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>점장정보조회</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
<style>
	.tbl_row_wrap {
        border: 1px solid #dee2e6; /* 전체 테이블 테두리 */
        border-radius: 10px; /* 둥근 테두리 */
        padding: 20px;
        background-color: #fff; /* 테이블 배경 */
    }

    .tbl_row {
        width: 100%;
        border-collapse: separate;
    }

    .tbl_row th, .tbl_row td {
        padding: 12px;
        border-bottom: 1px solid #dee2e6; /* 행 구분선 */
    }

    .tbl_row th {
        background-color: #f8f9fa; /* 제목 부분 배경색 */
        text-align: left;
        font-weight: bold;
        width: 250px;
    }

    .tbl_row:last-child tr:last-child th, .tbl_row:last-child tr:last-child td  {
        border-bottom: none; /* 마지막 줄 구분선 제거 */
    }
    
    #modify{
    	background-color: #28A745;
    	border-color: #28A745;
    }
   
   
</style>
</head>
<body class="d-flex flex-column min-vh-100">
	<%@ include file="/include/header.jsp" %>	
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	<div class="main flex-grow-1">
		<div class="container" id="app">
			<h3>회원 정보 수정</h3>
			<form action="update.jsp" method="get" id="callupdateForm" @submit.prevent="onSubmit">
				<div class="mb-3">
					<label class="form-label">회사</label> <input class="form-control"
						type="text" name="comid" value="<%=comname%>" readonly />
				</div>
				<div class="mb-2">
					<label class="form-label" for="storenum">소속 지점</label>
					<input class="form-control" type="text" id="storenum" name="storenum" value="<%=empdto.getStoreNum() %>" readonly />
				</div>
				<div class="mb-2">
					<label class="form-label" for="empno">사원 번호</label>
					<input class="form-control" type="text" id="empno" name="empno" value="<%=empdto.getEmpNo() %>" readonly />
				</div>
				<div class="mb-2">
					<label class="form-label" for="sal">월급</label>
					<input class="form-control" type="text" id="sal" name="sal" value="<%=empdto.getSal() %>" readonly />
				</div>
				<div class="mb-2">
					<label class="form-label" for="ename">이름</label>
					<input v-model="ename" :class="{'is-valid': isEnameValid, 'is-invalid': !isEnameValid && isEnameDirty}"
						@input="onEnameInput" class="form-control" type="text" name="ename" id="ename" value="<%=empdto.geteName() %>" required/>
					<div class="invalid-feedback">이름을 올바르게 입력하세요.</div>
				</div>
				<div class="mb-2">
					<label class="form-label" for="ecall">연락처</label> 
					<input class="form-control" @input="onEcallInput" :class="{'is-invalid': !isEcallValid && isEcallDirty, 'is-valid':isEcallValid}"
						type="text" name="ecall" id="ecall" v-model="ecall" value="<%=empdto.geteCall() %>" required/>
					<small class="form-text">하이픈(-)을 포함하여 기재해주세요.</small>
					<div class="invalid-feedback">전화번호 형식에 맞지 않습니다.</div>
				</div>
				<div class="mb-2">
				    <label class="form-label" for="password">기존 비밀번호</label> 
				    <input class="form-control" @input="onPwdInput"
				        :class="{
				            'is-invalid': (!isPwdValid && isPwdDirty) || (!isOriginPwdMatch && isOriginPwdMatchDirty), 
				            'is-valid': isPwdValid && isOriginPwdMatch
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
				<div class="mb-2">
					<label class="form-label" for="email">이메일</label> 
					<input v-model="email" @input="onEmailInput"
						:class="{'is-valid': isEmailValid, 'is-invalid': !isEmailValid && isEmailDirty}"
						class="form-control" type="email" name="email" id="email" value="<%=empdto.getEmail() %>" required/>
					<div v-if="!isEmailValid && isEmailDirty" class="invalid-feedback">
						이메일 형식에 맞게 입력하세요.</div>
					<div v-if="isEmailValid && !isEmailAvailable"
						class="invalid-feedback">이미 등록된 이메일입니다.</div>
					<div v-if="isEmailValid && isEmailAvailable" class="valid-feedback">
						사용 가능한 이메일입니다.</div>
				</div>
				<button class="btn btn-success" type="submit">수정하기</button>
			</form>
		</div>
		
	</div>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	<jsp:include page="/include/footer.jsp" />

<script>
    new Vue({
        el:"#app",
        data:{
            ename:"<%=empdto.geteName()%>",
            email:"<%=empdto.getEmail()%>",
            ecall:"<%=empdto.geteCall()%>",
            password: "",  
            isPwdValid:false,
            isNewPwdValid:false,
            isEcallValid:false,
            isEnameValid: false,
            isEnameDirty: false,
            isEmailDirty: false,
            isEmailValid: false,
            newPassword:"",
            newPassword2:"",
            isNewPwdMatch: false,
            isNewPwdMatchDirty: false,
            isEcallDirty:false,
            isPwdDirty:false,  // 비밀번호 입력란에 한 번이라도 입력했는지 여부
            isNewPwdDirty:false, // 새 비밀번호 입력란에 한 번이라도 입력했는지 여부
            isSameOriginPwd: false, // 기존 비밀번호와 새 비밀번호 비교
	        isSameOriginPwdDirty: false 
        },
        computed: {
            isNewPwdSame() {
                return this.newPassword === this.password && this.newPassword !== "";
            }
        },
        methods:{
            onEnameInput(e) {
                this.ename = e.target.value; 
                const reg_ename = /^[가-힣]{2,5}$/; 
                this.isEnameDirty = true;
                this.isEnameValid = reg_ename.test(this.ename);
            },
            onEcallInput(){
                const reg_ecall=/^01[016789]-\d{3,4}-\d{4}$/;
                this.isEcallDirty = true;
                this.isEcallValid = reg_ecall.test(this.ecall);
                
                if (this.isEcallValid) {
                    fetch("../../../checkEcall", {
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
            onPwdInput(e) {
                const enteredPwd = e.target.value;
                const reg_pwd = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[\W_]).{8,}$/;

                this.isPwdDirty = true;
                this.isPwdValid = reg_pwd.test(enteredPwd);

                // 기존 비밀번호와 입력한 비밀번호 비교
                this.isOriginPwdMatchDirty = true;
                this.isOriginPwdMatch = (enteredPwd === "<%=empdto.getePwd()%>");
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
            onEmailInput() {
                const reg_email = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                this.isEmailDirty = true;
                this.isEmailValid = reg_email.test(this.email);
                
                if (this.isEmailValid) {
                    fetch("../../../checkEmail", {
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
        }
    });
</script>
</body>
</html>