package test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import test.dto.Com1EmpLogDto;
import test.util.DbcpBean;

public class Com1EmpLogDao {
	private static Com1EmpLogDao dao;

	static {
		dao = new Com1EmpLogDao();
	}

	private Com1EmpLogDao() {
	}

	public static Com1EmpLogDao getInstance() {
		return dao;
	}

	// 출근
	public boolean insertStart(Com1EmpLogDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					        insert into test_com1_emp_log
					        (logid, empno, check_in, working_date)
					        values (test_emplog_seq.NEXTVAL, ?, SYSDATE + (9/24), TRUNC(SYSDATE))
					""";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getEmpno()); // 직원 번호
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

	// 퇴근
	public boolean updateFinish(Com1EmpLogDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = """
						UPDATE test_com1_emp_log
						SET check_out = SYSDATE + (9/24)
						WHERE empno = ? 
						AND check_out IS NULL 
						AND TRUNC(working_date) = TRUNC(SYSDATE)
            """;
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getEmpno());

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

	public List<Com1EmpLogDto> getList(int empno) {

		List<Com1EmpLogDto> list = new ArrayList<>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			
			conn = new DbcpBean().getConn();
			
			String sql = """
					select * from test_com1_emp_log
					where empno = ?
					""";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, empno);
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Com1EmpLogDto dto = new Com1EmpLogDto();
				dto.setLogid(rs.getInt("logid"));
				dto.setEmpno(empno);
				dto.setCheckIn(rs.getTimestamp("check_In"));
				dto.setCheckOut(rs.getTimestamp("check_Out"));
				dto.setWorkingDate(rs.getDate("working_Date"));
				dto.setWorkingHours(rs.getDouble("working_Hours"));
				dto.setOvertime(rs.getDouble("overtime"));
				dto.setRemarks(rs.getString("remarks"));
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
	
	//삭제
	public boolean delete(int empno) {
		
		Connection conn = null;
        PreparedStatement pstmt = null;
        int rowCount = 0;
        try {
            conn = new DbcpBean().getConn();
            String sql = """
                delete from test_com1_emp_log
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
	//월 계산
	public int getCountByMonth(int empno, String month) {
	    int count = 0;

	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    try {
	        conn = new DbcpBean().getConn();
	        
	        StringBuilder sql = new StringBuilder();
	        sql.append("SELECT COUNT(*) AS count FROM test_com1_emp_log ");
	        sql.append("WHERE empno = ?");
	        sql.append("AND TO_CHAR(working_date, 'MM') = ? "); // 월만 비교
	        
	        pstmt = conn.prepareStatement(sql.toString());
	        pstmt.setInt(1, empno);
	        pstmt.setString(2, String.format("%02d", Integer.parseInt(month))); // 1 → '01' 변환

	        rs = pstmt.executeQuery();

	        if (rs.next()) {
	            count = rs.getInt("count");
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	    return count;
	}
	
	public List<Com1EmpLogDto> getListByMonth(int empno, String month, int startRowNum, int endRowNum) {
	    List<Com1EmpLogDto> list = new ArrayList<>();

	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    try {
	        conn = new DbcpBean().getConn();
	        
	        StringBuilder sql = new StringBuilder();
	        sql.append("SELECT * FROM ( ");
	        sql.append("    SELECT result1.*, ROWNUM AS rnum FROM ( ");
	        sql.append("        SELECT logid, check_in, check_out, working_date, working_hours, overtime, remarks ");
	        sql.append("        FROM test_com1_emp_log ");
	        sql.append("        WHERE empno = ? ");
	        sql.append("        AND TO_CHAR(working_date, 'MM') = ? "); // 월 필터링
	        sql.append("        ORDER BY check_in DESC "); // working_date DESC 로 바꾸기
	        sql.append("    ) result1 ");
	        sql.append(") WHERE rnum BETWEEN ? AND ?");

	        pstmt = conn.prepareStatement(sql.toString());

	        // 바인딩 값 설정
	        pstmt.setInt(1, empno);
	        pstmt.setString(2, String.format("%02d", Integer.parseInt(month))); // 1 → '01' 변환
	        pstmt.setInt(3, startRowNum);
	        pstmt.setInt(4, endRowNum);

	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            Com1EmpLogDto dto = new Com1EmpLogDto();
	            dto.setLogid(rs.getInt("logid"));

	            dto.setCheckIn(rs.getTimestamp("check_In"));
	            dto.setCheckOut(rs.getTimestamp("check_Out"));
	            dto.setWorkingDate(rs.getDate("working_Date"));
	            dto.setWorkingHours(rs.getDouble("working_Hours"));
	            dto.setOvertime(rs.getDouble("overtime"));
	            dto.setRemarks(rs.getString("remarks"));
	            list.add(dto);
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (rs != null) rs.close();
	            if (pstmt != null) pstmt.close();
	            if (conn != null) conn.close();
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	    return list;
	}
	
	
}