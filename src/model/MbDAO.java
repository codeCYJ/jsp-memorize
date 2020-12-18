package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MbDAO {

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
	}	// getConn
	
	public void insert(String id, String pw) {
		
		getConn();
		
		try {
			String sql = "insert into mb values(?, ?)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			pstmt.executeUpdate();
			System.out.println("회원가입완료");
			
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
	
	public boolean compareId(String id) {
		
		boolean existId = false;
		
		getConn();
		
		try {
			String sql = "select * from mb where id = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			
			
			if(rs.next()) {
				System.out.println("id = " + rs.getString(1));
				existId = true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return existId;  
	} // compareId  -- true 면 해당 id가 있다. (회원가입 불가능)
	
	public boolean comparePw(String id, String pw) {
		
		boolean comparePw = false;
		
		getConn();
		
		try {
			String sql = "select pw from mb where id = ?";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				String pwDB = rs.getString(1);
				
				if(pwDB.equals(pw)) {
					comparePw = true;
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return comparePw;
	}	// comparePw  -- true 면 해당 비밀번호가 맞다. (로그인 가능)
}
