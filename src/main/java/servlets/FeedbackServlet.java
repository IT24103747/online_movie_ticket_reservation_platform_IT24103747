package servlets;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import org.json.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/FeedbackServlet")
public class FeedbackServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Read existing data
            String filePath = getServletContext().getRealPath("/data/feedback.txt");
            BufferedReader reader = new BufferedReader(new FileReader(filePath));
            StringBuilder jsonContent = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                jsonContent.append(line);
            }
            reader.close();

            // Parse existing JSON array
            JSONArray feedbacks = new JSONArray(jsonContent.toString());

            // Create new feedback object
            JSONObject newFeedback = new JSONObject();
            newFeedback.put("movieName", request.getParameter("movieName"));
            newFeedback.put("rating", Integer.parseInt(request.getParameter("rating")));
            newFeedback.put("comments", request.getParameter("comments"));
            newFeedback.put("createdAt", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));

            // Add new feedback to array
            feedbacks.put(newFeedback);

            // Write updated JSON back to file
            FileWriter writer = new FileWriter(filePath);
            writer.write(feedbacks.toString(4)); // Use indent of 4 spaces for pretty printing
            writer.close();

            request.setAttribute("message", "Your feedback has been submitted successfully!");

        } catch (Exception e) {
            request.setAttribute("message", "Error submitting your feedback: " + e.getMessage());
        }

        // Redirect back to the main page
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
    }
} 
