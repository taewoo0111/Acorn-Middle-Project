<%@page import="test.dto.Com1CeoDto"%>
<%@page import="test.dao.Com1CeoDao"%>
<%@ page language="java" contentType="text/html"  pageEncoding="UTF-8"%>
<%
    int empno = (int) session.getAttribute("empno");
    Com1CeoDto dto = Com1CeoDao.getInstance().getData(empno);

    String newName = request.getParameter("ename");
    String newCall = request.getParameter("ecall");
    String newPassword = request.getParameter("newPassword");

    boolean isSuccess = false;

    // Java의 문자열에선 \ = 이스케이프 문자 
    String reg_name = "^[가-힣]{2,5}$";
    String reg_call = "^01[016789]-\\d{3,4}-\\d{4}$"; 
    String reg_pwd = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[\\W_]).{8,}$";
    
    // 이름 업데이트
    if (newName != null && !newName.isEmpty()) {
        if (newName.matches(reg_name)) {
            dto.seteName(newName);
            Com1CeoDao.getInstance().update(dto);
            isSuccess = true;
        } else {
%>
        <script>
            alert("이름 형식이 올바르지 않습니다.");
            location.href = "updateform.jsp";
        </script>
<%
            return;
        }
    }

    // 전화번호 업데이트
    if (newCall != null && !newCall.isEmpty()) {
        if (newCall.matches(reg_call)) {
            dto.seteCall(newCall);
            Com1CeoDao.getInstance().update(dto);
            isSuccess = true;
        } else {
%>
        <script>
            alert("전화번호 형식이 올바르지 않습니다.");
            location.href = "updateform.jsp";
        </script>
<%
            return;
        }
    }

    // 비밀번호 업데이트
    if (newPassword != null && !newPassword.isEmpty()) {
        if (newPassword.matches(reg_pwd)) {
            dto.setePwd(newPassword);
            Com1CeoDao.getInstance().update(dto);
            isSuccess = true;
        } else {
%>
        <script>
            alert("비밀번호 형식이 올바르지 않습니다.");
            location.href = "updateform.jsp";
        </script>
<%
            return;
        }
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정 결과</title>
</head>
<body>
<div class="container">
    <% if (isSuccess) { %>
        <script>
            alert("개인 정보를 수정했습니다.");
            location.href = "${pageContext.request.contextPath }/companyone/ceo/info/view.jsp";
        </script>
    <% 	session.setAttribute("ename", newName);
    	} else { %>
        <script>
            alert("수정 실패했습니다.");
            location.href = "updateform.jsp";
        </script>
    <% } %>
</div>
</body>
</html>
