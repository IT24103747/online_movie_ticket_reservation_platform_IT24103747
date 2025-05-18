package services;

import jakarta.servlet.ServletContext;

public class FileHandler {
    private final String name = "CineStar";
    private final ServletContext servletContext;

    public FileHandler(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    public String getName() {
        return name;
    }
}
