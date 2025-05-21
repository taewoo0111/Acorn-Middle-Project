<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int empno = Integer.parseInt(request.getParameter("empno"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계약서 업로드 폼</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" />
<style>
    /* 이미지 미리보기 스타일 */
    #preview {
        max-width: 100%;
        height: auto;
        display: none;
        margin-top: 15px;
        border-radius: 10px;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
    }
</style>
</head>
<body class="d-flex flex-column min-vh-100 bg-light">
<%@ include file="/include/header.jsp" %>
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	
	<%--main컨텐츠감싸기 --%>
	<div class="main flex-grow-1">  
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-6">
                    <div class="card shadow-sm p-4">
						<h1 class="text-center mb-4">근로계약서 업로드</h1>
						<form action="conUpload.jsp?empno=<%=empno%>" method="post"  id="ConForm">
                            <div class="mb-3">
                                <label for="imgcon" class="form-label">근로계약서 업로드</label>
                                <input type="file" class="form-control" id="imgcon" accept="image/*" required onchange="previewImage(event)">
                                <input type="hidden" name="srcurl" id="srcurl" />
                            </div>							
                            
                            <%-- 이미지 미리보기 --%>
                            <img id="preview" alt="미리보기 이미지">		
                            
                            <%-- 업로드버튼_자식요소 --%>				
							<div class="d-grid mt-3">
							<button type="submit" class="btn btn-dark mt-3">업로드</button>
							</div>	
						</form>
                  </div>
              </div>
          </div>			
			
			
			
			
			
		</div>    	
    </div> <%--main --%>
	<%--푸터 --%>
    <jsp:include page="/include/footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <%-- 이미지 미리보기 기능 추가 --%>
    <script>
        function previewImage(event) {
            const reader = new FileReader();
            reader.onload = function () {
                const preview = document.getElementById('preview');
                preview.src = reader.result;
                preview.style.display = 'block';
            }
            reader.readAsDataURL(event.target.files[0]);
        }
        
		document.querySelector("#imgcon").addEventListener("change", (event)=>{
			const files = event.target.files;
			if(files.length > 0){
				//파일로 부터 데이터를 읽어들일 객체 생성
				const reader=new FileReader();
				//로딩이 완료(파일데이터를 모두 읽었을때) 되었을때 실행할 함수 등록
				//onload에 함수를 넣어두면, 이 함수는 다 읽으면 자동으로 호출
				reader.onload=(event)=>{ 
					//읽은 파일 데이터 얻어내기 
					const data=event.target.result; //읽은파일데이터가 들어있음. data가 이미지 데이터임
					document.querySelector("#srcurl").value=data;
				};
				//파일을 DataURL 형식의 문자열로 읽어들이기 //파일배열에 0번방에 선택한 이미지가 존재하는것.(그걸 읽음!)
				reader.readAsDataURL(files[0]); //읽는작업은 여기서!
			}	
		});        


    </script>
    
</body>
</html>