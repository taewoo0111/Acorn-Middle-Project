<%@page import="test.post.dao.PostDao"%>
<%@page import="test.post.dto.PostDto"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	//폼전송되는 title, content 읽어내기
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	//글 작성자 정보 얻어내기
	String ename = (String)session.getAttribute("ename");
	//글정보를 DB 에 저장하고
	PostDto dto = new PostDto();
	dto.setTitle(title);
	dto.setContent(content);
	dto.setWriter(ename);
	
	boolean isSuccess = PostDao.getInstance().insert(dto);
	request.setAttribute("isSuccess", isSuccess);
%>

<script>
	if ('<%=isSuccess %>' == 'true') {		
		alert("글이 성공적으로 작성되었습니다.");
		location.href = "../list.jsp";
    } else {
		alert("글 작성에 실패했습니다. 다시 시도해 주세요.");
		location.href = "new.jsp";
    }
</script>