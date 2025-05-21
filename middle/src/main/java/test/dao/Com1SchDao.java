package test.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import test.dto.Com1SchDto;
import test.util.DbcpBean;

public class Com1SchDao {

	private static Com1SchDao dao;
	
	static {
		dao = new Com1SchDao();
	}
	
	private Com1SchDao() {}
	
	public static Com1SchDao getInstance() {
		return dao;
	}		
	
	//추가insert
	public boolean insert(Com1SchDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					insert into test_com1_sch
					(id, storeNum, schdate, srcurl)
					values(test_sch_seq.nextval, ?, ?, ?)
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값을 여기서 바인딩한다.
			pstmt.setInt(1, dto.getStoreNum());
			pstmt.setString(2, dto.getSchdate());
			pstmt.setString(3, dto.getSrcurl());
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
	} //추가	
	
	//삭제 delete
	public boolean delete(int storenum) {
		Connection conn = null;
        PreparedStatement pstmt = null;
        int rowCount = 0;
        try {
            conn = new DbcpBean().getConn();
            String sql = """
                delete from test_com1_sch
                WHERE storeNum=?
            """;
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, storenum);
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
	}//삭제
	
	//해당지점스케줄가져오기
	public List<Com1SchDto> getListSchStore(int storenum){
		// List 만들기
		List<Com1SchDto> list = new ArrayList<>();

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// Connection Pool 로 부터 Connection 객체 하나 가져오기
			conn = new DbcpBean().getConn();
			// 실행할 sql 문 작성
			String sql = """
					select * from test_com1_sch
					where storeNum = ?
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값 바인딩할게 있으면 여기서 하기
			pstmt.setInt(1, storenum);
			// sql 문 실행하고 결과를 ResultSet 객체로 리턴받기
			rs = pstmt.executeQuery();
			while (rs.next()) {
				// Dto 만들고 list.add
				Com1SchDto dto = new Com1SchDto();
				dto.setId(rs.getInt("id"));
				dto.setStoreNum(rs.getInt("storeNum"));
				dto.setSchdate(rs.getString("schdate"));
				dto.setSrcurl(rs.getString("srcurl"));
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
