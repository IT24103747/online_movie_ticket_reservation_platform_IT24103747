package repositories;

import models.Theatre;
import utils.FileUtils;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

    public class TheatreRepository {
        private static final String FILE_PATH = "data/theatres.txt";
        private final FileUtils fileUtils;

        public TheatreRepository() {
            this.fileUtils = new FileUtils();
            initializeFile();
        }

        private void initializeFile() {
            try {
                File file = new File(FILE_PATH);
                if (!file.exists()) {
                    file.getParentFile().mkdirs();
                    file.createNewFile();
                    // Add some sample data if needed
                    addSampleTheatres();
                }
            } catch (IOException e) {
                System.err.println("Error initializing theatres file: " + e.getMessage());
            }
        }

        private void addSampleTheatres() {
            List<Theatre> sampleTheatres = List.of(
                    new Theatre(UUID.randomUUID().toString(), "Cineplex", "Downtown", 500, 5),
                    new Theatre(UUID.randomUUID().toString(), "IMAX Theatre", "Midtown", 300, 3),
                    new Theatre(UUID.randomUUID().toString(), "Royal Cinemas", "Uptown", 450, 4)
            );

            for (Theatre theatre : sampleTheatres) {
                addTheatre(theatre);
            }
        }

        public List<Theatre> getAllTheatres() {
            List<Theatre> theatres = new ArrayList<>();
            try {
                List<String> lines = fileUtils.readLines(FILE_PATH);
                for (String line : lines) {
                    if (!line.trim().isEmpty()) {
                        Theatre theatre = parseTheatre(line);
                        if (theatre != null) {
                            theatres.add(theatre);
                        }
                    }
                }
            } catch (IOException e) {
                System.err.println("Error reading theatres: " + e.getMessage());
            }
            return theatres;
        }

        public Theatre getTheatreById(String id) {
            try {
                List<String> lines = fileUtils.readLines(FILE_PATH);
                for (String line : lines) {
                    if (!line.trim().isEmpty()) {
                        Theatre theatre = parseTheatre(line);
                        if (theatre != null && theatre.getId().equals(id)) {
                            return theatre;
                        }
                    }
                }
            } catch (IOException e) {
                System.err.println("Error finding theatre: " + e.getMessage());
            }
            return null;
        }

        public boolean addTheatre(Theatre theatre) {
            try {
                if (theatre.getId() == null || theatre.getId().isEmpty()) {
                    theatre.setId(UUID.randomUUID().toString());
                }
                String line = convertTheatreToLine(theatre);
                fileUtils.appendLine(FILE_PATH, line);
                return true;
            } catch (IOException e) {
                System.err.println("Error adding theatre: " + e.getMessage());
                return false;
            }
        }

        public boolean updateTheatre(Theatre updatedTheatre) {
            List<Theatre> theatres = getAllTheatres();
            boolean found = false;

            for (int i = 0; i < theatres.size(); i++) {
                if (theatres.get(i).getId().equals(updatedTheatre.getId())) {
                    theatres.set(i, updatedTheatre);
                    found = true;
                    break;
                }
            }

            if (!found) {
                return false;
            }

            try {
                List<String> lines = convertTheatresToLines(theatres);
                fileUtils.writeLines(FILE_PATH, lines);
                return true;
            } catch (IOException e) {
                System.err.println("Error updating theatre: " + e.getMessage());
                return false;
            }
        }

        public boolean deleteTheatre(String id) {
            List<Theatre> theatres = getAllTheatres();
            boolean removed = theatres.removeIf(theatre -> theatre.getId().equals(id));

            if (!removed) {
                return false;
            }

            try {
                List<String> lines = convertTheatresToLines(theatres);
                fileUtils.writeLines(FILE_PATH, lines);
                return true;
            } catch (IOException e) {
                System.err.println("Error deleting theatre: " + e.getMessage());
                return false;
            }
        }

        private Theatre parseTheatre(String line) {
            try {
                String[] parts = line.split("\\|");
                if (parts.length == 5) {
                    return new Theatre(
                            parts[0], // id
                            parts[1], // name
                            parts[2], // location
                            Integer.parseInt(parts[3]), // capacity
                            Integer.parseInt(parts[4])  // screens
                    );
                }
            } catch (Exception e) {
                System.err.println("Error parsing theatre line: " + line);
            }
            return null;
        }

        private String convertTheatreToLine(Theatre theatre) {
            return String.join("|",
                    theatre.getId(),
                    theatre.getName(),
                    theatre.getLocation(),
                    String.valueOf(theatre.getCapacity()),
                    String.valueOf(theatre.getScreens())
            );
        }

        private List<String> convertTheatresToLines(List<Theatre> theatres) {
            List<String> lines = new ArrayList<>();
            for (Theatre theatre : theatres) {
                lines.add(convertTheatreToLine(theatre));
            }
            return lines;
        }
    }

