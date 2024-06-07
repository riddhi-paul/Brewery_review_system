<%@ page import="java.sql.*" %>
<%@ include file="connect.jsp" %>
<%
String breweryId = request.getParameter("brewery_id");
int rating = Integer.parseInt(request.getParameter("rating"));
String description = request.getParameter("description");
String muid = (String) session.getAttribute("muid");

if (breweryId != null && muid != null) { // Check if required fields are present
    try {
    	PreparedStatement pst = conn.prepareStatement("INSERT INTO brewery_review (brewery_id, muid, rating, description) VALUES (?, ?, ?, ?)");
    	pst.setString(1, breweryId);
    	pst.setString(2, muid);
    	pst.setInt(3, rating);
    	pst.setString(4, description);

        int rowsAffected = pst.executeUpdate();
        if (rowsAffected > 0) {
            response.sendRedirect("brewery.jsp?id=" + breweryId);
        } else {
            // Error handling if the review couldn't be added
            out.println("Error adding review.");
        }
    } catch (Exception e) {
        // Error handling for database errors
        out.println("Error: " + e.getMessage());
    }
} else {
    // Error handling if required fields are missing
    response.sendRedirect("error.jsp?message=A required field is missing.");
}
%>
