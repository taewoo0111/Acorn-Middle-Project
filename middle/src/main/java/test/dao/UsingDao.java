package test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import test.dto.UsingDto;
import test.util.DbcpBean;

public class UsingDao {
	
	private static UsingDao dao;
	
	static {
		dao = new UsingDao();
	}
	
	private UsingDao() {}
	
	public static UsingDao getInstance() {
		return dao;
	}
	
	public List<Integer> getComIdList(){
		// List 만들기
		List<Integer> list = new ArrayList<>();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection Pool 로 부터 Connection 객체 하나 가져오기 
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = """
					select comid
					from test_using_app
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값 바인딩할게 있으면 여기서 하기

			//sql 문 실행하고 결과를 ResultSet 객체로 리턴받기
			rs = pstmt.executeQuery();
			while (rs.next()) {
				// Dto 만들고 list.add
				list.add(rs.getInt("comid"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		return list;
		
	}

	public boolean insert(String comname) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					insert into test_using_app
					(comnum, comname, comid, createdat)
					values(test_comnum_seq.nextval, ?, test_comid_seq.nextval, sysdate)
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값을 여기서 바인딩한다.
			pstmt.setString(1, comname);
			// sql 문을 실행하고 변화된 row 의 개수를 리턴받기
			rowCount = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
				if (pstmt != null)
					pstmt.close();
			} catch (Exception e) {
			}
		}
		if (rowCount > 0) {
			return true;
		} else {
			return false;
		}
		
	}

	public boolean delete(int comid) {
		Connection conn = null;
        PreparedStatement pstmt = null;
        int rowCount = 0;
        try {
            conn = new DbcpBean().getConn();
            String sql = """
                delete from test_using_app
                WHERE comid=?
            """;
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, comid);
            rowCount = pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
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

	public String getComName(int comid) {
		// Dto 만들기
		String comname = null;
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			//Connection Pool 로 부터 Connection 객체 하나 가져오기 
			conn = new DbcpBean().getConn();
			//실행할 sql 문 작성
			String sql = """
					select comname
					from test_using_app
					where comid=?
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값 바인딩할게 있으면 여기서 하기
			pstmt.setInt(1, comid);
			//sql 문 실행하고 결과를 ResultSet 객체로 리턴받기
			rs = pstmt.executeQuery();
			if (rs.next()) {
				comname = rs.getString("comname");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		return comname;
	}

	public List<UsingDto> getList(){
		// List 만들기
		List<UsingDto> list = new ArrayList<>();

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// Connection Pool 로 부터 Connection 객체 하나 가져오기
			conn = new DbcpBean().getConn();
			// 실행할 sql 문 작성
			String sql = """
					select comnum, comname, comid, createdat
					from test_using_app
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값 바인딩할게 있으면 여기서 하기

			// sql 문 실행하고 결과를 ResultSet 객체로 리턴받기
			rs = pstmt.executeQuery();
			while (rs.next()) {
				// Dto 만들고 list.add
				UsingDto dto = new UsingDto();
				dto.setComNum(rs.getInt("comnum"));
				dto.setComName(rs.getString("comname"));
				dto.setComId(rs.getInt("comid"));
				dto.setCreateAt(rs.getString("createdat"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		return list;
	}
}
