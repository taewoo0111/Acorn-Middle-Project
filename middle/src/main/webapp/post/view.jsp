<%@page import="test.post.dao.PostDao"%>
<%@page import="test.post.dto.PostDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
<%
	//검색조건이 있는지 읽어와 본다.
	String condition=request.getParameter("condition");
	String keyword=request.getParameter("keyword");
	String findQuery=null;
	//있다면 dto 에 해당 정보를 담는다.
	PostDto findDto=new PostDto();
	if(condition != null){
		//findDto=new PostDto();
		findDto.setCondition(condition);
		findDto.setKeyword(keyword);
		findQuery="&condition="+condition+"&keyword="+keyword;
	}
	//자세히 보여줄 글의 번호를 읽어온다. 
	int num=Integer.parseInt(request.getParameter("num"));
	findDto.setNum(num);
	
	//DB 에서 해당 글의 정보를 얻어와서 
	PostDto dto=PostDao.getInstance().getData(findDto);
	
	//세션 아이디를 읽어와서 
	String sessionId=session.getId();
	//이미 읽었는지 여부를 얻어낸다 
	boolean isReaded=PostDao.getInstance().isReaded(num, sessionId);
	if(!isReaded){
		//글 조회수도 1 증가 시킨다
		PostDao.getInstance().addViewCount(num);
		//이미 읽었다고 표시한다. 
		PostDao.getInstance().insertReaded(num, sessionId);
	}
	
	request.setAttribute("dto", dto);
	request.setAttribute("findDto", findDto);
	request.setAttribute("findQuery", findQuery);
	//응답한다 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/post/view.jsp</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
<style>
    #contents {
        margin-top: 20px;
        padding: 20px;
        background-color: #fefefe;
        border-radius: 10px;
        box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        border: 1px solid #ddd;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        height:300px;
    }
    #contents:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
    }
    
    #content{
    	width: 100%;
    	height: 300px;
    }
	/* 댓글 프로필 이미지를 작은 원형으로 만든다. */
	.profile-image{
		width: 50px;
		height: 50px;
		border: 1px solid #cecece;
		border-radius: 50%;
	}
	/* ul 요소의 기본 스타일 제거 */
	.comments ul{
		padding: 0;
		margin: 0;
		list-style-type: none;
	}
	
	/* .reply_icon 을 li 요소를 기준으로 배치 하기 */
	.comments li{
		position: relative;
	}
	.comments .reply-icon{
		position: absolute;
		top: 1rem;
		left: 1rem;
		color: red;
	}
	
	/* 대댓글을 들여 쓰기 위한 클래스 */
	.indent{
		padding-left: 50px;
	}
	
	/* 답글 아이콘은 일단 보이지 않게  */
	.reply-icon{
		display: none;
	}
	
	.comment-form, .re-insert-form, .update-form{
		display: flex;
	}
	
	.comment-form textarea, .re-insert-form textarea, .update-form textarea{
		height: 100px;
		flex-grow: 1;
	}
	
	.comment-form button, .re-insert-form button, .update-form button{
		flex-basis: 100px;
	}
	/* 대댓글폼은 일단 숨겨 놓는다 */
	.re-insert-form, .update-form{
		display: none;
	}
	
	/* 댓글 출력 디자인 */
	.comments pre {
	  display: block;
	  padding: 9.5px;
	  margin: 5px 0;
	  font-size: 13px;
	  line-height: 1.42857143;
	  color: #333333;
	  word-break: break-all;
	  word-wrap: break-word;
	  background-color: #f5f5f5;
	  border: 1px solid #ccc;
	  border-radius: 4px;
	}
	.loader{
		/* 로딩 이미지를 가운데 정렬하기 위해 */
		text-align: center;
		/* 일단 숨겨 놓기 */
		display: none;
	}
	/* 회전하는 키프레임 정의 */
	@keyframes rotateAni{
		from{
			transform: rotate(0deg);
		}
		to{
			transform: rotate(360deg);
		}
	}
	/* 회전하는 키프레임을 로더 이미지에 무한 반복 시키기 */
	.loader svg{
		animation: rotateAni 1s ease-out infinite;
	}
	
	body{
		padding-bottom: 200px;
	}
</style>
</head>

<body>
<%@ include file="/include/header.jsp" %>
	<div class="container main flex-grow-1">
		<div class="title-container d-flex justify-content-between mt-4 ms-2 me-2">
			<h1>글 상세 보기</h1>
		</div>
		<div class="container rounded-3  border border-secondary p-3">
			<table class="table  table-striped-columns rounded-3 overflow-hidden text-center  mb-0">
				<tr>
					<th class="table-Secondary">글번호</th>
					<td class="table-light">${dto.num }</td>
				</tr>
				<tr>
					<th class="table-Secondary">작성자</th>
					<td class="table-light">${dto.writer }</td>
				</tr>
				<tr>
					<th class="table-Secondary">제목</th>
					<td class="table-light">${dto.title }</td>
				</tr>
				<tr>
					<th class="table-Secondary">조회수</th>
					<td class="table-light">${dto.viewCount }</td>
				</tr>
				<tr>
					<th class="table-Secondary">작성일</th>
					<td class="table-light">${dto.createdAt }</td>
				</tr>
				<tr>
					<th class="table-Secondary">수정일</th>
					<td class="table-light">${dto.updatedAt }</td>
				</tr>
				<tr >
					<td colspan="2">
						<div class="text-start" id="contents">${dto.content }</div>
					</td>
				</tr>
			</table>
		</div>
		<div class="d-flex justify-content-center mt-2">
			<c:if test="${dto.prevNum ne 0}">
				<a class="mx-2" href="view.jsp?num=${dto.prevNum}${findQuery}">이전글</a>
			</c:if>
			<c:if test="${dto.nextNum ne 0}">
				<a class="mx-2" href="view.jsp?num=${dto.nextNum}${findQuery}">다음글</a>
			</c:if>
			<c:if test="${not empty findDto.condition}">
				<p>
					<strong>${findDto.condition }</strong> 조건
					<strong>${findDto.keyword }</strong>검색어로 검색된 내용 자세히보기
				</p>
			</c:if>
		</div>
		<div class="btn-container d-flex justify-content-end">
			<%-- 만일 글 작성자가 로그인된 아이디와 같다면 수정, 삭제 링크를 제공한다. --%>
			<c:if test="${dto.writer eq ename }">
				<a class="btn btn-outline-success btn-sm me-3" href="${pageContext.request.contextPath }/post/protected/edit.jsp?num=${dto.num }">수정</a>
				<a class="btn btn-outline-danger btn-sm" href="javascript:" onclick="deleteConfirm()">삭제</a>
				<script>
					function deleteConfirm(){
						const isDelete=confirm("이 글을 삭제 하겠습니까?");
						if(isDelete){
							//javascript 를 이용해서 페이지 이동 시키기
							location.href="${pageContext.request.contextPath }/post/protected/delete.jsp?num=${dto.num}";
						}
					}
				</script>
			</c:if>
		</div>
	</div>
	<div class="position-fixed bottom-0 w-100">
  		<jsp:include page="/include/footer.jsp" />
  	</div>
</body>
</html>