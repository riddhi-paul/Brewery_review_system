<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@include file="connect.jsp"%>
<%
try {
    PreparedStatement pst = conn.prepareStatement("INSERT INTO user_detail VALUES (?, ?, ?, ?, ?)");
    pst.setString(1, request.getParameter("n1"));
    pst.setString(2, request.getParameter("n2"));
    pst.setString(3, request.getParameter("n3"));
    pst.setString(4, request.getParameter("n4"));
    pst.setString(5, request.getParameter("n6"));
    int t = pst.executeUpdate();
    if (t > 0)
        out.println("<h1>Registered successfully</h1>");
    	out.println("<p><a href='login.html'>Go to Login Page</a></p>");
    conn.close();
} catch (Exception e) {
    out.println("<h1>Registration failed</h1>");
}
%>
