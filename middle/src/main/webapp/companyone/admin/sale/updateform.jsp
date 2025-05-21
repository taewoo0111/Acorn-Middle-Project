<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>매출추가</title>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
  <!-- 메인 컨텐츠 -->
  <div class="container flex-grow-1 my-4">
  <form action="${pageContext.request.contextPath}/admin_rae/sale.jsp" method="get">
  	<!-- 버튼 -->
    <div class="d-flex justify-content-between mb-3">
      <button type="submit" class="btn btn-success">매출추가</button>
    </div>

    <!-- 테이블 -->
    <table class="table table-bordered table-hover text-center">
      <thead class="table-success">
        <tr>
          <th>월</th>
          <th>매출</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td><input type="month" id="salemonth" name="salemonth"/></td>
          <td><input type="number" id="monthlysal" name="monthlysal"/></td>
        </tr>
      </tbody>
    </table>
  </form>
  </div>
  <!-- 푸터 -->
  <jsp:include page="/include/footer.jsp" />
</body>

</html>