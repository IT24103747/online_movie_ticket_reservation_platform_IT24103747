package model;

public class Reservation {
    private int id;
    private String userName;
    private String movie;
    private String showTime;
    private int seats;
    private String status;
    private String paymentSlip;

    public Reservation(int id, String userName, String movie, String showTime, int seats, String status, String paymentSlip) {
        this.id = id;
        this.userName = userName;
        this.movie = movie;
        this.showTime = showTime;
        this.seats = seats;
        this.status = status;
        this.paymentSlip = paymentSlip;
    }

    // Getters and setters
    public int getId() { return id; }
    public String getUserName() { return userName; }
    public String getMovie() { return movie; }
    public String getShowTime() { return showTime; }
    public int getSeats() { return seats; }
    public String getStatus() { return status; }
    public String getPaymentSlip() { return paymentSlip; }
    public void setStatus(String status) { this.status = status; }
    public void setPaymentSlip(String paymentSlip) { this.paymentSlip = paymentSlip; }

    // Static method to parse from file string
    public static Reservation fromFileString(String line) {
        // Split on unescaped pipes
        String[] parts = line.split("(?<!\\\\)\\|");
        for (int i = 0; i < parts.length; i++) {
            parts[i] = parts[i].replace("\\|", "|"); // Unescape pipes
        }
        return new Reservation(
                Integer.parseInt(parts[0]),
                parts[1],
                parts[2],
                parts[3],
                Integer.parseInt(parts[4]),
                parts[5],
                parts.length > 6 ? parts[6] : ""
        );
    }

    // Method to convert to file string, escaping pipes in paymentSlip
    public String toFileString() {
        return id + "|" + userName + "|" + movie + "|" + showTime + "|" + seats + "|" + status + "|" + (paymentSlip != null ? paymentSlip.replace("|", "\\|") : "");
    }
}
