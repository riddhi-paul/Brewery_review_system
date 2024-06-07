<%@ page import="java.sql.*, java.net.*, java.io.*, org.json.*" %>
<%@ include file="connect.jsp" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>Brewery Information</title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<%
String breweryId = request.getParameter("id");
if (breweryId != null) { // Check if breweryId parameter is not null
    try {
        // Fetch brewery information from the API
        String apiUrl = "https://api.openbrewerydb.org/breweries/" + breweryId;
        URL url = new URL(apiUrl);
        HttpURLConnection connApi = (HttpURLConnection) url.openConnection();
        connApi.setRequestMethod("GET");
        BufferedReader inApi = new BufferedReader(new InputStreamReader(connApi.getInputStream()));
        String inputLine;
        StringBuffer breweryResponse = new StringBuffer();
        while ((inputLine = inApi.readLine()) != null) {
            breweryResponse.append(inputLine);
        }
        inApi.close();
        JSONObject brewery = new JSONObject(breweryResponse.toString());
        
        // Display brewery information
        out.println("<h1>" + brewery.getString("name") + "</h1>");
        // Check if the "street" field exists and is not null in the JSON response
        if (brewery.has("street") && !brewery.isNull("street")) {
            out.println("<p>Address: " + brewery.getString("street") + ", " + brewery.getString("city") + ", " + brewery.getString("state") + "</p>");
        } else {
            out.println("<p>Address: N/A, " + brewery.getString("city") + ", " + brewery.getString("state") + "</p>");
        }

        out.println("<p>Phone: " + brewery.optString("phone", "N/A") + "</p>");
        out.println("<p>Website: <a href='" + brewery.optString("website_url", "#") + "'>" + brewery.optString("website_url", "N/A") + "</a></p>");
        
        // Fetch existing reviews from the database
        PreparedStatement pstReviews = conn.prepareStatement("SELECT * FROM brewery_review WHERE brewery_id = ?");
        pstReviews.setString(1, breweryId);
        ResultSet rsReviews = pstReviews.executeQuery();
        out.println("<h2>Reviews</h2>");
        while (rsReviews.next()) {
            out.println("<p>Rating: " + rsReviews.getInt("rating") + "/5</p>");
            out.println("<p>Description: " + rsReviews.getString("description") + "</p>");
            out.println("<hr>");
        }
        rsReviews.close();
        pstReviews.close();
        
        // Add review form
        out.println("<h2>Add a Review</h2>");
        out.println("<form method='post' action='add_review.jsp'>");
        out.println("<input type='hidden' name='brewery_id' value='" + breweryId + "'>");
        out.println("<p>Rating (1-5): <input type='number' name='rating' min='1' max='5'></p>");
        out.println("<p>Description: <textarea name='description'></textarea></p>");
        out.println("<p><input type='submit' value='Submit'></p>");
        out.println("</form>");
        
        // Close resources
        connApi.disconnect();
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
} else {
    out.println("Brewery ID parameter is missing.");
}
%>
</body>
</html>
