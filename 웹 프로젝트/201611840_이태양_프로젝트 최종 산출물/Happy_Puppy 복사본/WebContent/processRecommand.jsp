<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
 


String walk = request.getParameter("walk");
String bath = request.getParameter("bath");
String how =request.getParameter("how");

String veg = request.getParameter("veg");
String fru = request.getParameter("fru");



PreparedStatement pstmt = null;

String sql = "insert into recommand values(?,?,?,?,?)";

pstmt = conn.prepareStatement(sql);
pstmt.setString(1, walk);
pstmt.setString(2, bath);
pstmt.setString(3, how);
pstmt.setString(4, veg);
pstmt.setString(5, fru);

pstmt.executeUpdate();

if (pstmt != null)
	pstmt.close();
if (conn != null)
	conn.close();

response.sendRedirect("Main_admin.jsp");
%>