package model.servlet;

import model.Reservation;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class ReserveTicketServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userName = request.getParameter("userName");
        String movie = request.getParameter("movie");
        String showTime = request.getParameter("showTime");
        int seats = Integer.parseInt(request.getParameter("seats"));
        String paymentSlip = request.getParameter("paymentSlip");
        String status = "pending";
        String filePath = getServletContext().getRealPath("/WEB-INF/data/reservations.txt");

        int nextId = 1;
        List<Reservation> reservations = new ArrayList<>();
        File file = new File(filePath);

        if (file.exists()) {
            BufferedReader reader = new BufferedReader(new FileReader(file));
            String line;
            while ((line = reader.readLine()) != null) {
                Reservation r = Reservation.fromFileString(line);
                reservations.add(r);
                if (r.getId() >= nextId) {
                    nextId = r.getId() + 1;
                }
            }
            reader.close();
        }

        Reservation newReservation = new Reservation(nextId, userName, movie, showTime, seats, status, paymentSlip);
        reservations.add(newReservation);

        BufferedWriter writer = new BufferedWriter(new FileWriter(file, false));
        for (Reservation r : reservations) {
            writer.write(r.toFileString());
            writer.newLine();
        }
        writer.close();

        response.sendRedirect("reserveTicketSuccess.jsp");
    }
}
