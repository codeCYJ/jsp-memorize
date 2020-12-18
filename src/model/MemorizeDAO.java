package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import javax.websocket.Session;

public class MemorizeDAO {

	Connection conn;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public void getConn() {

		try {
			Context ctx = new InitialContext();
			Context ctxEnv = (Context)ctx.lookup("java:comp/env");
			DataSource ds = (DataSource)ctxEnv.lookup("jdbc/oracle");
			
			conn = ds.getConnection();
			
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}	// getConn	같은내용. 복사 붙여넣기 가능. DataBase 서버 연결.
	
	public void insert(MemorizeDTO dto) {
		
		getConn();		// 서버연결.
		
		try {
			String sql = "insert into memorize values( memorize_seq.nextval, ?, ?, ?, 0)";	 //no는 시퀀스로 자동 증가
			pstmt = conn.prepareStatement(sql);		 // sql문 삽입.
			pstmt.setString(1, dto.getContent());
			pstmt.setInt(2, dto.getRepeat());
			pstmt.setString(3, dto.getId());	// 속성에 맞는 String 값, int 값 삽입.
			
			pstmt.executeUpdate();				// 변경사항이 있으면 executeUpdate, 불러오기만 할 땐 executeQuery
			
			System.out.println("입력완료");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if(pstmt != null) { pstmt.close(); }
				if(conn != null) { conn.close(); }
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}	// insert
	
	public MemorizeDTO selectOne(String id) {
		
		getConn();
		
		MemorizeDTO dto = null;
		
		try {
			String sql = "select A.* from " + 
					"(select * from memorize where completed = 0 and id = ? order by no asc) A " + 
					"where rownum = 1";
			 // completed 가 0인 항목중 row 중 첫 번째 항목을 불러온다.
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();			// 결과값을 rs에 저장.
			if(rs.next()) {						// rs 다음에 내용이 있을때 불러온다. 다음내용이 없으면 null값이 됨.
				dto = new MemorizeDTO();
				
				dto.setNo(rs.getInt(1));
				dto.setContent(rs.getString(2));
				dto.setRepeat(rs.getInt(3));
				dto.setId(rs.getString(4));
				dto.setCompleted(rs.getInt(5));
			} 
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if(rs != null) { rs.close(); }
				if(pstmt != null) { pstmt.close(); }
				if(conn != null) { conn.close(); }
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return dto;		// dto에 결과값을 돌려준다. viewForm 에서 불러 올 예정.
	}	// selectOne
	
	public void updateCompleted(int no) {
		
		getConn();   // DB 연결
		
		try {
			String sql = "update memorize set completed = 1 where no = ?";
			// no 가 ? 인 row에 completed를 1로 바꾼다. (받아쓰기 일치 시)
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			pstmt.executeUpdate();
			System.out.println("update성공");
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if(pstmt != null) { pstmt.close(); }
				if(conn != null) { conn.close(); }
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}	// update
	
	public MemorizeDTO selectPrev(int no) {
		
		getConn();
		
		MemorizeDTO dto = null;
		
		try {
			String sql = "select * from memorize where no = ?";  // no 에 맞는 모든 리스트를 불러온다.
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto = new MemorizeDTO();
				
				dto.setNo(rs.getInt(1));
				dto.setContent(rs.getString(2));
				dto.setRepeat(rs.getInt(3));
				dto.setId(rs.getString(4));
				dto.setCompleted(rs.getInt(5));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if(rs != null) { rs.close(); }
				if(pstmt != null) { pstmt.close(); }
				if(conn != null) { conn.close(); }
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return dto;
	}	// selectPrev
		
	
	public void update(int no, String content) {
		
		getConn();
		
		try {
			String sql = "update memorize set content = ? where no = ?";		// no가 x 인 content를 수정한다.
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, content);
			pstmt.setInt(2, no);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if(pstmt != null) { pstmt.close(); }
				if(conn != null) { conn.close(); }
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}	// update
	
	public void delete(int no) {
		
		getConn();
		
		try {
			String sql = "delete from memorize where no = ?";  // no 가 x인 항목을 삭제한다.
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, no);
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally{
			try {
				if(pstmt != null) { pstmt.close(); }
				if(conn != null) { conn.close(); }
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
	}	// delete
	
	public int getAllCount() {
		
		// 게시글의 전체 개수를 저장하는 변수
		int count = 0;
		
		getConn();
		
		try {
			String sql = "select count(*) from memorize";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try{
				if(rs != null) { rs.close(); }
				if(pstmt != null) { pstmt.close(); }
				if(conn != null) { conn.close(); }
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		return count;
	}	// getAllCount
	
	
	// 게시글 전체 data 를 반환하는 메소드
	public ArrayList<MemorizeDTO> selectAll(int startRow, int endRow){
		
		ArrayList<MemorizeDTO> list = new ArrayList<>();
		
		getConn();
		
		try {
			String sql ="select * from " + 
	  				"(select A.*, rownum as rnum from " + 
	  				"(select * from memorize order by no asc) A) " + 
	  				"where rnum >= ? and rnum <= ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startRow);
		    pstmt.setInt(2, endRow);
		    // pstmt.setInt(2, endRow);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemorizeDTO dto = new MemorizeDTO();
				dto.setNo(rs.getInt(1));
				dto.setContent(rs.getString(2));
				dto.setRepeat(rs.getInt(3));
				dto.setId(rs.getString(4));
				dto.setCompleted(rs.getInt(5));
				
				list.add(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try{
				if(rs != null) { rs.close(); }
				if(pstmt != null) { pstmt.close(); }
				if(conn != null) { conn.close(); }
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		return list;
	}	// selectOnePage
	
	// 나의 게시글 전체 data 를 반환하는 메소드
	public ArrayList<MemorizeDTO> selectMine(int startRow, int endRow, String id){
		
		ArrayList<MemorizeDTO> list = new ArrayList<>();
		
		getConn();
		
		try {
			String sql ="select * from " + 
	  				"(select A.*, rownum as rnum from " + 
	  				"(select * from memorize where id = ? order by no asc) A) " + 
	  				"where rnum >= ? and rnum <= ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setInt(2, startRow);
		    pstmt.setInt(3, endRow);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemorizeDTO dto = new MemorizeDTO();
				dto.setNo(rs.getInt(1));
				dto.setContent(rs.getString(2));
				dto.setRepeat(rs.getInt(3));
				dto.setId(rs.getString(4));
				dto.setCompleted(rs.getInt(5));
				
				list.add(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			try{
				if(rs != null) { rs.close(); }
				if(pstmt != null) { pstmt.close(); }
				if(conn != null) { conn.close(); }
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		return list;
	}	// selectMine
	
}
