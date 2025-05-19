<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Movie Reservation System</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        body {

            background-image: url('images/felix-mooneeram-evlkOfkQ5rE-unsplash.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
        }

        .bg-overlay {
            background: rgba(243, 244, 246, 0.85); /* Tailwind's gray-100 with opacity */
        }
    </style>
</head>
<body class="flex items-center justify-center h-screen">
<div class="bg-overlay p-10 rounded shadow-md w-full max-w-md text-center">
    <h1 class="text-3xl font-bold mb-6 text-indigo-700">Welcome to Movie Reservation System</h1>
    <div class="space-y-4">
        <a href="reserveTicket.jsp" class="block bg-indigo-600 text-white px-6 py-3 rounded hover:bg-indigo-700 transition">
            Reserve a Ticket
        </a>
        <a href="AdminViewReservationsServlet" class="block bg-gray-800 text-white px-6 py-3 rounded hover:bg-gray-900 transition">
            Admin: View All Reservations
        </a>
    </div>
    <p class="mt-8 text-gray-500 text-sm">
        &copy; <%= java.time.Year.now() %> Movie Reservation System
    </p>
</div>
</body>
</html>
