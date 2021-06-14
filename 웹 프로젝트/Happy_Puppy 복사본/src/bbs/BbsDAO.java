package bbs;

import java.sql.*;

import java.sql.DriverManager;

import java.sql.PreparedStatement;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class BbsDAO {

	private Connection conn;

	private ResultSet rs;

	public BbsDAO() {

		try {
			String url = "jdbc:mysql://localhost:3306/HappyPuppy";
			String user = "root";
			String password = "admin1234";
			try {
				Class.forName("com.mysql.jdbc.Driver");
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			conn = DriverManager.getConnection(url, user, password);
		} catch (SQLException ex) {
			System.out.println("데이터베이스 연결이 실패했습니다.<br>");
		}

	}

	public String getDate() {

		String SQL = "SELECT NOW()";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				return rs.getString(1);

			}

		} catch (Exception e) {

			e.printStackTrace();

		}

		

		return "";
	}

	public int getNext() {

		String SQL = "SELECT bbsID FROM Board ORDER BY bbsID DESC";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				return rs.getInt(1) + 1;

			}

			return 1;
		} catch (Exception e) {

			e.printStackTrace();

		}
	
			

		return -1;
	}

	public int write(String bbsTitle, String userID, String bbsContent) {

		String SQL = "INSERT INTO Board VALUES(?, ?, ?, ?, ?, ?);";

		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			// pstmt.setString(4, getDate());

			java.util.Date utilDate = new java.util.Date();
			java.sql.Timestamp sqlDate = new java.sql.Timestamp(utilDate.getTime());
			pstmt.setTimestamp(4, sqlDate);

			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);

			return pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("userID:" + userID);
			System.out.println(bbsTitle);
			System.out.println(userID);
			System.out.println(bbsContent);

			e.printStackTrace();
		}
		
		return -1;
	}

	public ArrayList<Bbs> getList(int pageNumber) {

		String SQL = "SELECT * FROM Board WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";

		ArrayList<Bbs> list = new ArrayList<Bbs>();

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);

			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);

			rs = pstmt.executeQuery();

			while (rs.next()) {

				Bbs bbs = new Bbs();

				bbs.setBbsID(rs.getInt(1));

				bbs.setBbsTitle(rs.getString(2));

				bbs.setUserID(rs.getString(3));

				bbs.setBbsDate(rs.getString(4));

				bbs.setBbsContent(rs.getString(5));

				bbs.setBbsAvailable(rs.getInt(6));

				list.add(bbs);

			}

		} catch (Exception e) {

			e.printStackTrace();

		}
		

		return list;

	}

	public boolean nextPage(int pageNumber) {

		String SQL = "SELECT * FROM Board WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";

		ArrayList<Bbs> list = new ArrayList<Bbs>();

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);

			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				return true;

			}

		} catch (Exception e) {

			e.printStackTrace();

		}


		return false;

	}

	public Bbs getBbs(int bbsID) {

		String SQL = "SELECT * FROM Board WHERE bbsID = ?";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);

			pstmt.setInt(1, bbsID);

			rs = pstmt.executeQuery();

			if (rs.next()) {

				Bbs bbs = new Bbs();

				bbs.setBbsID(rs.getInt(1));

				bbs.setBbsTitle(rs.getString(2));

				bbs.setUserID(rs.getString(3));

				bbs.setBbsDate(rs.getString(4));

				bbs.setBbsContent(rs.getString(5));

				bbs.setBbsAvailable(rs.getInt(6));

				return bbs;

			}

		} catch (Exception e) {

			e.printStackTrace();

		}


		return null;

	}

	public int update(int bbsID, String bbsTitle, String bbsContent) {

		String SQL = "UPDATE Board SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);

			pstmt.setString(1, bbsTitle);

			pstmt.setString(2, bbsContent);

			pstmt.setInt(3, bbsID);

			return pstmt.executeUpdate();

		} catch (Exception e) {

			e.printStackTrace();

		}
	

		return -1;

	}

	public int delete(int bbsID) {

		String SQL = "delete from Board where bbsID = ?";

		try {

			PreparedStatement pstmt = conn.prepareStatement(SQL);

			pstmt.setInt(1, bbsID);

			return pstmt.executeUpdate();

		} catch (Exception e) {

			e.printStackTrace();

		}
		

		return -1;

	}

}
