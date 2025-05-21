<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/include/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
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
   <div class="container flex-fill" style="width: 600px; height:600px; margin-top: 50px;">
       <div class="d-inline-block tab-button" id="ceoTab" onclick="switchTab('ceo')">관리자 로그인</div>
       <div class="d-inline-block tab-button" id="adminTab" onclick="switchTab('admin')">점장 로그인</div>
       <div class="d-inline-block tab-button" id="staffTab" onclick="switchTab('staff')">사원 로그인</div>
   
       <div id="ceoContent" class="tab-content" style="padding: 20px; background-color: #fff; border-top: 1px solid #ddd; display: none;">
           <h1>관리자 로그인</h1>
           <form action="loginCeo.jsp" class="login-form">
               <label for="comid">회사코드</label>
               <input type="text" name="comid" style="padding: 10px; width: 100%;">
               <label for="empno">사원번호</label>
               <input type="text" name="empno" style="padding: 10px; width: 100%;">
               <label for="ename">이름</label>
               <input type="text" name="ename" style="padding: 10px; width: 100%;">
               <label for="epwd">비밀번호</label>
               <input type="password" name="epwd" style="padding: 10px; width: 100%;">
               <br />
               <input type="text" name="role" value="CEO" style="display: none;"/>
               <button type="submit" style="padding: 10px;">로그인</button>
           </form>
       </div>
   
       <div id="adminContent" class="tab-content" style="padding: 20px; background-color: #fff; border-top: 1px solid #ddd; display: none;">
           <h1>점장 로그인</h1>
           <form action="loginAdmin.jsp" class="login-form">
               <label for="comid">회사코드</label>
               <input type="text" name="comid" style="padding: 10px; width: 100%;">
               <label for="storenum">매장 번호</label>
               <input type="text" name="storenum" style="padding: 10px; width: 100%;">
               <label for="empno">사원번호</label>
               <input type="text" name="empno" style="padding: 10px; width: 100%;">
               <label for="ename">이름</label>
               <input type="text" name="ename" style="padding: 10px; width: 100%;">
               <label for="epwd">비밀번호</label>
               <input type="password" name="epwd" style="padding: 10px; width: 100%;">
               <br />
              	<input type="text" name="role" value="ADMIN" style="display: none;"/>
               <button type="submit" style="padding: 10px;">로그인</button>
           </form>
       </div>
   
       <div id="staffContent" class="tab-content" style="padding: 20px; background-color: #fff; border-top: 1px solid #ddd; display: none;">
           <h1>사원 로그인</h1>
           <form action="loginStaff.jsp" class="login-form">
               <label for="comid">회사코드</label>
               <input type="text" name="comid" style="padding: 10px; width: 100%;">
               <label for="storenum">매장 번호</label>
               <input type="text" name="storenum" style="padding: 10px; width: 100%;">
               <label for="empno">사원번호</label>
               <input type="text" name="empno" style="padding: 10px; width: 100%;">
               <label for="ename">이름</label>
               <input type="text" name="ename" style="padding: 10px; width: 100%;">
               <label for="epwd">비밀번호</label>
               <input type="password" name="epwd" style="padding: 10px; width: 100%;">
               <br />
               <input type="text" name="role" value="STAFF" style="display: none;"/>
               <button type="submit" style="padding: 10px;">로그인</button>
           </form>
       </div>
   </div>
   
   <%@ include file="/include/footer.jsp" %>
   
   <script>
       function switchTab(tab) {
           const tabs = ['ceo', 'admin', 'staff'];
   
           tabs.forEach(t => {
               document.getElementById(t + 'Content').style.display = 'none';
               document.getElementById(t + 'Tab').classList.remove('active-tab');
           });
   
           document.getElementById(tab + 'Content').style.display = 'block';
           document.getElementById(tab + 'Tab').classList.add('active-tab');
       }
   
       switchTab('ceo');
   </script>
</body>

</html>