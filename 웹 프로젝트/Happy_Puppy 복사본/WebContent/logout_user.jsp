<%
session.invalidate();
response.sendRedirect("Main.jsp?error=1");
%>