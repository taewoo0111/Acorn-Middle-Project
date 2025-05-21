package test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import test.dto.Com1EmpDto;
import test.dto.Com1QuitDto;
import test.util.DbcpBean;

public class Com1EmpDao {
	
	private static Com1EmpDao dao;
	
	static {
		dao = new Com1EmpDao();
	}
	
	private Com1EmpDao() {}
	
	public static Com1EmpDao getInstance() {
		return dao;
	}
	
	public boolean insert(Com1EmpDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					insert into test_com1_emp
					(comid, storenum, empno, ename, role, ecall, epwd, email)
					values(?, ?, ?, ?,?,?,?,?)
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값을 여기서 바인딩한다.
			pstmt.setInt(1, dto.getComId());
			pstmt.setInt(2, dto.getStoreNum());
			pstmt.setInt(3, dto.getEmpNo());
			pstmt.setString(4, dto.geteName());
			pstmt.setString(5, dto.getRole());
			pstmt.setString(6, dto.geteCall());
			pstmt.setString(7, dto.getePwd());
			pstmt.setString(8, dto.getEmail());
			// sql 문을 실행하고 변화된 row 의 개수를 리턴받기
			rowCount = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (Exception e) {
			}
		}
		if (rowCount > 0) {
			return true;
		} else {
			return false;
		}
	}

	public Com1EmpDto getData(int empno) {
		// Dto 만들기
		Com1EmpDto dto = new Com1EmpDto();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection Pool 로 부터 Connection 객체 하나 가져오기 
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = """
					select * from test_com1_emp
					where empno=?
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값 바인딩할게 있으면 여기서 하기
			pstmt.setInt(1, empno);
			//sql 문 실행하고 결과를 ResultSet 객체로 리턴받기
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setComId(rs.getInt("comid"));
				dto.setStoreNum(rs.getInt("storenum"));
				dto.setEmpNo(empno);
				dto.seteName(rs.getString("ename"));
				dto.setRole(rs.getString("role"));
				dto.seteCall(rs.getString("ecall"));
				dto.setePwd(rs.getString("epwd"));
				dto.setSal(rs.getInt("sal"));
				dto.setHsal(rs.getInt("hsal"));
				dto.setWorktime(rs.getInt("worktime"));
				dto.setEmail(rs.getString("email"));
				//dto.setHiredate(rs.getString("hiredate")); - 원래 코드
				dto.setHiredate((rs.getString("hiredate")).substring(0,(rs.getString("hiredate")).indexOf(" ")));
				dto.setContract(rs.getString("contract"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
			}
		}
		return dto;
	}

	public boolean update(Com1EmpDto dto) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					update test_com1_emp
					set ename=?, ecall=?, epwd=?, sal=?, hsal=?, worktime=?, email=?, contract=?
					where empno=?
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값을 여기서 바인딩한다.
			pstmt.setString(1, dto.geteName());
			pstmt.setString(2, dto.geteCall());
			pstmt.setString(3, dto.getePwd());
			pstmt.setInt(4, dto.getSal());
			pstmt.setInt(5, dto.getHsal());
			pstmt.setInt(6, dto.getWorktime());
			pstmt.setString(7, dto.getEmail());
			pstmt.setString(8, dto.getContract());
			pstmt.setInt(9, dto.getEmpNo());
			// sql 문을 실행하고 변화된 row 의 개수를 리턴받기
			rowCount = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (Exception e) {
			}
		}
		if (rowCount > 0) {
			return true;
		} else {
			return false;
		}
	}

	public boolean delete(int empno) {
		
		Connection conn = null;
        PreparedStatement pstmt = null;
        int rowCount = 0;
        try {
            conn = new DbcpBean().getConn();
            String sql = """
                delete from test_com1_emp
                WHERE empno=?
            """;
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, empno);
            rowCount = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) {
					pstmt.close();
				}
                if (conn != null) {
					conn.close();
				}
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (rowCount > 0) {
			return true;
		} else {
			return false;
		}
	}

	public List<Com1EmpDto> getList(){
		// List 만들기
		List<Com1EmpDto> list = new ArrayList<>();

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// Connection Pool 로 부터 Connection 객체 하나 가져오기
			conn = new DbcpBean().getConn();
			// 실행할 sql 문 작성
			String sql = """
					select * from test_com1_emp
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값 바인딩할게 있으면 여기서 하기
		
			// sql 문 실행하고 결과를 ResultSet 객체로 리턴받기
			rs = pstmt.executeQuery();
			while (rs.next()) {
				// Dto 만들고 list.add
				Com1EmpDto dto = new Com1EmpDto();
				dto.setComId(rs.getInt("comid"));
				dto.setStoreNum(rs.getInt("storenum"));
				dto.setEmpNo(rs.getInt("empno"));
				dto.seteName(rs.getString("ename"));
				dto.setRole(rs.getString("role"));
				dto.setRole(rs.getString("role"));
				dto.seteCall(rs.getString("ecall"));
				dto.setePwd(rs.getString("epwd"));
				dto.setSal(rs.getInt("sal"));
				dto.setHsal(rs.getInt("hsal"));
				dto.setWorktime(rs.getInt("worktime"));
				dto.setEmail(rs.getString("email"));
				dto.setHiredate(rs.getString("hiredate"));
				dto.setContract(rs.getString("contract"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
			}
		}
		return list;
	}

	public List<Com1EmpDto> getListAdmin(){
		// List 만들기
		List<Com1EmpDto> list = new ArrayList<>();

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// Connection Pool 로 부터 Connection 객체 하나 가져오기
			conn = new DbcpBean().getConn();
			// 실행할 sql 문 작성
			String sql = """
					select * from test_com1_emp
					where role = ?
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값 바인딩할게 있으면 여기서 하기
			pstmt.setString(1, "ADMIN");
			// sql 문 실행하고 결과를 ResultSet 객체로 리턴받기
			rs = pstmt.executeQuery();
			while (rs.next()) {
				// Dto 만들고 list.add
				Com1EmpDto dto = new Com1EmpDto();
				dto.setComId(rs.getInt("comid"));
				dto.setStoreNum(rs.getInt("storenum"));
				dto.setEmpNo(rs.getInt("empno"));
				dto.seteName(rs.getString("ename"));
				dto.setRole(rs.getString("role"));
				dto.seteCall(rs.getString("ecall"));
				dto.setePwd(rs.getString("epwd"));
				dto.setSal(rs.getInt("sal"));
				dto.setHsal(rs.getInt("hsal"));
				dto.setWorktime(rs.getInt("worktime"));
				dto.setEmail(rs.getString("email"));
				dto.setHiredate(rs.getString("hiredate"));
				dto.setContract(rs.getString("contract"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
			}
		}
		return list;
	}
	
	public List<Com1EmpDto> getListStaff(){
		// List 만들기
		List<Com1EmpDto> list = new ArrayList<>();

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// Connection Pool 로 부터 Connection 객체 하나 가져오기
			conn = new DbcpBean().getConn();
			// 실행할 sql 문 작성
			String sql = """
					select * from test_com1_emp
					where role = ?
					ORDER BY empno ASC
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값 바인딩할게 있으면 여기서 하기
			pstmt.setString(1, "STAFF");
			// sql 문 실행하고 결과를 ResultSet 객체로 리턴받기
			rs = pstmt.executeQuery();
			while (rs.next()) {
				// Dto 만들고 list.add
				Com1EmpDto dto = new Com1EmpDto();
				dto.setComId(rs.getInt("comid"));
				dto.setStoreNum(rs.getInt("storenum"));
				dto.setEmpNo(rs.getInt("empno"));
				dto.seteName(rs.getString("ename"));
				dto.setRole(rs.getString("role"));
				dto.seteCall(rs.getString("ecall"));
				dto.setePwd(rs.getString("epwd"));
				dto.setSal(rs.getInt("sal"));
				dto.setHsal(rs.getInt("hsal"));
				dto.setWorktime(rs.getInt("worktime"));
				dto.setEmail(rs.getString("email"));
				dto.setHiredate(rs.getString("hiredate"));
				dto.setContract(rs.getString("contract"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
			}
		}
		return list;
	}

	public List<Com1EmpDto> getListByStoreNum(int storenum){
		// List 만들기
		List<Com1EmpDto> list = new ArrayList<>();

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// Connection Pool 로 부터 Connection 객체 하나 가져오기
			conn = new DbcpBean().getConn();
			// 실행할 sql 문 작성
			String sql = """
					select * from test_com1_emp
					where storenum = ?
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값 바인딩할게 있으면 여기서 하기
			pstmt.setInt(1, storenum);
			// sql 문 실행하고 결과를 ResultSet 객체로 리턴받기
			rs = pstmt.executeQuery();
			while (rs.next()) {
				// Dto 만들고 list.add
				Com1EmpDto dto = new Com1EmpDto();
				dto.setComId(rs.getInt("comid"));
				dto.setStoreNum(storenum);
				dto.setEmpNo(rs.getInt("empno"));
				dto.seteName(rs.getString("ename"));
				dto.setRole(rs.getString("role"));
				dto.seteCall(rs.getString("ecall"));
				dto.setePwd(rs.getString("epwd"));
				dto.setSal(rs.getInt("sal"));
				dto.setHsal(rs.getInt("hsal"));
				dto.setWorktime(rs.getInt("worktime"));
				dto.setEmail(rs.getString("email"));
				//dto.setHiredate(rs.getString("hiredate")); 원래 코드 (시간은 안 가져오게 수정) - 최유진
				dto.setHiredate((rs.getString("hiredate")).substring(0,(rs.getString("hiredate")).indexOf(" ")));
				dto.setContract(rs.getString("contract"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
			}
		}
		return list;
	}

	public boolean isDuplicateEcall(String ecall) {
		boolean isDuplicate = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT COUNT(*) FROM test_com1_emp WHERE ecall = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ecall); // 전화번호 바인딩

			rs = pstmt.executeQuery();
			if (rs.next()) {
				int count = rs.getInt(1); // COUNT 결과 가져오기
				isDuplicate = count > 0; // 1개 이상이면 중복
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return isDuplicate;
	}
	
	public boolean isDuplicateEmail(String email) {
		boolean isDuplicate = false;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = new DbcpBean().getConn();
			String sql = "SELECT COUNT(*) FROM test_com1_emp WHERE email = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email); // 전화번호 바인딩

			rs = pstmt.executeQuery();
			if (rs.next()) {
				int count = rs.getInt(1); // COUNT 결과 가져오기
				isDuplicate = count > 0; // 1개 이상이면 중복
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return isDuplicate;
	}
	
	
	// 리스트 개수만 가져오는 메소드
	public int getCount(Com1EmpDto dto) {
		
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = new DbcpBean().getConn();
			
			// 쿼리문 생성
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT COUNT(*) AS count FROM test_com1_emp");
			// 조건이 '모두' 가 아니라면
			if(!dto.getCondition().equals("ALL")) {
				// 조건이 '지점'별 조회 라면
				if(dto.getCondition().equals("STORE")) sql.append(" WHERE STORENUM = ? ");
				// 조건이 '점장' 또는 '직원' 이라면
				else sql.append(" WHERE ROLE = ? ");
			}
			
			
			
			// 검색조건이 있는 경우 LIKE ? 에 값 바인딩
			pstmt = conn.prepareStatement(sql.toString());
			// 조건이 '모두' 가 아니라면
			if(!dto.getCondition().equals("ALL")) {
				// 조건이 '지점'별 조회 라면
				if(dto.getCondition().equals("STORE")) pstmt.setInt(1, dto.getStoreNum());
				// 조건이 '점장' 또는 '직원' 이라면
				else pstmt.setString(1, dto.getCondition());
			}
			
			
			System.out.println(sql);
			
			// 쿼리 실행 및 결과 추출
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt("count");
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {e.printStackTrace();}
		}
		
		return count;
	}
	
	
	// 리스트 정보를 가져오는 메소드 (페이징 처리와 함께 조회하기 위한 메소드 추가함 - 최유진)
	public List<Com1EmpDto> getList2(Com1EmpDto dto) {
		List<Com1EmpDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = new DbcpBean().getConn();
			
			// SQL 문 생성
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT * FROM ");
			sql.append("(SELECT result1.*, ROWNUM AS rnum FROM ");
			sql.append("(SELECT empno, ename, storenum, role, ecall, email, sal, hsal, worktime, TO_CHAR(hiredate, 'YYYY.MM.DD') AS hiredate FROM test_com1_emp ");
			
			// 조건이 '모두' 가 아니라면
			if(!dto.getCondition().equals("ALL")) {
				// 조건이 '지점'별 조회 라면
				if(dto.getCondition().equals("STORE")) sql.append("WHERE STORENUM = ? ");
				// 조건이 '점장' 또는 '직원' 이라면
				else sql.append("WHERE ROLE = ? ");
			}
			sql.append("ORDER BY hiredate DESC) result1) WHERE rnum BETWEEN ? AND ?");
			
			
			// ? 바인딩
			pstmt = conn.prepareStatement(sql.toString());
			int paramIndex = 1;
			// 조건이 '모두' 가 아니라면
			if(!dto.getCondition().equals("ALL")) {
				// 조건이 '지점'별 조회 라면
				if(dto.getCondition().equals("STORE")) pstmt.setInt(paramIndex++, dto.getStoreNum());
				// 조건이 '점장' 또는 '직원' 이라면
				else pstmt.setString(paramIndex++, dto.getCondition());
			}
			pstmt.setInt(paramIndex++, dto.getStartRowNum());
			pstmt.setInt(paramIndex, dto.getEndRowNum());
			
			
			System.out.println(sql);
			// 쿼리 실행 및 결과 추출
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Com1EmpDto tmp = new Com1EmpDto();
				tmp.setEmpNo(rs.getInt("empno"));
				tmp.seteName(rs.getString("ename"));
				tmp.setStoreNum(rs.getInt("storenum"));
				tmp.setRole(rs.getString("role"));
				tmp.seteCall(rs.getString("ecall"));
				tmp.setHiredate(rs.getString("email"));
				tmp.setHiredate(rs.getString("sal"));
				tmp.setHiredate(rs.getString("hsal"));
				tmp.setHiredate(rs.getString("worktime"));
				tmp.setHiredate(rs.getString("hiredate"));
				list.add(tmp);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {e.printStackTrace();}
		}
		return list;
	}
	//페이징처리를 위한 staff리스트 정보를 가져오는 메소드 //장희주
	public List<Com1EmpDto> getList3(Com1EmpDto dto) {
		List<Com1EmpDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = new DbcpBean().getConn();
			
			// SQL 문 생성
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT * FROM ");
			sql.append("(SELECT result1.*, ROWNUM AS rnum FROM ");
			sql.append("(SELECT * FROM test_com1_emp ");
						
			sql.append("WHERE ROLE = 'STAFF' ");
			sql.append("ORDER BY empno ASC) result1) WHERE rnum BETWEEN ? AND ?");
			
			//누적된 sql문 얻어내서 실행
			pstmt = conn.prepareStatement(sql.toString());
			// ? 바인딩 //페이징처리와 관련된 값 바인딩
			int paramIndex = 1;
			pstmt.setInt(paramIndex++, dto.getStartRowNum());
			pstmt.setInt(paramIndex, dto.getEndRowNum());
			
			
			System.out.println(sql.toString()); 
			// 쿼리 실행 및 결과 추출
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Com1EmpDto tmp = new Com1EmpDto();
				tmp.setComId(rs.getInt("comid"));
				tmp.setStoreNum(rs.getInt("storenum"));
				tmp.setEmpNo(rs.getInt("empno"));
				tmp.seteName(rs.getString("ename"));
				tmp.setRole(rs.getString("role"));
				tmp.seteCall(rs.getString("ecall"));
				tmp.setePwd(rs.getString("epwd"));
				tmp.setSal(rs.getInt("sal"));
				tmp.setHsal(rs.getInt("hsal"));
				tmp.setWorktime(rs.getInt("worktime"));
				tmp.setEmail(rs.getString("email"));
				tmp.setHiredate(rs.getString("hiredate"));
				tmp.setContract(rs.getString("contract"));
				list.add(tmp);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {e.printStackTrace();}
		}
		return list;
	}		
}



