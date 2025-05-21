<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.List"%>
<%@page import="test.dao.Com1QuitDao"%>
<%@page import="test.dto.Com1QuitDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	session.setAttribute("current_page", "quitForm");

	// 선언 초기화
	String findQuery="";					// 페이지 로딩 uri
	final int PAGE_ROW_COUNT = 6;			// 한 페이지에 표시할 개수
	final int PAGE_DISPLAY_COUNT = 3;		// 하단 페이지에 표시할 개수
	Com1QuitDto dto = new Com1QuitDto();	// 로딩 데이터			
	
	// 검색 조건이 있는지 확인 
	String condition = request.getParameter("condition");
	String keyword = request.getParameter("keyword");
	// 검색 조건이 있는 경우
	if(condition != null && keyword != null){
		// 만약 직책명으로 키워드 검색 시 소문자가 섞여 있다면 대문자로 바꿔주기
		Pattern pattern = Pattern.compile("[a-z]");		
		Matcher matcher = pattern.matcher(keyword);
		boolean result_reg = matcher.find();
		if(condition.equals("role") && result_reg) keyword = keyword.toUpperCase();
		// DB 조회시 넘어갈 DTO 에 검색 조건 정보 담기
		dto.setCondition(condition);					
		dto.setKeyword(keyword);
	} else {
		condition = "ename";
		keyword = "";
	}
	
	// 정렬 조건이 있는지 확인
	String lineup = request.getParameter("lineup");
	String picked = request.getParameter("picked");
	if(lineup == null && picked == null){		
		// 정렬 조건이 없는 경우 디폴트 값 설정
		lineup = "QUITDATE";
		picked = "DESC";
	}
	// DB 조회시 넘어갈 DTO 에 정렬 조건 정보 담기
	dto.setLineup(lineup);	
	dto.setPicked(picked);
	
	// 페이지 번호가 있는지 확인
	int pageNum = 1;
	String strPageNum = request.getParameter("pageNum");
	if(strPageNum != null){
		pageNum = Integer.parseInt(strPageNum);
	}
	
	// 페이징 처리 계산
	int startRowNum = (pageNum-1)*PAGE_ROW_COUNT + 1;							// 시작 row 번호 
	int endRowNum = PAGE_ROW_COUNT*pageNum;										// 마지막 row 번호
	int startPageNum = ((pageNum-1)/PAGE_DISPLAY_COUNT)*PAGE_DISPLAY_COUNT + 1; // 하단 페이지 시작 번호
	int endPageNum = startPageNum+PAGE_DISPLAY_COUNT - 1;						// 하단 페이지 끝 번호
	int totalRow = Com1QuitDao.getInstance().getCount(dto);						// 전체 row 개수
	int totalPageCount = (int)Math.ceil(totalRow/(double)PAGE_ROW_COUNT);		// 생성될 페이지 개수
	if(endRowNum > totalPageCount) endPageNum = totalPageCount;
	dto.setStartRowNum(startRowNum);									// DB 조회시 넘어갈 DTO 에 페이지 정보 담기
	dto.setEndRowNum(endRowNum);
	
	// DB에서 데이터 가져오기
	List<Com1QuitDto> list =  Com1QuitDao.getInstance().getList(dto);
	
	// request 영역에 필요한 정보 저장
	request.setAttribute("list", list);
	request.setAttribute("startPageNum", startPageNum);
	request.setAttribute("endPageNum", endPageNum);
	request.setAttribute("totalPageCount", totalPageCount);
	request.setAttribute("condition", condition);
	request.setAttribute("keyword", keyword);
	request.setAttribute("lineup", lineup);
	request.setAttribute("picked", picked);
	request.setAttribute("pageNum", pageNum);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>퇴사자 관리 페이지</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
<style>
	/* div{ border:1px solid red; } */
</style>
</head>
<body class="d-flex flex-column min-vh-100 bg-light"  >
	<jsp:include page="/include/header.jsp"></jsp:include>
	<jsp:include page="/include/navbar.jsp"></jsp:include>
	
	<!-- 본문 -->
	<div class="main flex-grow-1"  id="app">  
		<div ref="loadView" id="loadViewId"></div>
		<div class="container contents text-center mt-3 mx-auto" style="width:900px;">
			<h4>퇴사자 명단</h4>
			
			<!--상단 컨트롤 바-->
			<div class="controlbar d-flex mt-2">
				
				<!-- 조회 버튼-->
				<div class="p-2">
					<div class="input-group">
						<select v-model="condition" name="condition" class="btn btn-outline-dark dropdown-toggle">
								<option value="ename">이름</option>
								<option value="storenum">지점</option>
								<option value="role">직책</option>
								<option value="empno">사원번호</option>
						</select>
						<input v-model="keyword" type="text" name="keyword" placeholder=" 입력하세요.." />
						<button @click="onSearch" class="btn btn-outline-dark">검색</button>
					</div>
				</div>
				
				
				<!-- 정렬 버튼 -->
				<div class="p-2">
					<div class="input-group">
						<button type="button" class="btn btn-outline-dark" disabled>정렬 조건</button>
						<!-- 정렬 기준 선택 -->
						<select v-model="lineup" name="lineup" @change="onLineUp" class="btn btn-outline-dark dropdown-toggle">
								<!-- <option value="">선택</option> -->
								<option value="QUITDATE">퇴사일</option>
								<option value="HIREDATE">입사일</option>
								<option value="EMPNO">사원번호</option>
								<option value="ENAME">이름</option>
								<option value="STORENUM">지점</option>
						</select>
						<!-- 차순 정렬 기준 선택 -->
						<input type="radio" class="btn-check" name="options-outlined" id="ASC" v-model="picked" value="ASC" @change="onlineup" autocomplete="off">
						<label class="btn btn-outline-dark" for="ASC">오름</label>
						<input type="radio" class="btn-check" name="options-outlined" id="DESC" v-model="picked" value="DESC" @change="onlineup" autocomplete="off">
						<label class="btn btn-outline-dark" for="DESC">내림</label>
					</div>
				</div>
				
				
				<!-- 퇴사자 추가 버튼 -->
				<div class="ms-auto p-2">
					<button class="btn btn-primary" id="add_quit" data-bs-toggle="modal" data-bs-target="#showModal">퇴사자 추가</button>
				</div>
				
				<!-- 퇴사자 추가 버튼을 누르면 나오는 모달 창 -->
				<div class="modal fade" id="showModal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="showModalLabel" aria-hidden="true">
					<div class="modal-dialog">
					  <div class="modal-content">
					  
					  	<!-- 모달창 헤더 -->
					    <div class="modal-header">
					      <h1 class="modal-title fs-5" id="showModalLabel">퇴사자 추가</h1>
					      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					    </div>
					    
					    <!-- 모달창 바디 -->
					    <div class="modal-body ">
					    	
					    	<!-- 데이터 조회 -->
						    <div class="mb-3 row" >
						    	<div class="col-3"><label for="searchEmpno" class="form-label">사원번호*</label></div>
						    	<div class="col-6"><input v-model="searchEmpno" type="text" class="form-control" id="searchEmpno" placeholder="사원번호를 입력하세요..."></div>
						    	<div class="col-3"><button @click="clickSearchBtn" class="btn btn-primary">조회</button></div>
							</div>
							
							<!-- 조회된 데이터 보여줌 -->
						    <form action="addQuit.jsp" @submit.prevent="onSubmit">
						    	<div class="mb-3 row" style="display:none">
						    		<div class="col-3"><label for="empno" class="form-label">사원번호 </label></div>
						    		<div class="col-9"><input v-model="searchEmpno" type="text" class="form-control" id="empno" name="empno"  readonly></div>
								</div>
								
								<div class="mb-3 row" style="display:flex">
									<div class="col-3"><label for="ename" class="form-label">이름 </label></div>
						    		<div class="col-9"><input v-model="dto.ename" type="text" class="form-control" id="ename" name="ename" readonly ></div>
								</div>
								
								<div class="mb-3 row">
									<div class="col-3"><label for="store" class="form-label">영업점 </label></div>
						    		<div class="col-9"><input v-model="dto.store" type="text" class="form-control" id="store" name="store" readonly></div>
								</div>
								
								<div class="mb-3 row">
									<div class="col-3"><label for="role" class="form-label">역할 </label></div>
						    		<div class="col-9"><input v-model="dto.role" type="text" class="form-control" id="role" name="role" readonly></div>
								</div>
								
								<div class="mb-3 row">
									<div class="col-3"><label for="email" class="form-label">이메일 </label></div>
						    		<div class="col-9"><input v-model="dto.email" type="text" class="form-control" id="email" name="email" readonly></div>
								</div>
								
								<div class="mb-3 row">
									<div class="col-3"><label for="call" class="form-label">전화번호 </label></div>
						    		<div class="col-9"><input v-model="dto.call" type="text" class="form-control" id="call" name="call" readonly></div>
								</div>
						    	
						    	<div class="mb-3 row">
						    		<div class="col-3"><label for="hiredate" class="form-label">입사일 </label></div>
						    		<div class="col-9"><input v-model="dto.hiredate" type="text" class="form-control" id="hiredate" name="hiredate" readonly></div>
								</div>
								
								<div class="mb-3 row">
									<div class="col-3"><label for="quitdate" class="form-label">퇴사일 </label></div>
						    		<div class="col-9"><input type="date" class="form-control" id="quitdate" name="quitdate"></div>
								</div>
						      
						      	<!-- 이 데이터로 퇴사자 처리 -->
					      		<button class="btn btn-primary" id="addQuitBtn">퇴사 처리</button>
						    </form>
					    </div>
					  </div>
					</div>
				</div>
			</div>
			
			
			
			<!-- 퇴사자 리스트 -->	
			<div style="margin:10px; width:900px;">
				<div class="table-responsive">
					<table class="table table-striped" id="quitListTable">
						<thead class="table-dark">
							<tr>
								<th>사원번호</th>
								<th>이름</th>
								<th>지점</th>
								<th>직책</th>
								<th>입사일</th>
								<th>퇴사일</th>
								<th>전화번호</th>
								<th>복귀</th>
							</tr>
						</thead>
						<tbody>
							<!-- 데이터가 없는 경우 -->
							<c:choose>
								<c:when test="${totalRow eq 0}">
									</tbody>
									</table>
									<div class=" justify-content-center align-items-center vh-100">
									  <div class="p-3 bg-light">퇴사자 정보가 없습니다!</div>
									</div>
								</c:when>
								<c:otherwise>
									<c:forEach var="qmember" items="${list}">
										<tr>
											<td>${qmember.empNo }</td>
											<td>${qmember.eName }</td>
											<td>${qmember.storeNum }</td>
											<td>${qmember.role }</td>
											<td>${qmember.hiredate }</td>
											<td>${qmember.quitdate }</td>
											<td>${qmember.eCall }</td>
											<td><a href="cancleQuit.jsp" class="btn btn-secondary btn-sm" @click.prevent="onCancle">복귀</a></td>
										</tr>
									</c:forEach>
										</tbody>
										</table>
								</c:otherwise>
							</c:choose>
				</div>
			</div>
			
			
			<!-- 하단 페이징 버튼 -->
			<div class="mt-3 d-flex justify-content-center">
				<nav>
					<ul class="pagination mx-auto">
						<!-- Prev 버튼 -->
						<c:if test="${startPageNum ne 1}">
							<li class="page-item">
								<button type="button" class="page-link" @click="onPage">Prev</button>
							</li>
						</c:if>
						<!-- 페이지 번호 -->
						<c:forEach begin="${startPageNum}" end="${endPageNum}" var="i">
							<li class="page-item ${i == pageNum ? 'active' : ''}">
								<button type="button" class="page-link" @click="onPage">${i}</button>
							</li>
						</c:forEach>
						<!-- Next 버튼 -->
						<c:if test="${endPageNum < totalPageCount}">
							<li class="page-item">
								<button type="button" class="page-link" @click="onPage">Next</button>
							</li>
						</c:if>
					</ul>		
				</nav>
			</div>
			
			<!-- 나중에 추가 가능 -->
			<div class="mt-3 d-flex justify-content-end">
				<button class="btn btn-primary btn m-3" @click="printBtn">경력증명서 출력</button>
			</div>
		
		</div>
	</div>
	
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
	
	<!-- 푸터 -->
	<jsp:include page="/include/footer.jsp" />
	
	<script>
		new Vue({
			el:"#app",
			data:{
				condition:"${empty condition ? 'ename' : condition}",
				keyword:"${keyword}",
				lineup:"${empty lineup ? 'QUITDATE' : lineup}",
				picked: "${empty picked ? 'DESC' : picked}",
				searchEmpno:"",
				dto:"",
				startPageNum:"${startPageNum}",
				endPageNum:"${endPageNum}",
			},
			computed: {
				url:function(){
					return "quitForm.jsp?condition="+ this.condition + "&keyword=" + this.keyword + "&lineup=" + this.lineup + "&picked=" + this.picked;
				}
			},
			methods:{
				// 경력 증명서 출력 버튼 눌렀을 때
				printBtn(){
					// 출력 받을 퇴사자 사원 번호 입력 받기
					const empno = prompt("출력할 퇴사자 번호를 입력하세요");
					
					// 뜨는 알림창에 확인 버튼을 눌렀을 때
					if(empno){
						// 유효한 번호를 입력했는지 확인
						fetch("searchInfoQuit.jsp?empno="+empno)
						.then(res => res.json())
						.then(result=>{
							// 만약 없는 사원번호를 입력했을 경우
							if(!result.isExist){
								alert("없는 사원번호 입니다.");
							} else {
								// 퇴사자 번호 달고 출력 기능을 가진 jsp 로 이동
								location.href= "printQuit.jsp?condition="+ this.condition + "&keyword=" + this.keyword + "&lineup=" + this.lineup + "&picked=" + this.picked + "&empno=" + empno;
							}
						})
						.catch((err)=>{
							console.log(err);
						});
					}
					
					
				},
				// 페이징 버튼 눌었을 때
				onPage(e){
					const pageNum = e.target.innerText;
					
					switch (pageNum) {
						case "Prev":
					  		location.href= this.url + "&pageNum=" + (this.startPageNum - 1);
						case "Next":
					  		location.href= this.url + "&pageNum=" + (this.endPageNum + 1);
					  default:
						  location.href= this.url + "&pageNum=" + pageNum;
					}
				},
				// 검색 버튼을 눌렀을 때
				onSearch(){
					if(this.keyword == ""){
						alert("검색 키워드를 입력하세요")
					} else {
						location.href= this.url;
					}
				},
				// 정렬 조건을 변경했을 때
				onLineUp(){
					location.href= this.url;
				},
				onlineup(){
					location.href= this.url;
				},
				// 모달창에서 사원 조회 버튼을 눌렀을 때
				clickSearchBtn(){
					
					// 사원번호를 입력했을 경우
					if(this.searchEmpno){
						
						fetch("searchInfo.jsp?empno="+this.searchEmpno)
						.then(res => res.json())
						.then(data=>{
							// 만약 없는 사원번호를 입력했을 경우
							if(!data.isExist){
								alert("없는 사원번호 입니다.");
							} else {
								this.dto = data.dto;
							}
						})
						.catch((err)=>{
							console.log(err);
						});
					}else{
						alert("사원 번호를 입력하세요");
					}
					
				}, 
				// 퇴사자 복귀
				onCancle(e){
					// 복귀 처리 할 사람의 정보 추출
					const empno = e.target.parentElement.parentElement.childNodes[0].innerText;
					const ename = e.target.parentElement.parentElement.childNodes[2].innerText;
					
					// 복귀 처리 한 번 더 물어보기
					const answer = confirm(ename+"("+empno+")" +" 을(를) 복귀 처리 하시겠습니까?");
					
					// 대답이 긍정이라면 복귀 처리 하기
					if(answer){
						fetch("cancleQuit.jsp",{
							method:"POST",
							headers:{"Content-Type":"application/x-www-form-urlencoded; charset=utf-8"},
							body: "empno="+empno
						})
						.then(res => res.json())
						.then(data=>{
							console.log(data);
							if(data.isAddSuccess && data.isDeleteSuccess){
								alert(ename+"("+empno+") 을(를) 복귀 처리 하였습니다.");
							} else if(data.isAddSuccess){
								alert("QUIT 테이블에서 삭제 실패. 개발자 확인 요망!");
							} else {
								alert("EMP 테이블에 추가 실패. 개발자 확인 요망!");
							}
							location.href = "quitForm.jsp";
						})
						.catch((err)=>{
							console.log(err);
						});
					}
				},
				// 퇴사자 추가 
				onSubmit(e){
					// 폼 입력이 제대로 이루어 졌는지 확인
					const data = new FormData(e.target);
					const empno = e.target.empno.value;
					const ename = e.target.ename.value
					const quitdate = e.target.quitdate.value;
					
					// 만약 사원 번호(사원 정보)가 없는 경우
					if(empno == ""){
						alert("사원 번호를 입력하세요");
					// 정보가 조회되지 않은 경우
					} else if(ename == "") {
						alert("조회 버튼을 눌러주세요")
					} else if(ename == 'null'){
						alert("정보가 없습니다");	
					// 만약 퇴사일을 선택하지 않은 경우
					} else if(quitdate == "") {
						alert("퇴사일을 입력하세요");
					// 위 경우가 모두 아니라면 퇴사 처리 진행
					} else {
						const queryString = new URLSearchParams(data).toString();
						const url = e.target.action;
						
						fetch(url,{
							method:"POST",
							headers:{"Content-Type":"application/x-www-form-urlencoded; charset=utf-8"},
							body: queryString
						})
						.then(res => res.json())
						.then(data=>{
							console.log(data);
							if(data.isAddSuccess && data.isDeleteSuccess){
								alert(ename+"("+empno+") 을(를) "+quitdate+" 일자로 퇴사 처리 하였습니다.");
							} else if(data.isAddSuccess){
								alert("EMP 테이블에서 삭제 실패. 개발자 확인 요망!");
							} else {
								alert("QUIT 테이블에 추가 실패. 개발자 확인 요망!");
							}
							location.href = "quitForm.jsp";
						})
						.catch((err)=>{
							console.log(err);
						});
					}
				}
			},//methods
			created(){
				
			}
		});
	</script>
</body>
</html>