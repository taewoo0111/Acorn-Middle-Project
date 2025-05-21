<%@page import="test.dto.Com1EmpDto"%>
<%@page import="test.dao.Com1EmpDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int empno=(int)session.getAttribute("empno");

	Com1EmpDao dao=Com1EmpDao.getInstance();
	Com1EmpDto dto=dao.getData(empno);
	session.setAttribute("current_page", "profile");
	
	String ename = (String) session.getAttribute("ename");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>근로계약서</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<style>
	html, body {
	    height: 100%;
	    margin: 0;
	    display: flex;
	    flex-direction: column;
	}
	.container2 {
	    display: flex;
    	flex-direction: column;
    	justify-content: center;
    	align-items: center;
		flex-grow: 1;
		width: 90%;  /* 부모 요소에 맞춰 자동 조정 */
		max-width: 800px;
		margin: 20px auto;
		background-color: #fff;
		padding: 20px;
		border-radius: 8px;
		border: 1px solid black;
		box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
		text-align: center;
		
	}
	.footer {
	    text-align: center;
	    width: 100%;
	    margin-top: 25px;
	}
	#contractLink {
		display: block;
		justify-content: center;
		align-items: center;
		margin: 100px auto;
		cursor: pointer;
	}
	#contractFile {
		display: none;
	}
	#uploadBtn:hover {
		background-color: grey;
	}
	#deleteBtn:hover {
		background-color: darkred;
	}

	#contractImage {
	    max-width: 100%;  /* 부모 요소 내에서 최대 너비 */
	    max-height: 80vh; /* 화면 높이의 80%까지만 */
	    width: auto;  /* 비율 유지 */
	    height: auto; /* 비율 유지 */
	    object-fit: contain; /* 이미지가 잘리거나 왜곡되지 않도록 */
	    display: block;  /* 여백 문제 방지 */
	    margin: 0 auto;  /* 가운데 정렬 */
	}
</style>
</head>
<body>
	<%@ include file="/include/header.jsp" %>
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	<div class="container2">
		<h1>근로계약서 조회</h1>
		<form action="uploadContract.jsp?empno=${empno }" method="post" id="contractForm">
			<div>
				<h5><strong>${ename }</strong> 님의 근로계약서</h5>
				<div>
					<input type="file" name="contractFile" id="contractFile" accept="image/*"/>
					<input type="hidden" name="srcurl" id="srcurl" />
					<a href="javascript:" id="contractLink">
						<%if(dto.getContract()==null){ %>
							<svg xmlns="http://www.w3.org/2000/svg" width="100" height="100" fill="currentColor" class="bi bi-file-earmark-text" viewBox="0 0 16 16">
								<path d="M5.5 7a.5.5 0 0 0 0 1h5a.5.5 0 0 0 0-1zM5 9.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5m0 2a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5"/>
								<path d="M9.5 0H4a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h8a2 2 0 0 0 2-2V4.5zm0 1v2A1.5 1.5 0 0 0 11 4.5h2V14a1 1 0 0 1-1 1H4a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1z"/>
							</svg>
							<br>
							<label>근로계약서를 업로드해 주십시오</label>	
						<%}else{ %>
							<img id="contractImage" src="<%=dto.getContract() %>" alt="계약서 이미지" />
						<%} %>
					</a>
				</div>
				<br>
				<button class="btn btn-dark" type="submit" id="uploadBtn">업로드</button>
				<% if(dto.getContract() != null) { %>
					<button class="btn btn-danger" id="deleteBtn">삭제</button>
				<% } %>
			</div>
		</form>	
			
	</div>

    <footer class="footer">
        <jsp:include page="/include/footer.jsp" />
    </footer>

	<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>  
	<script>
		// 버튼의 초기 설정
		document.querySelector("#uploadBtn").disabled = true;
		// 파일 선택 버튼 클릭
		document.querySelector("#contractLink").addEventListener("click", () => {
			document.querySelector("#contractFile").click();
		});

		// 새 이미지 선택 시 미리보기
		document.querySelector("#contractFile").addEventListener("change", (e) => {
			const files = e.target.files;
			if(files.length > 0) {
				
				const reader = new FileReader();
				reader.onload = (event) => {
					const data = event.target.result;
					document.querySelector("#srcurl").value = data;
					const img=`<img src="\${data}" id="contractImage" alt="계약서 이미지">`;
					document.querySelector("#contractLink").innerHTML=img;
				};
				reader.readAsDataURL(files[0]);
				
		        // 파일이 선택되면 버튼 활성화
		        document.querySelector("#uploadBtn").disabled = false;
		    } else {
		        // 파일이 없으면 버튼 비활성화
		        document.querySelector("#uploadBtn").disabled = true;
		    }
			
			
		});

		// 삭제 버튼 클릭 시 confirm 창 띄우고 삭제 요청
		document.querySelector("#deleteBtn")?.addEventListener("click", (event) => {
			event.preventDefault();
			if (confirm("정말 삭제하시겠습니까?")) {
				fetch("deleteContract.jsp?empno=${empno}", { method: "POST" })
				.then(response => response.text())
				.then(data => {
					alert("근로 계약서가 삭제되었습니다.");
					location.reload();
				})
				.catch(error => alert("삭제 중 오류가 발생하였습니다."));
			}
		});
	</script>

</body>
</html>
