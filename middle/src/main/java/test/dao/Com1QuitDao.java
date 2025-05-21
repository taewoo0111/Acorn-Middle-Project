package test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import test.dto.Com1EmpDto;
import test.dto.Com1QuitDto;
import test.util.DbcpBean;

public class Com1QuitDao {

	private static Com1QuitDao dao;
	static {
		dao = new Com1QuitDao();
	}
	private Com1QuitDao() {}
	public static Com1QuitDao getInstance() {
		return dao;
	}
	
	// 퇴사자의 정보를 삭제하는 메소드
	public boolean delete(int empno) {
		// DB 연결
		Connection conn = null;
        PreparedStatement pstmt = null;
        
        int rowCount = 0;
        try {
            conn = new DbcpBean().getConn();
            
            // SQL 문 생성
            String sql = """
                DELETE from test_com1_quit
                WHERE empno=?
            """;
            
            // ? 값 바인딩
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, empno);
            
            // SQL 실행
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
        
        System.out.println("삭제 처리 결과 row 개수: " + rowCount);
        // 결과 처리
        if (rowCount > 0) {
			return true;
		} else {
			return false;
		}
	}
	
	// 퇴사자의 정보를 추출하는 메소드
	public Com1QuitDto getData(int empno) {
		// Dto 만들기
		Com1QuitDto dto = new Com1QuitDto();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// DB 연결
			conn = new DbcpBean().getConn();
			// SELECT SQL 문
			String sql = """
					SELECT * FROM test_com1_quit
					WHERE empno=?
					""";
			
			// ? 값 바인딩
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, empno);
			
			// SQL문 실행
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
				dto.setHiredate((rs.getString("hiredate")).substring(0,(rs.getString("hiredate")).indexOf(" ")));
				dto.setQuitdate((rs.getString("quitdate")).substring(0,(rs.getString("quitdate")).indexOf(" ")));
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
	
	// 새 데이터 추가하는 메소드 
	public boolean insert(Com1EmpDto dto, String quitdate) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					INSERT INTO test_com1_quit
					(COMID, STORENUM, EMPNO, ENAME, ROLE, ECALL, EMAIL, CONTRACT, EPWD, SAL, HSAL, WORKTIME, HIREDATE, QUITDATE)
					VALUES(?,?,?,?,?,?,?,?,?,?,?,?,TO_DATE(?,'YYYY-MM-DD HH24:MI:SS'),TO_DATE(?,'YYYY-MM-DD HH24:MI:SS'))
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값을 여기서 바인딩한다.
			pstmt.setInt(1, dto.getComId());
			pstmt.setInt(2, dto.getStoreNum());
			pstmt.setInt(3, dto.getEmpNo());
			pstmt.setString(4, dto.geteName());
			pstmt.setString(5, dto.getRole());
			pstmt.setString(6, dto.geteCall());
			pstmt.setString(7, dto.getEmail());
			pstmt.setString(8, dto.getContract());
			pstmt.setString(9, dto.getePwd());
			pstmt.setInt(10, dto.getSal());
			pstmt.setInt(11, dto.getHsal());
			pstmt.setInt(12, dto.getWorktime());
			pstmt.setString(13, dto.getHiredate());
			pstmt.setString(14, quitdate);
			
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
		
	
	
	
	
	// 리스트 개수만 가져오는 메소드
	public int getCount(Com1QuitDto dto) {
		
		int count = 0;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = new DbcpBean().getConn();
			
			// 쿼리문 생성
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT COUNT(*) AS count FROM test_com1_quit");
			
			if(dto.getCondition() != null && dto.getKeyword() != null && !dto.getKeyword().isEmpty()) {
				sql.append(" WHERE ").append(dto.getCondition()).append(" LIKE ? ");
			}
			
			pstmt = conn.prepareStatement(sql.toString()); 
			
			
			// 검색조건이 있는 경우 LIKE ? 에 값 바인딩
			if(dto.getCondition() != null && dto.getKeyword() != null && !dto.getKeyword().isEmpty()) {
				pstmt.setString(1, "%" + dto.getKeyword() + "%");
			}
			
			
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
	
	
	
	
	
	// 리스트 정보를 가져오는 메소드
	public List<Com1QuitDto> getList(Com1QuitDto dto) {
		List<Com1QuitDto> list = new ArrayList<>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = new DbcpBean().getConn();
			System.out.println("dto.getLineup(): " + dto.getLineup());
			// SQL 문 생성
			StringBuilder sql = new StringBuilder();
			sql.append("SELECT * FROM ");
			sql.append("(SELECT result1.*, ROWNUM AS rnum FROM ");
			sql.append("(SELECT empno, ename, storenum, role, ecall, TO_CHAR(hiredate, 'YYYY.MM.DD') AS hiredate, TO_CHAR(quitdate, 'YYYY.MM.DD') AS quitdate FROM test_com1_quit ");
			
			// 만약 키워드 검색 옵션 값이 있다면
			if(dto.getCondition() != null && dto.getKeyword() != null && !dto.getKeyword().isEmpty()) {
				sql.append("WHERE ").append(dto.getCondition()).append(" LIKE ? ");
			}
			
			// 만약 정렬 옵션 값이 있다면
			if(dto.getLineup() != null && dto.getPicked() != null) {
				sql.append("ORDER BY ").append(dto.getLineup()).append(" ").append(dto.getPicked()).append(") ");
				//sql.append("ORDER BY ? ?) ");
			} else {
				sql.append(") ");
			}
			
			sql.append("result1) WHERE rnum BETWEEN ? AND ?");
			
			// ? 바인딩
			pstmt = conn.prepareStatement(sql.toString());
			
			int paramIndex = 1;
			// 만약 키워드 검색 옵션 값이 있다면
			if(dto.getCondition() != null && dto.getKeyword() != null && !dto.getKeyword().isEmpty()) {
				pstmt.setString(paramIndex++, "%" + dto.getKeyword() + "%");
			}
			// 만약 정렬 옵션 값이 있다면
			if(dto.getLineup() != null && dto.getPicked() != null) {
				//pstmt.setString(paramIndex++, dto.getLineup());
				//pstmt.setString(paramIndex++, dto.getPicked());
			}
			pstmt.setInt(paramIndex++, dto.getStartRowNum());
			pstmt.setInt(paramIndex, dto.getEndRowNum());
			
			System.out.println("실행 sql 문: " + sql);
			// 쿼리 실행 및 결과 추출
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Com1QuitDto tmp = new Com1QuitDto();
				tmp.setEmpNo(rs.getInt("empno"));
				tmp.seteName(rs.getString("ename"));
				tmp.setStoreNum(rs.getInt("storenum"));
				tmp.setRole(rs.getString("role"));
				tmp.seteCall(rs.getString("ecall"));
				tmp.setHiredate(rs.getString("hiredate"));
				tmp.setQuitdate(rs.getString("quitdate"));
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
		System.out.println(list);
		return list;
	}
}
