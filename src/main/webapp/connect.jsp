<%@ page import="java.sql.*" %>
<%! 
    Connection conn = null;
    String message = "";
%>
<%
try {
    Class.forName("oracle.jdbc.driver.OracleDriver");
    conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:XE", "system", "admin");
    message = "Database connection successful!";
    System.out.println("Driver found");
} catch (Exception e) {
    message = "Database connection failed: " + e.getMessage();
    e.printStackTrace();  // Print the stack trace to the server console
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Database Connection</title>
</head>
<body>
    <h2><%= message %></h2>
</body>
</html>
