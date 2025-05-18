package model.servlet;

import model.Reservation;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class AdminViewReservationsServlet extends HttpServlet {
    private String filePath;

    public void init() {
        filePath = getServletContext().getRealPath("/WEB-INF/data/reservations.txt");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Reservation> reservations = new ArrayList<>();
        File file = new File(filePath);

        if (file.exists()) {
            BufferedReader reader = new BufferedReader(new FileReader(file));
            String line;
            while ((line = reader.readLine()) != null) {
                reservations.add(Reservation.fromFileString(line));
            }
            reader.close();
        }

        request.setAttribute("reservations", reservations);
        request.getRequestDispatcher("adminReservations.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
