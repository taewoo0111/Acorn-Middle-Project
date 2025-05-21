package test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import test.dto.Com1CeoDto;
import test.util.DbcpBean;

public class Com1CeoDao {
	
	private static Com1CeoDao dao;
	
	static {
		dao = new Com1CeoDao();
	}
	
	private Com1CeoDao() {}
	
	public static Com1CeoDao getInstance() {
		return dao;
	}
	
	public boolean update(Com1CeoDto dto) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					update test_com1_ceo
					set ename=?, ecall=?, epwd=?
					where empno =?
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값을 여기서 바인딩한다.
			pstmt.setString(1, dto.geteName());
			pstmt.setString(2, dto.geteCall());
			pstmt.setString(3, dto.getePwd());
			pstmt.setInt(4, dto.getEmpNo());
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

	public Com1CeoDto getData(int empno) {
		// Dto 만들기
		Com1CeoDto dto = null;
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection Pool 로 부터 Connection 객체 하나 가져오기 
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = """
					select comid, empno, ename, role, ecall, epwd
					from test_com1_ceo
					where empno=?
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값 바인딩할게 있으면 여기서 하기
			pstmt.setInt(1, empno);
			//sql 문 실행하고 결과를 ResultSet 객체로 리턴받기
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto = new Com1CeoDto();
				dto.setComId(rs.getInt("comid"));
				dto.setEmpNo(rs.getInt("empno"));
				dto.seteName(rs.getString("ename"));
				dto.setRole(rs.getString("role"));
				dto.seteCall(rs.getString("ecall"));
				dto.setePwd(rs.getString("epwd"));
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

	public boolean insert(Com1CeoDto dto) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					insert into test_com1_ceo
					(comid, empno, ename, role, ecall, epwd)
					values(?, test_empno_seq.nextval, ?,'CEO',?,?)
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값을 여기서 바인딩한다.
			pstmt.setInt(1, dto.getComId());
			pstmt.setString(2, dto.geteName());
			pstmt.setString(3, dto.geteCall());
			pstmt.setString(4, dto.getePwd());
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

	public List<Com1CeoDto> getList(){
		// List 만들기
		List<Com1CeoDto> list = new ArrayList<>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection Pool 로 부터 Connection 객체 하나 가져오기 
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = """
					select comid, empno, ename, role, ecall, epwd
					from test_com1_ceo
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값 바인딩할게 있으면 여기서 하기

			//sql 문 실행하고 결과를 ResultSet 객체로 리턴받기
			rs = pstmt.executeQuery();
			while (rs.next()) {
				// Dto 만들고 list.add
				Com1CeoDto dto = new Com1CeoDto();
				dto.setComId(rs.getInt("comid"));
				dto.setEmpNo(rs.getInt("empno"));
				dto.seteName(rs.getString("ename"));
				dto.setRole(rs.getString("role"));
				dto.seteCall(rs.getString("ecall"));
				dto.setePwd(rs.getString("epwd"));
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
			String sql = "SELECT COUNT(*) FROM test_com1_ceo WHERE ecall = ?";
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
			String sql = "SELECT COUNT(*) FROM test_com1_ceo WHERE email = ?";
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
}
