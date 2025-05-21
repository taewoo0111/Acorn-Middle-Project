<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFCell"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFRow"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFSheet"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
<%@page import="org.apache.poi.openxml4j.opc.OPCPackage"%>
<%@page import="test.dto.Com1QuitDto"%>
<%@page import="test.dao.Com1QuitDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 관리자 이름 세션으로부터 가져오기
	String ename = (String)session.getAttribute("ename");

	
	boolean isExistEmp = false;
	Com1QuitDto dto = null;
	
	String strEmpno = request.getParameter("empno");
	
	// 입력 데이터가 잘 들어오면
	if(strEmpno != null && !strEmpno.isEmpty() && !strEmpno.isBlank()){
		// 파라미터 값을 숫자 형식으로 변환
		int empno = Integer.parseInt(strEmpno); 
		// 해당 사원번호에 맞는 정보 가져오기
		dto = Com1QuitDao.getInstance().getData(empno);
		
		// dto 사원 정보가 있는 겨우
		if(dto.geteName() != null){
			System.out.println("여기들어오나????");
			
			isExistEmp = true;
			
			// 템플릿 가져올 경로
			String templatePath = getServletContext().getRealPath("/file");
			File uploadDir = new File(templatePath);
			//만일 upload 폴더가 존재 하지 않으면 
			if(!uploadDir.exists()) {
				uploadDir.mkdir(); //실제로 폴더 만들기
			}
			String filePath = templatePath + "\\proof-of-employment.xlsx";
			//System.out.println(filePath);
			//C:\team\proj2\workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\middle\file\proof-of-employment.xlsx
			
			// 엑셀 파일 불러오기  filePath.replace("\\", "//")
			OPCPackage opcPackage = OPCPackage.open(new File(filePath.replace("\\", "//")));
			XSSFWorkbook workbook = new XSSFWorkbook(opcPackage); // 엑셀 생성
			
			String sheetName = workbook.getSheetName(0); // 첫번째 시트 
		    XSSFSheet sheet = workbook.getSheet(sheetName); // 시트 생성
		    
		    XSSFRow row = null;
		    XSSFCell cell = null;
		    // 이름
		    row = sheet.getRow(5);
		    cell = row.getCell(2);
		    cell.setCellValue(dto.geteName()); 
		    
		    // 지점 기입
		    row = sheet.getRow(9);
		    cell = row.getCell(2);
		    cell.setCellValue(dto.getStoreNum() + "호 점"); 
			
		    // 직급과 직급에 따른 업무 기입
		    if(dto.getRole() != null){
			    if(dto.getRole().equals("STAFF")){
			    	row = sheet.getRow(9);
				    cell = row.getCell(7);
			    	cell.setCellValue("직원"); 
			    	row = sheet.getRow(11);
				    cell = row.getCell(2);
			    	cell.setCellValue("매장 업무");
			    } else {
			    	row = sheet.getRow(9);
				    cell = row.getCell(7);
			    	cell.setCellValue("점장"); 
			    	row = sheet.getRow(11);
				    cell = row.getCell(2);
			    	cell.setCellValue("매장 업무, 매출 및 인사 관리");
			    }
		    }
		    
		    // 재직 기간
		    row = sheet.getRow(13);
		    cell = row.getCell(2);
		    cell.setCellValue(dto.getHiredate() + " ~ " + dto.getQuitdate()); 
		    
		    // 출력 날짜
		    SimpleDateFormat format = new SimpleDateFormat ( "yyyy 년 MM 월 dd 일");
			Date now = new Date();
			String nowStr = format.format(now);
		    System.out.println(nowStr);
		    row = sheet.getRow(36);
		    cell = row.getCell(0);
		    cell.setCellValue(nowStr); 
		    
		    // 회사명
		    row = sheet.getRow(48);
		    cell = row.getCell(7);
		    cell.setCellValue("Com1"); 
		    
		    // 대표자
			row = sheet.getRow(50);
		    cell = row.getCell(7);
		    cell.setCellValue(ename);  
		    
			// 다운로드폴더에 다운로드됨
			response.setContentType("ms-vnd/excel");
			response.setHeader("Content-Disposition", "attachment; filename=proof-of-employment-"+empno+".xlsx");
			response.setStatus(200);
			workbook.write(response.getOutputStream());
			workbook.close();
		}
	}

	System.out.println("isExistEmp: " + isExistEmp);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
	
		if(<%= isExistEmp%>){
			alert("없는 퇴사자 사원번호 입니다!")
		}
	
		// 다시 원래 자리로 돌아가기
		location.href= "printQuit.jsp?condition="+ this.condition + "&keyword=" + this.keyword + "&lineup=" + this.lineup + "&picked=" + this.picked;
	</script>
</body>
</html>