package test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import test.dto.Com1WaitDto;
import test.util.DbcpBean;

public class Com1WaitDao {
	
	private static Com1WaitDao dao;
	
	static {
		dao = new Com1WaitDao();
	}
	
	private Com1WaitDao() {}
	
	public static Com1WaitDao getInstance() {
		return dao;
	}
	
	public boolean insert(Com1WaitDto dto) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					insert into test_com1_wait
					(comid, storenum, empno, ename, role, ecall, epwd, email)
					values(?, ?, test_empno_seq.nextval, ?,?,?,?,?)
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값을 여기서 바인딩한다.
			pstmt.setInt(1, dto.getComId());
			pstmt.setInt(2, dto.getStoreNum());
			pstmt.setString(3, dto.geteName());
			pstmt.setString(4, dto.getRole());
			pstmt.setString(5, dto.geteCall());
			pstmt.setString(6, dto.getePwd());
			pstmt.setString(7, dto.getEmail());
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
                delete from test_com1_wait
                WHERE empno=?
            """;
            pstmt = conn.prepareStatement(sql);
            pstmt.setLong(1, empno);
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
	
	public Com1WaitDto getData(int empno) {
			
		Com1WaitDto dto = new Com1WaitDto();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection Pool 로 부터 Connection 객체 하나 가져오기 
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = """
					select comid, storenum, empno, ename, role, ecall, epwd, email
					from test_com1_wait
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
				dto.setEmail(rs.getString("email"));
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
	
	public List<Com1WaitDto> getListAdmin(){
		// List 만들기
		List<Com1WaitDto> list = new ArrayList<>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection Pool 로 부터 Connection 객체 하나 가져오기 
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = """
					select * from test_com1_wait
					where role = ?
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값 바인딩할게 있으면 여기서 하기
			pstmt.setString(1, "ADMIN");
			//sql 문 실행하고 결과를 ResultSet 객체로 리턴받기
			rs = pstmt.executeQuery();
			while (rs.next()) {
				// Dto 만들고 list.add
				Com1WaitDto dto = new Com1WaitDto();
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

	public List<Com1WaitDto> getListStaff(){
		// List 만들기
		List<Com1WaitDto> list = new ArrayList<>();

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// Connection Pool 로 부터 Connection 객체 하나 가져오기
			conn = new DbcpBean().getConn();
			// 실행할 sql 문 작성
			String sql = """
					select * from test_com1_wait
					where role = ?
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값 바인딩할게 있으면 여기서 하기
			pstmt.setString(1, "STAFF");
			// sql 문 실행하고 결과를 ResultSet 객체로 리턴받기
			rs = pstmt.executeQuery();
			while (rs.next()) {
				// Dto 만들고 list.add
				Com1WaitDto dto = new Com1WaitDto();
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
}
