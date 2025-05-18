document.addEventListener('DOMContentLoaded', function() {
    // DOM elements
    const viewTheatresLink = document.getElementById('viewTheatres');
    const addTheatreLink = document.getElementById('addTheatre');
    const theatreListSection = document.getElementById('theatreListSection');
    const addTheatreSection = document.getElementById('addTheatreSection');
    const theatreForm = document.getElementById('theatreForm');
    const cancelBtn = document.getElementById('cancelBtn');
    const theatreList = document.getElementById('theatreList');

    // Event listeners
    viewTheatresLink.addEventListener('click', showTheatreList);
    addTheatreLink.addEventListener('click', showAddTheatreForm);
    cancelBtn.addEventListener('click', showTheatreList);
    theatreForm.addEventListener('submit', handleFormSubmit);

    // Initial load
    showTheatreList();
    loadTheatres();

    // Functions
    function showTheatreList() {
        theatreListSection.classList.add('active');
        addTheatreSection.classList.remove('active');
        loadTheatres();
    }

    function showAddTheatreForm() {
        theatreListSection.classList.remove('active');
        addTheatreSection.classList.add('active');
        theatreForm.reset();
        document.getElementById('theatreId').value = '';
    }

    async function loadTheatres() {
        try {
            const response = await fetch('TheatreServlet?action=list');
            const theatres = await response.json();

            theatreList.innerHTML = '';

            if (theatres.length === 0) {
                theatreList.innerHTML = '<p>No theatres found. Add a new theatre to get started.</p>';
                return;
            }

            theatres.forEach(theatre => {
                const theatreCard = document.createElement('div');
                theatreCard.className = 'theatre-card';
                theatreCard.innerHTML = `
                    <h3>${theatre.name}</h3>
                    <p><strong>Location:</strong> ${theatre.location}</p>
                    <p><strong>Capacity:</strong> ${theatre.capacity}</p>
                    <p><strong>Screens:</strong> ${theatre.screens}</p>
                    <div class="theatre-actions">
                        <button class="edit-btn" data-id="${theatre.id}">Edit</button>
                        <button class="delete-btn" data-id="${theatre.id}">Delete</button>
                    </div>
                `;
                theatreList.appendChild(theatreCard);
            });

            // Add event listeners to edit and delete buttons
            document.querySelectorAll('.edit-btn').forEach(btn => {
                btn.addEventListener('click', editTheatre);
            });

            document.querySelectorAll('.delete-btn').forEach(btn => {
                btn.addEventListener('click', deleteTheatre);
            });
        } catch (error) {
            console.error('Error loading theatres:', error);
            theatreList.innerHTML = '<p>Error loading theatres. Please try again.</p>';
        }
    }

    async function editTheatre(e) {
        const theatreId = e.target.getAttribute('data-id');
        try {
            const response = await fetch(`TheatreServlet?action=get&id=${theatreId}`);
            const theatre = await response.json();

            document.getElementById('theatreId').value = theatre.id;
            document.getElementById('name').value = theatre.name;
            document.getElementById('location').value = theatre.location;
            document.getElementById('capacity').value = theatre.capacity;
            document.getElementById('screens').value = theatre.screens;

            showAddTheatreForm();
        } catch (error) {
            console.error('Error fetching theatre:', error);
            alert('Error fetching theatre details. Please try again.');
        }
    }

    async function deleteTheatre(e) {
        const theatreId = e.target.getAttribute('data-id');
        if (!confirm('Are you sure you want to delete this theatre?')) {
            return;
        }

        try {
            const response = await fetch(`TheatreServlet?action=delete&id=${theatreId}`, {
                method: 'POST'
            });

            if (response.ok) {
                loadTheatres();
            } else {
                throw new Error('Failed to delete theatre');
            }
        } catch (error) {
            console.error('Error deleting theatre:', error);
            alert('Error deleting theatre. Please try again.');
        }
    }

    async function handleFormSubmit(e) {
        e.preventDefault();

        const formData = new FormData(theatreForm);
        const theatreData = {
            id: formData.get('theatreId'),
            name: formData.get('name'),
            location: formData.get('location'),
            capacity: parseInt(formData.get('capacity')),
            screens: parseInt(formData.get('screens'))
        };

        const action = theatreData.id ? 'update' : 'add';

        try {
            const response = await fetch('TheatreServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    action: action,
                    theatre: theatreData
                })
            });

            if (response.ok) {
                showTheatreList();
            } else {
                throw new Error('Failed to save theatre');
            }
        } catch (error) {
            console.error('Error saving theatre:', error);
            alert('Error saving theatre. Please try again.');
        }
    }
});
