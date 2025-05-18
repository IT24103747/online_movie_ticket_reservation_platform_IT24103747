package controllers;

import com.google.gson.Gson;
import models.Theatre;
import repositories.FileTheatreRepository;

import javax.servlet.*;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "TheatreServlet", value = "/TheatreServlet")
public class TheatreServlet extends HttpServlet {
    private final TheatreRepository theatreRepository = new FileTheatreRepository();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("list".equals(action)) {
            List<Theatre> theatres = theatreRepository.getAllTheatres();
            sendJsonResponse(response, theatres);
        } else if ("get".equals(action)) {
            String id = request.getParameter("id");
            Theatre theatre = theatreRepository.getTheatreById(id);
            sendJsonResponse(response, theatre);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if (action == null) {
            // Handle JSON request
            try {
                StringBuilder sb = new StringBuilder();
                String line;
                while ((line = request.getReader().readLine()) != null) {
                    sb.append(line);
                }

                JsonRequest jsonRequest = gson.fromJson(sb.toString(), JsonRequest.class);
                action = jsonRequest.action;

                if ("add".equals(action)) {
                    Theatre theatre = gson.fromJson(gson.toJson(jsonRequest.theatre), Theatre.class);
                    boolean success = theatreRepository.addTheatre(theatre);
                    sendJsonResponse(response, new OperationResult(success));
                } else if ("update".equals(action)) {
                    Theatre theatre = gson.fromJson(gson.toJson(jsonRequest.theatre), Theatre.class);
                    boolean success = theatreRepository.updateTheatre(theatre);
                    sendJsonResponse(response, new OperationResult(success));
                } else if ("delete".equals(action)) {
                    String id = jsonRequest.theatre.id;
                    boolean success = theatreRepository.deleteTheatre(id);
                    sendJsonResponse(response, new OperationResult(success));
                } else {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
                }
            } catch (Exception e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid request data");
            }
        } else if ("delete".equals(action)) {
            String id = request.getParameter("id");
            boolean success = theatreRepository.deleteTheatre(id);
            sendJsonResponse(response, new OperationResult(success));
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
        }
    }

    private void sendJsonResponse(HttpServletResponse response, Object data) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(gson.toJson(data));
    }

    // Helper classes for JSON parsing
    private static class JsonRequest {
        String action;
        Theatre theatre;
    }

    private static class OperationResult {
        boolean success;

        OperationResult(boolean success) {
            this.success = success;
        }
    }
}

