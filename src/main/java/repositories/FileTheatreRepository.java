package repositories;

import models.Theatre;
import utils.FileUtils;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

    public class FileTheatreRepository implements TheatreRepository {
        private static final String FILE_PATH = "data/theatres.txt";
        private final FileUtils fileUtils;

        public FileTheatreRepository() {
            this.fileUtils = new FileUtils();
            initializeFile();
        }

        private void initializeFile() {
            File file = new File(FILE_PATH);
            if (!file.exists()) {
                try {
                    file.getParentFile().mkdirs();
                    file.createNewFile();
                } catch (IOException e) {
                    System.err.println("Error initializing theatres file: " + e.getMessage());
                }
            }
        }

        @Override
        public List<Theatre> getAllTheatres() {
            List<Theatre> theatres = new ArrayList<>();
            try {
                List<String> lines = fileUtils.readLines(FILE_PATH);
                for (String line : lines) {
                    if (!line.trim().isEmpty()) {
                        String[] parts = line.split("\\|");
                        if (parts.length == 5) {
                            Theatre theatre = new Theatre(
                                    parts[0],
                                    parts[1],
                                    parts[2],
                                    Integer.parseInt(parts[3]),
                                    Integer.parseInt(parts[4])
                            );
                            theatres.add(theatre);
                        }
                    }
                }
            } catch (IOException e) {
                System.err.println("Error reading theatres: " + e.getMessage());
            }
            return theatres;
        }

        @Override
        public Theatre getTheatreById(String id) {
            try {
                List<String> lines = fileUtils.readLines(FILE_PATH);
                for (String line : lines) {
                    if (!line.trim().isEmpty()) {
                        String[] parts = line.split("\\|");
                        if (parts.length == 5 && parts[0].equals(id)) {
                            return new Theatre(
                                    parts[0],
                                    parts[1],
                                    parts[2],
                                    Integer.parseInt(parts[3]),
                                    Integer.parseInt(parts[4])
                            );
                        }
                    }
                }
            } catch (IOException e) {
                System.err.println("Error finding theatre: " + e.getMessage());
            }
            return null;
        }

        @Override
        public boolean addTheatre(Theatre theatre) {
            try {
                if (theatre.getId() == null || theatre.getId().isEmpty()) {
                    theatre.setId(UUID.randomUUID().toString());
                }
                String line = theatre.getId() + "|" +
                        theatre.getName() + "|" +
                        theatre.getLocation() + "|" +
                        theatre.getCapacity() + "|" +
                        theatre.getScreens();
                fileUtils.appendLine(FILE_PATH, line);
                return true;
            } catch (IOException e) {
                System.err.println("Error adding theatre: " + e.getMessage());
                return false;
            }
        }

        @Override
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
                fileUtils.writeLines(FILE_PATH, convertTheatresToLines(theatres));
                return true;
            } catch (IOException e) {
                System.err.println("Error updating theatre: " + e.getMessage());
                return false;
            }
        }

        @Override
        public boolean deleteTheatre(String id) {
            List<Theatre> theatres = getAllTheatres();
            boolean removed = theatres.removeIf(theatre -> theatre.getId().equals(id));

            if (!removed) {
                return false;
            }

            try {
                fileUtils.writeLines(FILE_PATH, convertTheatresToLines(theatres));
                return true;
            } catch (IOException e) {
                System.err.println("Error deleting theatre: " + e.getMessage());
                return false;
            }
        }

        private List<String> convertTheatresToLines(List<Theatre> theatres) {
            List<String> lines = new ArrayList<>();
            for (Theatre theatre : theatres) {
                lines.add(theatre.getId() + "|" +
                        theatre.getName() + "|" +
                        theatre.getLocation() + "|" +
                        theatre.getCapacity() + "|" +
                        theatre.getScreens());
            }
            return lines;
        }
    }

