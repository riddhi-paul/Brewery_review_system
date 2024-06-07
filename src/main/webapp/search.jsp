<%@ page import="java.sql.*" %>
<%@include file="connect.jsp" %>
<!DOCTYPE HTML>
<html>
<head>
<title>Search Breweries</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<form name="form1" method="post" action="search_result.jsp">
  <p>Search by City: <input type="text" name="city"></p>
  <p>Search by Name: <input type="text" name="name"></p>
  <p>Search by Type: 
    <select name="type">
      <option value="micro">Micro</option>
      <option value="large">Large</option>
      <option value="brewpub">Brewpub</option>
      <option value="planning">Planning</option>
      <option value="bar">Bar</option>
      <option value="contract">Contract</option>
      <option value="proprietor">Proprietor</option>
      <option value="closed">Closed</option>
    </select>
  </p>
  <p><input type="submit" name="SEARCH" value="SEARCH"></p>
</form>
</body>
</html>
