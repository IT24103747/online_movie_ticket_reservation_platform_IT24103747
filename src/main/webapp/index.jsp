<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="org.json.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CineStar - Premium Movie Experience</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
<!-- Header with Logo -->
<header class="header">
    <h1 class="logo">CineStar</h1>
</header>

<div class="main-container">
    <!-- Customer Support Section -->
    <section class="section">
        <h2 class="section-title">Customer Support</h2>
        <% if (request.getAttribute("message") != null) { %>
        <div class="message success">
            <%= request.getAttribute("message") %>
        </div>
        <% } %>
        <form action="CustomerSupportServlet" method="post">
            <div class="form-group">
                <label for="name">Name</label>
                <input type="text" id="name" name="name" required placeholder="Enter your name">
            </div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" id="email" name="email" required placeholder="Enter your email">
            </div>
            <div class="form-group">
                <label for="issueType">Issue Type</label>
                <select id="issueType" name="issueType" required>
                    <option value="">Select an issue type</option>
                    <option value="booking">Booking Issue</option>
                    <option value="technical">Technical Problem</option>
                    <option value="feedback">General Feedback</option>
                    <option value="other">Other</option>
                </select>
            </div>
            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description" rows="4" required
                          placeholder="Please describe your issue or feedback"></textarea>
            </div>
            <button type="submit" class="submit-btn">Submit</button>
        </form>
    </section>

    <!-- Feedback Section -->
    <section class="section">
        <h2 class="section-title">Movie Feedback</h2>
        <form action="FeedbackServlet" method="post">
            <div class="form-group">
                <label for="movieName">Movie Name</label>
                <input type="text" id="movieName" name="movieName" required placeholder="Enter movie name">
            </div>
            <div class="form-group">
                <label for="rating">Rating</label>
                <select id="rating" name="rating" required>
                    <option value="">Select rating</option>
                    <option value="5">⭐⭐⭐⭐⭐ Excellent</option>
                    <option value="4">⭐⭐⭐⭐ Very Good</option>
                    <option value="3">⭐⭐⭐ Good</option>
                    <option value="2">⭐⭐ Fair</option>
                    <option value="1">⭐ Poor</option>
                </select>
            </div>
            <div class="form-group">
                <label for="comments">Comments</label>
                <textarea id="comments" name="comments" rows="4" required
                          placeholder="Share your thoughts about the movie"></textarea>
            </div>
            <button type="submit" class="submit-btn">Submit Feedback</button>
        </form>
    </section>

    <!-- Display Sections -->
    <div class="display-sections">
        <section class="section reviews-section">
            <h2 class="section-title">Recent Movie Reviews</h2>
            <div class="reviews-grid">
                <%
                    try {
                        String feedbackPath = application.getRealPath("/data/feedback.txt");
                        BufferedReader reader = new BufferedReader(new FileReader(feedbackPath));
                        StringBuilder jsonContent = new StringBuilder();
                        String line;
                        while ((line = reader.readLine()) != null) {
                            jsonContent.append(line);
                        }
                        reader.close();

                        JSONArray feedbacks = new JSONArray(jsonContent.toString());
                        for (int i = 0; i < feedbacks.length(); i++) {
                            JSONObject feedback = feedbacks.getJSONObject(i);
                %>
                <div class="review-card">
                    <h3 class="movie-title"><%= feedback.getString("movieName") %></h3>
                    <div class="rating">
                        <% for(int j = 0; j < feedback.getInt("rating"); j++) { %>
                        ⭐
                        <% } %>
                    </div>
                    <p class="review-text"><%= feedback.getString("comments") %></p>
                    <div class="review-date">
                        <%= feedback.getString("createdAt") %>
                    </div>
                </div>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<p class='error-message'>Error loading reviews: " + e.getMessage() + "</p>");
                    }
                %>
            </div>
        </section>

        <section class="section support-queries-section">
            <h2 class="section-title">Recent Support Queries</h2>
            <div class="queries-grid">
                <%
                    try {
                        String supportPath = application.getRealPath("/data/customerSupport.txt");
                        BufferedReader reader = new BufferedReader(new FileReader(supportPath));
                        StringBuilder jsonContent = new StringBuilder();
                        String line;
                        while ((line = reader.readLine()) != null) {
                            jsonContent.append(line);
                        }
                        reader.close();

                        JSONArray queries = new JSONArray(jsonContent.toString());
                        for (int i = 0; i < queries.length(); i++) {
                            JSONObject query = queries.getJSONObject(i);
                %>
                <div class="query-card">
                    <div class="query-header">
                        <h3 class="query-type"><%= query.getString("issueType") %></h3>
                        <span class="status <%= query.getString("status").toLowerCase().replace(" ", "-") %>">
                                    <%= query.getString("status") %>
                                </span>
                    </div>
                    <p class="query-text"><%= query.getString("description") %></p>
                    <div class="query-info">
                        <span class="query-by">By: <%= query.getString("name") %></span>
                        <span class="query-date"><%= query.getString("createdAt") %></span>
                    </div>
                </div>
                <%
                        }
                    } catch (Exception e) {
                        out.println("<p class='error-message'>Error loading support queries: " + e.getMessage() + "</p>");
                    }
                %>
            </div>
        </section>
    </div>
</div>

<div class="theater">
    <!-- Side Curtains -->
    <div class="curtain curtain-left"></div>
    <div class="curtain curtain-right"></div>

    <!-- Ambient Lighting -->
    <div class="ambient-light"></div>

    <!-- Seating Area -->
    <div class="seating-area">
        <%
            String[] rows = {"A", "B", "C", "D", "E", "F", "G"};
            int seatsPerRow = 12;

            for(String row : rows) {
        %>
        <div class="row">
            <% for(int i = 1; i <= seatsPerRow; i++) { %>
            <div class="seat" title="<%= row + i %>"></div>
            <% if(i == seatsPerRow/2) { %>
            <div style="width: 50px;"></div> <!-- Aisle space -->
            <% } %>
            <% } %>
        </div>
        <% } %>
    </div>
</div>

<script>
    // Add interactivity to seats
    document.querySelectorAll('.seat').forEach(seat => {
        seat.addEventListener('click', () => {
            if (!seat.classList.contains('occupied')) {
                seat.classList.toggle('selected');
            }
        });
    });
</script>
</body>
</html>