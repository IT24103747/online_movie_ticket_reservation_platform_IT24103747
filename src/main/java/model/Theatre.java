package model;

import java.io.Serializable;

public class Theatre implements Serializable {
    private String id;
    private String name;
    private String location;
    private int capacity;
    private int screens;

    public Theatre() {
    }

    public Theatre(String id, String name, String location, int capacity, int screens) {
        this.id = id;
        this.name = name;
        this.location = location;
        this.capacity = capacity;
        this.screens = screens;
    }

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public int getScreens() {
        return screens;
    }

    public void setScreens(int screens) {
        this.screens = screens;
    }

    @Override
    public String toString() {
        return "Theatre{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", location='" + location + '\'' +
                ", capacity=" + capacity +
                ", screens=" + screens +
                '}';
    }
}

