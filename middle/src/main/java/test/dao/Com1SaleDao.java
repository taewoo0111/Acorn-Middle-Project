package test.dao;

import java.beans.Statement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import test.dto.Com1EmpDto;
import test.dto.Com1SaleDto;
import test.util.DbcpBean;

public class Com1SaleDao {

	private static Com1SaleDao dao;

	static {
		dao = new Com1SaleDao();
	}

	private Com1SaleDao() {
	}

	public static Com1SaleDao getInstance() {
		return dao;
	}

	// 추가
	public boolean insert(Com1SaleDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					insert into test_com1_sales
					(salesDate, storeNum, dailySales)
					values(?,?,?)
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값을 여기서 바인딩한다.
			pstmt.setString(1, dto.getSalesDate());
			pstmt.setInt(2, dto.getStoreNum());
			pstmt.setInt(3, dto.getDailySales());
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

	// 삭제
	// ?호점의 ?일 매출 삭제
//	public boolean delete(String saleDate, int storeNum) {
//		Connection conn = null;
//		PreparedStatement pstmt = null;
//		int rowCount = 0;
//		try {
//			conn = new DbcpBean().getConn();
//			String sql = """
//					    delete from test_com1_sales
//					    WHERE storeNum=? and saleDate=?
//					""";
//			pstmt = conn.prepareStatement(sql);
//			pstmt.setInt(2, storeNum);
//			pstmt.setString(1, saleDate);
//
//			rowCount = pstmt.executeUpdate();
//		} catch (Exception e) {
//			e.printStackTrace();
//		} finally {
//			try {
//				if (pstmt != null)
//					pstmt.close();
//				if (conn != null)
//					conn.close();
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//		}
//		if (rowCount > 0) {
//			return true;
//		} else {
//			return false;
//		}
//	}

	// 수정
	// 매출 수정
	public boolean update(Com1SaleDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int rowCount = 0;
		try {
			conn = new DbcpBean().getConn();
			String sql = """
					update test_com1_sales
					set dailySales=?
					where storeNum=? and salesDate=?
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값을 여기서 바인딩한다.
			pstmt.setInt(1, dto.getDailySales());
			pstmt.setInt(2, dto.getStoreNum());
			pstmt.setString(3, dto.getSalesDate());

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

	// 하나의 데이터 얻어오기
	// 특정 날짜에 해당하는 일매출 반환
	public int getStoreDate(String salesDate, int storeNum) {
		// Dto 객체 선언
		int today_sal = 0; 

		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// Connection Pool에서 Connection 객체 가져오기
			conn = new DbcpBean().getConn();
			// 실행할 SQL 문 작성
			String sql = """
					    SELECT dailySales
					    FROM test_com1_sales
					    WHERE salesDate=? and storeNum=?
					""";
			pstmt = conn.prepareStatement(sql);
			// ? 에 값 바인딩
			pstmt.setString(1, salesDate);
			pstmt.setInt(2, storeNum);

			// SQL 문 실행하고 결과를 ResultSet 객체로 받기
			rs = pstmt.executeQuery();
			if (rs.next()) {
				// Dto 객체 생성 후 값 설정
				today_sal = (int)rs.getInt("dailySales");
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
		return today_sal;
	}

	// list 가져오기
	// 특정 매장의 특정 월매출을 반환 1줄
	public Com1SaleDto getStoreMonth(int storeNum, int year, int month) {
		Com1SaleDto dto = new Com1SaleDto();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = new DbcpBean().getConn();
			String sql = """
					SELECT extract(year from salesDate) AS year, extract(month from salesDate) AS month, storeNum,
					       SUM(dailySales) AS monthlySales
					FROM test_com1_sales
					WHERE storeNum=? AND extract(year from salesDate)=? AND extract(month from salesDate)=?
					GROUP BY extract(year from salesDate), extract(month from salesDate), storeNum
					     """;
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, storeNum);
			pstmt.setInt(2, year);
			pstmt.setInt(3, month);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				dto.setYear(rs.getInt("year"));
				dto.setMonth(rs.getInt("month"));
				dto.setStoreNum(rs.getInt("storenum"));
				dto.setMonthlySales(rs.getInt("monthlySales"));
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
		return dto;
	}

	// 특정 매장의 특정 연매출 반환
	public Com1SaleDto getStoreYear(int storeNum, int year) {
		Com1SaleDto dto = new Com1SaleDto();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = new DbcpBean().getConn();
			String sql = """
					SELECT extract(year from salesDate) AS year, storeNum,
					       SUM(dailySales) AS yearlySales
					FROM test_com1_sales
					WHERE storeNum=? AND extract(year from salesDate)=?
					GROUP BY extract(year from salesDate), storeNum
					ORDER BY yearlySales DESC
					     """;
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, storeNum);
			pstmt.setInt(2, year);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				dto.setYear(rs.getInt("year"));
				dto.setStoreNum(rs.getInt("storeNum"));
				dto.setYearlySales(rs.getInt("yearlySales"));
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
		return dto;
	}

	
	// 모든 매장번호, 일매출, 해당하는 일 반환
	public List<Com1SaleDto> getListAll() {
	    List<Com1SaleDto> list = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	        conn = new DbcpBean().getConn();
	        String sql = """
				SELECT storenum, To_char(salesDate, 'YYYY-MM-DD') salesDate, dailySales
				from test_com1_sales
				order by storenum, salesDate asc
	        """;
	        pstmt = conn.prepareStatement(sql);
	      
	  
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            Com1SaleDto dto = new Com1SaleDto();
	            dto.setSalesDate(rs.getString("salesDate"));
	            dto.setStoreNum(rs.getInt("storeNum"));
	            dto.setDailySales(rs.getInt("dailySales"));
	            
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
	        }
	    }
	    return list;
	}
	
	
	// 매장상관없이 연매출 -> 연도와 매출만 띄움
	public List<Com1SaleDto> getListSalebyYear() {
	    List<Com1SaleDto> list = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	        conn = new DbcpBean().getConn();
	        String sql = """
				SELECT TO_CHAR(salesdate, 'YYYY') AS syear,
	        		    	SUM(dailySales) AS yearlysales
					FROM test_com1_sales
					GROUP BY TO_CHAR(salesdate, 'YYYY')
					order by syear desc
	        """;
	        pstmt = conn.prepareStatement(sql);
	  
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            Com1SaleDto dto = new Com1SaleDto();
	            dto.setSyear(rs.getString("syear"));
	            dto.setYearlySales(rs.getInt("Yearlysales"));
	            
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
	        }
	    }
	    return list;
	}
	
	// 매장상관없이 월매출 -> 연도/월과 매출만 띄움
	public List<Com1SaleDto> getListSalebyMonth() {
	    List<Com1SaleDto> list = new ArrayList<>();
	    Connection conn = null;
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	    try {
	        conn = new DbcpBean().getConn();
	        String sql = """
					SELECT TO_CHAR(salesdate, 'YYYY-MM') AS smonth,
	        		    	SUM(dailySales) AS monthlysales
					FROM test_com1_sales
					GROUP BY TO_CHAR(salesdate, 'YYYY-MM')
					order by smonth desc
	        """;
	        pstmt = conn.prepareStatement(sql);
	  
	        rs = pstmt.executeQuery();
	        while (rs.next()) {
	            Com1SaleDto dto = new Com1SaleDto();
	            dto.setSmonth(rs.getString("smonth"));
	            dto.setMonthlySales(rs.getInt("monthlysales"));
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
	        }
	    }
	    return list;
	}
	
	
	
	// 매장별 전체 일 매출
		public List<Com1SaleDto> getListbyStore(int storenum) {
		    List<Com1SaleDto> list = new ArrayList<>();
		    Connection conn = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    
		    try {
		        conn = new DbcpBean().getConn();
		        String sql = """
					SELECT To_char(salesDate, 'YYYY-MM-DD') sDate, storeNum, dailySales 
					from test_com1_sales
					where storenum=?
					order by storenum, sDate asc
		        """;
		        pstmt = conn.prepareStatement(sql);
		        pstmt.setInt(1,storenum);
		  
		        rs = pstmt.executeQuery();
		        while (rs.next()) {
		            Com1SaleDto dto = new Com1SaleDto();
		            dto.setSdate(rs.getString("sDate"));
		            dto.setStoreNum(rs.getInt("storeNum"));
		            dto.setDailySales(rs.getInt("dailySales"));
		            
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
		        }
		    }
		    return list;
		}
		
		// 선택한 매장의 연도에 따른 월 매출
		public List<Com1SaleDto> getListMonthlybyStore(int storenum) {
		    List<Com1SaleDto> list = new ArrayList<>();
		    Connection conn = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    
		    try {
		        conn = new DbcpBean().getConn();
		        String sql = """
							SELECT TO_CHAR(salesdate, 'YYYY-MM') AS smonth,
	        		    	SUM(dailySales) AS monthlysales
		        		    FROM test_com1_sales
		        		    where storenum =?
		        		    GROUP BY TO_CHAR(salesdate, 'YYYY-MM')
		        		    order by smonth desc
						""";
		        pstmt = conn.prepareStatement(sql);
		        pstmt.setInt(1,storenum);
		  
		        rs = pstmt.executeQuery();
		        while (rs.next()) {
		            Com1SaleDto dto = new Com1SaleDto();
		            dto.setSmonth(rs.getString("smonth"));
		            dto.setMonthlySales(rs.getInt("monthlySales"));
		            
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
		        }
		    }
		    return list;
		}
		
		// 매장별 연매출
		public List<Com1SaleDto> getListYearlybyStore(int storenum) {
			List<Com1SaleDto> list = new ArrayList<>();
		    Connection conn = null;
		    PreparedStatement pstmt = null;
		    ResultSet rs = null;
		    
		    try {
		        conn = new DbcpBean().getConn();
		        String sql = """
					SELECT to_char(salesDate, 'YYYY') syear, sum(dailySales) yearlySales 
					from test_com1_sales
					where storenum=?
					group by to_char(salesDate, 'YYYY')
					order by syear desc
		        """;
		        pstmt = conn.prepareStatement(sql);
		        pstmt.setInt(1,storenum);
		  
		        rs = pstmt.executeQuery();
		        while (rs.next()) {
		            Com1SaleDto dto = new Com1SaleDto();
		            dto.setSyear(rs.getString("syear"));
		            dto.setYearlySales(rs.getInt("yearlySales"));
		            
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
		        }
		    }
		    return list;
		}		
		
		
		// 날짜로 매출 조회
		public List<Com1SaleDto> getListByDate(String date) {
			// Dto 객체 선언
			List<Com1SaleDto> list = new ArrayList<>();
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			try {
				conn = new DbcpBean().getConn();
				
				// 실행할 SQL 문
				String sql = """
						    SELECT * 
						    FROM test_com1_sales
							WHERE SALESDATE = ?
						""";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, date);
				System.out.println(date);
				System.out.println(sql);
				// SQL 문 실행
				rs = pstmt.executeQuery();
				if (rs.next()) {
					Com1SaleDto dto = new Com1SaleDto();
					dto.setSalesDate((rs.getString("salesDate")).substring(0,(rs.getString("salesDate")).indexOf(" ")));
					//dto.setSalesDate(rs.getString("salesDate"));
					dto.setStoreNum(rs.getInt("storenum"));
					dto.setDailySales(rs.getInt("dailySales"));
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
