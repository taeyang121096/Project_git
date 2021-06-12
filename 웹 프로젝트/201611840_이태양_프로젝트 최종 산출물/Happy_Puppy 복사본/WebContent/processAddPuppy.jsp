<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ include file="dbconn.jsp"%>

<%
	request.setCharacterEncoding("utf-8");
 

String filename = "";
String realFolder = "///Users/taeyang/git/happy/Happy_Puppy/WebContent/resources/images";
int maxSize = 5 * 1024 * 1024;
String encType = "utf-8";

MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
String Id = multi.getParameter("Id");
String name = multi.getParameter("name");
String allergy = multi.getParameter("allergy");

String feed = multi.getParameter("feed");
String birth = multi.getParameter("birth");
String age = multi.getParameter("age");
String sex = multi.getParameter("sex");
String heart_rate = multi.getParameter("heart_rate");
String weight = multi.getParameter("weight");
String sleep = multi.getParameter("sleep");
String walk_time = multi.getParameter("walk_time");
String bath = multi.getParameter("bath");

Integer heart;

if (heart_rate.isEmpty())
	heart = 0;
else
	heart = Integer.valueOf(heart_rate);



Integer sleep1;

if (sleep.isEmpty())
	sleep1 = 0;
else
	sleep1 = Integer.valueOf(sleep);

Integer walk;

if (walk_time.isEmpty())
	walk = 0;
else
	walk = Integer.valueOf(walk_time);

Integer bath1;

if (bath.isEmpty())
	bath1 = 0;
else
	bath1 = Integer.valueOf(bath);

Enumeration files = multi.getFileNames();
String fname = (String) files.nextElement();
String fileName = multi.getFilesystemName(fname);

PreparedStatement pstmt = null;

String sql = "insert into puppydb values(?,?,?,?,?,?,?,?,?,?,?,?,?)";

pstmt = conn.prepareStatement(sql);
pstmt.setString(1, Id);
pstmt.setString(2, name);
pstmt.setString(3, age);
pstmt.setString(4, sex);
pstmt.setString(5, birth);
pstmt.setString(6, weight);
pstmt.setInt(7, walk);
pstmt.setInt(8, bath1);
pstmt.setInt(9, sleep1);
pstmt.setString(10, feed);
pstmt.setString(11, allergy);
pstmt.setInt(12, heart);
pstmt.setString(13, fileName);
pstmt.executeUpdate();

if (pstmt != null)
	pstmt.close();
if (conn != null)
	conn.close();

response.sendRedirect("Main_user.jsp");
%>