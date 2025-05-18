<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Reserve Ticket</title>
</head>
<body>
<h2>Reserve Your Ticket</h2>
<form action="ReserveTicketServlet" method="post">
    <label>Name:</label>
    <input type="text" name="userName" required /><br/>

    <label>Movie:</label>
    <input type="text" name="movie" required /><br/>

    <label>Show Time:</label>
    <input type="text" name="showTime" required /><br/>

    <label>Seats:</label>
    <input type="number" name="seats" min="1" required /><br/>

    <input type="submit" value="Reserve"/>
</form>
</body>
</html>
