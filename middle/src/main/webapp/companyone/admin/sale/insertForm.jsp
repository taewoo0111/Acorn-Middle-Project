<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%
	session.setAttribute("current_page", "saleview");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매출추가 페이지</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
<%@ include file="/include/header.jsp" %>	
  <!-- 네비게이션 바 -->
  <jsp:include page="/include/navbar.jsp"></jsp:include>

  <!-- 메인 컨텐츠 -->
  <div class="container flex-grow-1 my-4">
  <form action="${pageContext.request.contextPath}/companyone/admin/sale/insert.jsp" method="get">
  	<!-- 버튼 -->
    <div class="d-flex align-items-center gap-2 mb-3">
	    <button type="submit" class="btn btn-success" id="addBtn">매출추가</button>
	    <button type="button" class="btn btn-primary" id="viewBtn"
		    onclick="location.href='<%= request.getContextPath() %>/companyone/admin/sale/saleManage2.jsp'">
		    매출조회
		</button>
	</div>


    <!-- 테이블 -->
    <table class="table table-bordered table-hover text-center">
      <thead class="table-success">
        <tr>
          <th>날짜</th>
          <th>매출</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><input type="date" id="salesdate" name="salesdate" required/></td>
          <td><input type="number" id="dailySales" name="dailysales" min="0" required/></td>
        </tr>
      </tbody>
    </table>
  </form>
  <%--YYYYMMDD 형식으로 전환  이거 없어도 돼요!--%>
		<script>
		document.querySelector("#addBtn").addEventListener("click",()=>{
			console.log("aaa")
			const dateInput = document.querySelector("#salesdate").value;
			if (dateInput) {
				//dateInput = dateInput.replace(/-/g, ""); // YYYY-MM-DD → YYYYMMDD 변환
				document.querySelector("#salesdate").value = dateInput;
			}
		});
		
		</script>
	</div>
  <!-- 푸터 -->
  <jsp:include page="/include/footer.jsp" />
</body>
</html>