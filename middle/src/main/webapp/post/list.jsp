<%@page import="java.util.List"%>
<%@page import="test.post.dto.PostDto"%>
<%@page import="test.post.dao.PostDao"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	//검색조건이 있는지 읽어와 본다.
	String condition=request.getParameter("condition");
	String keyword=request.getParameter("keyword");
	String findQuery=null;
	//있다면 dto 에 해당 정보를 담는다.
	PostDto dto=new PostDto();
	if(condition != null){
		dto.setCondition(condition);
		dto.setKeyword(keyword);
		findQuery="&condition="+condition+"&keyword="+keyword;
	}
	
	//한 페이지에 몇개씩 표시할 것인지
	final int PAGE_ROW_COUNT=10;
	//하단 페이지를 몇개씩 표시할 것인지
	final int PAGE_DISPLAY_COUNT=10;
	
	//보여줄 페이지의 번호를 일단 1이라고 초기값 지정
	int pageNum=1;
	
	//페이지 번호가 파라미터로 전달되는지 읽어와 본다.
	String strPageNum=request.getParameter("pageNum");
	//만일 페이지 번호가 파라미터로 넘어 온다면
	if(strPageNum != null){
		//숫자로 바꿔서 보여줄 페이지 번호로 지정한다.
		pageNum=Integer.parseInt(strPageNum);
	}	
	
	//보여줄 페이지의 시작 ROWNUM
	int startRowNum=1+(pageNum-1)*PAGE_ROW_COUNT;
	//보여줄 페이지의 끝 ROWNUM
	int endRowNum=pageNum*PAGE_ROW_COUNT;
	
	//하단 시작 페이지 번호 
	int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT;
	//하단 끝 페이지 번호
	int endPageNum=startPageNum+PAGE_DISPLAY_COUNT-1;
	//전체 글의 갯수
	int totalRow=PostDao.getInstance().getCount(dto);
	//전체 페이지의 갯수 구하기
	int totalPageCount=(int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);
	//끝 페이지 번호가 이미 전체 페이지 갯수보다 크게 계산되었다면 잘못된 값이다.
	if(endPageNum > totalPageCount){
		endPageNum=totalPageCount; //보정해 준다. 
	}	
	
	// startRowNum 과 endRowNum 을 PostDto 객체에 담아서
	dto.setStartRowNum(startRowNum);
	dto.setEndRowNum(endRowNum);
	
	
	//보여줄 페이지에 해당하는 글 목록을 얻어온다.
	List<PostDto> list=PostDao.getInstance().getList(dto);
	
	/*
		jsp 페이지에서 응답에 필요한 데이터를 el 에서 활용할수 있도록
		request 객체에 특정 키값으로 담는다.
	*/
	request.setAttribute("list", list);
	request.setAttribute("startPageNum", startPageNum);
	request.setAttribute("endPageNum", endPageNum);
	request.setAttribute("totalPageCount", totalPageCount);
	request.setAttribute("pageNum", pageNum);
	request.setAttribute("totalRow", totalRow);
	request.setAttribute("dto", dto);
	request.setAttribute("findQuery", findQuery);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/post/list.jsp</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
</head>

<body>
<%@ include file="/include/header.jsp" %>
	<div class="container main flex-grow-1">
		<div class="title-container d-flex justify-content-between mt-4 ms-2 me-2">
			<h1>공지사항</h1>
			<!-- CEO와 ADMIN만 새글 작성 보이게 코딩 -->
			<c:if test="${not empty sessionScope.role and (sessionScope.role eq 'CEO' or sessionScope.role eq 'ADMIN')}">
	    		<a href="${pageContext.request.contextPath }/post/protected/new.jsp" class="mt-3">
	    			<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
					  	<path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
					    <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z"/>
					</svg>
				</a>
			</c:if>
		</div>
		<div class="table-responsive rounded-3 overflow-hidden  border border-secondary">
			<table class="table table-striped text-center mb-0">
				<thead class="table-Secondary">
					<tr>
						<th>번호</th>
						<th>작성자</th>
						<th>제목</th>
						<th>조회수</th>
						<th>등록일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="post" items="${list}">
						<tr>
							<td>${post.num}</td>
							<td>${post.writer}</td>
							<td>
								<a href="view.jsp?num=${post.num}${findQuery}">${post.title}</a>
							</td>
							<td>${post.viewCount}</td>
							<td>${post.createdAt}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<c:if test="${not empty dto.keyword }">
        	<p class="d-flex justify-content-end">
        		<strong>${totalRow }</strong> 개의 자료가 검색 되었습니다.
        	</p>
        </c:if>	
		<nav class="d-flex justify-content-center mt-2">
			<ul class="pagination">
				<!-- Prev 버튼 -->
				<c:if test="${startPageNum ne 1}">
					<li class="page-item">
						<a class="page-link" href="list.jsp?pageNum=${startPageNum - 1}${findQuery}">Prev</a>
					</li>
				</c:if>
				<!-- 페이지 번호 -->
				<c:forEach begin="${startPageNum}" end="${endPageNum}" var="i">
					<li class="page-item ${i == pageNum ? 'active' : ''}">
						<a class="page-link" href="list.jsp?pageNum=${i}${findQuery}">${i}</a>
					</li>
				</c:forEach>
				<!-- Next 버튼 -->
				<c:if test="${endPageNum < totalPageCount}">
					<li class="page-item">
						<a class="page-link" href="list.jsp?pageNum=${endPageNum + 1}${findQuery}">Next</a>
					</li>
				</c:if>
			</ul>		
		</nav>
        <form action="${pageContext.request.contextPath }/post/list.jsp" method="get" class="d-flex justify-content-end">
        	<select class="me-1" name="condition" id="condition">
        		<option value="title_content" ${dto.condition eq 'title_content' ? 'selected' : ''}>제목 + 내용</option>
        		<option value="title" ${dto.condition eq 'title' ? 'selected' : ''}>제목</option>
        		<option value="writer" ${dto.condition eq 'writer' ? 'selected' : ''}>작성자</option>
        	</select>
        	<input type="text" name="keyword" placeholder="검색어..." value="${dto.keyword }"/>
        	<button class="btn btn-primary btn-sm ms-1" type="submit">검색</button>
        	<a class="btn btn-success btn-sm ms-1" href="${pageContext.request.contextPath }/post/list.jsp">새로고침</a>
        </form>
	</div>
	<div class="position-fixed bottom-0 w-100">
  		<jsp:include page="/include/footer.jsp" />
  	</div>
</body>
</html>