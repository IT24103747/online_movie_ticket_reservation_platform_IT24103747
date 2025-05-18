/**
 * User Management System - Main JavaScript File
 * Handles all client-side functionality for the user management interface
 */

document.addEventListener('DOMContentLoaded', function() {
    // Initialize components
    initEditUserModal();
    initDeleteButtons();
    initToastNotifications();
    initUserSearch();
});

/**
 * Initialize the edit user modal functionality
 */
function initEditUserModal() {
    const editModal = new bootstrap.Modal(document.getElementById('editModal'));
    const editButtons = document.querySelectorAll('.edit-btn');

    editButtons.forEach(button => {
        button.addEventListener('click', function() {
            // Get user data from data attributes
            const userData = {
                originalEmail: this.dataset.email,
                email: this.dataset.email,
                phone: this.dataset.phone,
                password: this.dataset.password
            };

            // Fill the modal form with user data
            populateEditForm(userData);

            // Show the modal
            editModal.show();
        });
    });

    // Add form validation
    const editForm = document.getElementById('editUserForm');
    if (editForm) {
        editForm.addEventListener('submit', function(e) {
            if (!validateUserForm(this)) {
                e.preventDefault();
                showToast('Please fill all fields correctly', 'error');
            }
        });
    }
}

/**
 * Populate the edit form with user data
 * @param {Object} userData - User data object
 */
function populateEditForm(userData) {
    document.getElementById('originalEmail').value = userData.originalEmail;
    document.getElementById('editEmail').value = userData.email;
    document.getElementById('editPhone').value = userData.phone;
    document.getElementById('editPassword').value = userData.password;
}

/**
 * Initialize delete buttons with confirmation
 */
function initDeleteButtons() {
    const deleteButtons = document.querySelectorAll('.delete-btn');

    deleteButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            if (!confirm('Are you sure you want to delete this user? This action cannot be undone.')) {
                e.preventDefault();
            } else {
                // Show loading state
                this.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Deleting...';
                this.disabled = true;

                // The form will submit normally after this
            }
        });
    });
}

/**
 * Initialize toast notifications system
 */
function initToastNotifications() {
    // Check for URL parameters to show success/error messages
    const urlParams = new URLSearchParams(window.location.search);
    const status = urlParams.get('status');
    const message = urlParams.get('message');

    if (status && message) {
        showToast(decodeURIComponent(message), status);
    }
}

/**
 * Show a toast notification
 * @param {string} message - The message to display
 * @param {string} type - Type of notification (success, error, warning, info)
 */
function showToast(message, type = 'success') {
    const toastContainer = document.getElementById('toastContainer');
    if (!toastContainer) return;

    const toastEl = document.createElement('div');
    toastEl.className = `toast align-items-center text-white bg-${type === 'error' ? 'danger' : type} border-0`;
    toastEl.setAttribute('role', 'alert');
    toastEl.setAttribute('aria-live', 'assertive');
    toastEl.setAttribute('aria-atomic', 'true');
    toastEl.innerHTML = `
        <div class="d-flex">
            <div class="toast-body">
                ${message}
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    `;

    toastContainer.appendChild(toastEl);
    const toast = new bootstrap.Toast(toastEl);
    toast.show();

    // Remove toast after it hides
    toastEl.addEventListener('hidden.bs.toast', function() {
        toastEl.remove();
    });
}

/**
 * Initialize user search functionality
 */
function initUserSearch() {
    const searchInput = document.getElementById('userSearch');
    if (!searchInput) return;

    searchInput.addEventListener('input', function() {
        const searchTerm = this.value.toLowerCase();
        const userCards = document.querySelectorAll('.user-card');

        userCards.forEach(card => {
            const email = card.querySelector('.user-email').textContent.toLowerCase();
            const phone = card.querySelector('.user-phone').textContent.toLowerCase();

            if (email.includes(searchTerm) || phone.includes(searchTerm)) {
                card.closest('.col-md-6').style.display = 'block';
            } else {
                card.closest('.col-md-6').style.display = 'none';
            }
        });
    });
}

/**
 * Validate user form
 * @param {HTMLFormElement} form - The form to validate
 * @returns {boolean} - True if form is valid, false otherwise
 */
function validateUserForm(form) {
    let isValid = true;

    // Validate email
    const email = form.querySelector('input[name="email"]');
    if (!email.value || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value)) {
        email.classList.add('is-invalid');
        isValid = false;
    } else {
        email.classList.remove('is-invalid');
    }

    // Validate phone
    const phone = form.querySelector('input[name="phone"]');
    if (!phone.value) {
        phone.classList.add('is-invalid');
        isValid = false;
    } else {
        phone.classList.remove('is-invalid');
    }

    // Validate password
    const password = form.querySelector('input[name="password"]');
    if (!password.value || password.value.length < 6) {
        password.classList.add('is-invalid');
        isValid = false;
    } else {
        password.classList.remove('is-invalid');
    }

    return isValid;
}

/**
 * Toggle password visibility
 * @param {HTMLElement} button - The toggle button that was clicked
 */
function togglePasswordVisibility(button) {
    const passwordInput = button.previousElementSibling;
    const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
    passwordInput.setAttribute('type', type);

    // Toggle icon
    button.innerHTML = type === 'password' ?
        '<i class="fas fa-eye"></i>' :
        '<i class="fas fa-eye-slash"></i>';
}

// Export functions for testing purposes (if needed)
if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        validateUserForm,
        togglePasswordVisibility,
        populateEditForm
    };
}