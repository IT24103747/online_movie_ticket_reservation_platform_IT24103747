<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Theatre Management System</title>
    <link rel="stylesheet" href="theatre.css">
</head>
<body>
<div class="container">
    <header>
        <h1>Theatre Management System</h1>
        <nav>
            <ul>
                <li><a href="#" id="viewTheatres">View Theatres</a></li>
                <li><a href="#" id="addTheatre">Add Theatre</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <section id="theatreListSection" class="active">
            <h2>Theatre List</h2>
            <div id="theatreList"></div>
        </section>

        <section id="addTheatreSection">
            <h2>Add New Theatre</h2>
            <form id="theatreForm">
                <input type="hidden" id="theatreId">
                <div class="form-group">
                    <label for="name">Theatre Name:</label>
                    <input type="text" id="name" name="name" required>
                </div>
                <div class="form-group">
                    <label for="location">Location:</label>
                    <input type="text" id="location" name="location" required>
                </div>
                <div class="form-group">
                    <label for="capacity">Capacity:</label>
                    <input type="number" id="capacity" name="capacity" required>
                </div>
                <div class="form-group">
                    <label for="screens">Number of Screens:</label>
                    <input type="number" id="screens" name="screens" required>
                </div>
                <button type="submit" id="saveBtn">Save Theatre</button>
                <button type="button" id="cancelBtn">Cancel</button>
            </form>
        </section>
    </main>
</div>

<script src="theatre.js"></script>
</body>
</html>
