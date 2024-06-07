<%@ page import="java.sql.*"%>
<%@ include file="connect.jsp" %>
<%
String name = request.getParameter("text1");
String password = request.getParameter("text2");
try {
    PreparedStatement pst = conn.prepareStatement("SELECT * FROM user_detail WHERE name = ? AND password = ?");
    pst.setString(1, name);
    pst.setString(2, password);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
        session.setAttribute("name", name);
        response.sendRedirect("search.jsp");
    } else {
        out.println("Invalid credentials. <a href='login.html'>Try again</a>");
    }
} catch (Exception e) {
    out.println("Database connectivity error: " + e.getMessage());
}
%>
