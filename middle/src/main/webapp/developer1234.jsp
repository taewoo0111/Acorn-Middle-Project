<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등록 페이지</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<style>
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

    .login-form {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }
</style>
</head>
<body class="d-flex flex-column min-vh-100">
<%@ include file="/include/header.jsp" %>
   <div class="container flex-fill" style="width: 600px; margin-top: 50px;">
       <div class="d-inline-block tab-button" id="companyTab" onclick="switchTab('company')">회사 등록</div>
       <div class="d-inline-block tab-button" id="storeTab" onclick="switchTab('store')">체인점 등록</div>
       <div class="d-inline-block tab-button" id="ceoTab" onclick="switchTab('ceo')">관리자 등록</div>
			
		<div id="companyContent" class="tab-content" style="padding: 20px; background-color: #fff; border-top: 1px solid #ddd; display: block;">
			<h1>회사 등록</h1>
			<form action="developer/insertCompany.jsp" method="get">
				<label for="comname">회사 이름</label>
				<input type="text" id="comname" name="comname" style="padding: 10px; width: 100%;">
				<br />
				<button type="submit" style="padding: 10px; margin-top: 15px;">등록</button>
			</form>
		</div>

		<div id="storeContent" class="tab-content" style="padding: 20px; background-color: #fff; border-top: 1px solid #ddd; display: none;">
			<h1>체인점 등록</h1>
			<form action="developer/insertStore.jsp" method="get">
				<label for="storecall">매장 전화번호</label>
				<input type="text" id="storecall" name="storecall" style="padding: 10px; width: 100%;">
				<br />
				<button type="submit" style="padding: 10px; margin-top: 15px;">등록</button>
			</form>
		</div>

		<div id="ceoContent" class="tab-content" style="padding: 20px; background-color: #fff; border-top: 1px solid #ddd; display: none;">
			<h1>관리자 등록</h1>
			<form action="developer/insertCeo.jsp" method="get">
				<label for="comid">회사코드</label>
				<input type="text" id="comid" name="comid" style="padding: 10px; width: 100%;">
				<label for="ename">이름</label>
				<input type="text" id="ename" name="ename" style="padding: 10px; width: 100%;">
				<label for="ecall">전화번호</label>
				<input type="text" id="ecall" name="ecall" style="padding: 10px; width: 100%;">
				<label for="epwd">비밀번호</label>
				<input type="password" id="epwd" name="epwd" style="padding: 10px; width: 100%;">
				<br />
				<button type="submit" style="padding: 10px; margin-top: 15px;">등록</button>
			</form>
		</div>
	</div>
	
	<%@ include file="/include/footer.jsp" %>
   
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
   	<script>
       function switchTab(tab) {
           const tabs = ['company', 'store', 'ceo'];
   
           tabs.forEach(t => {
               document.getElementById(t + 'Content').style.display = 'none';
               document.getElementById(t + 'Tab').classList.remove('active-tab');
           });
   
           document.getElementById(tab + 'Content').style.display = 'block';
           document.getElementById(tab + 'Tab').classList.add('active-tab');
       }
   
       switchTab('company'); 
   	</script>
</body>

</html>