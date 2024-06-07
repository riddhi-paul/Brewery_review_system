<%@ page import="java.sql.*, java.net.*, java.io.*, org.json.*" %>
<%@ include file="connect.jsp" %>
<!DOCTYPE HTML>
<html>
<head>
<title>Search Results</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<h1>Search Results</h1>
<form action="search_result.jsp" method="GET">
    <label for="state">State:</label>
    <input type="text" id="state" name="state">
    <button type="submit">Search</button>
</form>

<%
String state = request.getParameter("state");
if (state != null) { // Check if state parameter is not null
    String apiUrl = "https://api.openbrewerydb.org/breweries?by_state=" + URLEncoder.encode(state, "UTF-8");
    try {
        URL url = new URL(apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String inputLine;
        StringBuffer responseBody = new StringBuffer(); // Rename the variable to avoid duplication
        while ((inputLine = in.readLine()) != null) {
            responseBody.append(inputLine);
        }
        in.close();
        JSONArray breweries = new JSONArray(responseBody.toString());
        for (int i = 0; i < breweries.length(); i++) {
            JSONObject brewery = breweries.getJSONObject(i);
%>
        <div>
            <h2><a href="brewery.jsp?id=<%=URLEncoder.encode(brewery.getString("id"), "UTF-8")%>"><%=brewery.getString("name")%></a></h2>

            <p>Address: <%=brewery.getString("street")%>, <%=brewery.getString("city")%>, <%=brewery.getString("state")%></p>
            <p>Phone: <%=brewery.optString("phone", "N/A")%></p>
            <p>Website: <a href="<%=brewery.optString("website_url", "#")%>"><%=brewery.optString("website_url", "N/A")%></a></p>
            <!-- Add rating if available -->
        </div>
<%
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
} else {
    out.println("State parameter is missing.");
}
%>
</body>
</html>
