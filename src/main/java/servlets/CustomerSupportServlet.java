package servlets;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import org.json.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/CustomerSupportServlet")
public class CustomerSupportServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Read existing data
            String filePath = getServletContext().getRealPath("/data/customerSupport.txt");
            BufferedReader reader = new BufferedReader(new FileReader(filePath));
            StringBuilder jsonContent = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                jsonContent.append(line);
            }
            reader.close();

            // Parse existing JSON array
            JSONArray queries = new JSONArray(jsonContent.toString());

            // Create new query object
            JSONObject newQuery = new JSONObject();
            newQuery.put("name", request.getParameter("name"));
            newQuery.put("email", request.getParameter("email"));
            newQuery.put("issueType", request.getParameter("issueType"));
            newQuery.put("description", request.getParameter("description"));
            newQuery.put("status", "Pending");
            newQuery.put("createdAt", LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));

            // Add new query to array
            queries.put(newQuery);

            // Write updated JSON back to file
            FileWriter writer = new FileWriter(filePath);
            writer.write(queries.toString(4)); // Use indent of 4 spaces for pretty printing
            writer.close();

            request.setAttribute("message", "Your support query has been submitted successfully!");

        } catch (Exception e) {
            request.setAttribute("message", "Error submitting your query: " + e.getMessage());
        }

        // Redirect back to the main page
        RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
        dispatcher.forward(request, response);
    }
} 


