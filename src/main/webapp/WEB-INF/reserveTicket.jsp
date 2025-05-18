<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Reserve Ticket</title>

    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        body {
            background-image: url('images/felix-mooneeram-evlkOfkQ5rE-unsplash.jpg');
            background-size: cover;
            background-position: center;
        }
    </style>
</head>
<body class="flex items-center justify-center min-h-screen">
<div class="bg-white bg-opacity-80 p-8 rounded-lg shadow-lg max-w-md w-full">
    <h2 class="text-2xl font-bold mb-6 text-center text-gray-800">Reserve Ticket</h2>
    <form action="ReserveTicketServlet" method="post" class="space-y-4">
        <div>
            <label class="block text-gray-700 font-semibold mb-1" for="userName">Name:</label>
            <input type="text" id="userName" name="userName" required class="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500" />
        </div>
        <div>
            <label class="block text-gray-700 font-semibold mb-1" for="movie">Movie:</label>
            <input type="text" id="movie" name="movie" required class="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500" />
        </div>
        <div>
            <label class="block text-gray-700 font-semibold mb-1" for="showTime">Show Time:</label>
            <input type="text" id="showTime" name="showTime" required class="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500" />
        </div>
        <div>
            <label class="block text-gray-700 font-semibold mb-1" for="seats">Seats:</label>
            <input type="number" id="seats" name="seats" min="1" required class="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500" />
        </div>
        <div>
            <label class="block text-gray-700 font-semibold mb-1" for="paymentSlip">Payment Slip Number:</label>
            <input type="text" id="paymentSlip" name="paymentSlip" required class="w-full px-3 py-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500" />
        </div>
        <div class="text-center">
            <input type="submit" value="Reserve" class="bg-blue-600 text-white px-6 py-2 rounded hover:bg-blue-700 cursor-pointer" />
        </div>
    </form>
</div>
</body>
</html>
