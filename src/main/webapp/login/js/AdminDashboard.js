document.addEventListener('DOMContentLoaded', function() {
    // Initialize edit modals
    const editButtons = document.querySelectorAll('.edit-btn');
    const editModal = new bootstrap.Modal(document.getElementById('editModal'));

    editButtons.forEach(button => {
        button.addEventListener('click', function() {
            const userId = this.getAttribute('data-id');
            const userName = this.getAttribute('data-name');
            const userEmail = this.getAttribute('data-email');
            const userPhone = this.getAttribute('data-phone');
            const userRole = this.getAttribute('data-role');
            const userImage = this.getAttribute('data-image');

            document.getElementById('editId').value = userId;
            document.getElementById('editName').value = userName;
            document.getElementById('editEmail').value = userEmail;
            document.getElementById('editPhone').value = userPhone;
            document.getElementById('editRole').value = userRole;
            document.getElementById('editImage').value = userImage || '';

            // Set image preview
            const imagePreview = document.getElementById('editImagePreview');
            if (userImage) {
                imagePreview.src = userImage;
            } else {
                // Generate default avatar if no image is provided
                imagePreview.src = `https://ui-avatars.com/api/?name=${encodeURIComponent(userName)}&background=random`;
            }

            editModal.show();
        });
    });

    // Form validation for add and edit forms
    const addForm = document.querySelector('#addModal form');
    const editForm = document.querySelector('#editModal form');

    if (addForm) {
        addForm.addEventListener('submit', function(e) {
            const email = document.getElementById('addEmail').value;
            if (!validateEmail(email)) {
                e.preventDefault();
                alert('Please enter a valid email address');
                return false;
            }

            const phone = document.getElementById('addPhone').value;
            if (!validatePhone(phone)) {
                e.preventDefault();
                alert('Please enter a valid phone number');
                return false;
            }

            return true;
        });
    }

    if (editForm) {
        editForm.addEventListener('submit', function(e) {
            const email = document.getElementById('editEmail').value;
            if (!validateEmail(email)) {
                e.preventDefault();
                alert('Please enter a valid email address');
                return false;
            }

            const phone = document.getElementById('editPhone').value;
            if (!validatePhone(phone)) {
                e.preventDefault();
                alert('Please enter a valid phone number');
                return false;
            }

            return true;
        });
    }

    // Image URL validation and preview for edit modal
    const editImageInput = document.getElementById('editImage');
    if (editImageInput) {
        editImageInput.addEventListener('change', function() {
            const imageUrl = this.value;
            const imagePreview = document.getElementById('editImagePreview');

            if (imageUrl && isValidImageUrl(imageUrl)) {
                imagePreview.src = imageUrl;
            } else if (imageUrl === '') {
                const userName = document.getElementById('editName').value;
                imagePreview.src = `https://ui-avatars.com/api/?name=${encodeURIComponent(userName)}&background=random`;
            }
        });
    }

    // Helper functions
    function validateEmail(email) {
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(email);
    }

    function validatePhone(phone) {
        const re = /^[0-9]{10,15}$/;
        return re.test(phone);
    }

    function isValidImageUrl(url) {
        return /\.(jpeg|jpg|gif|png|webp)$/.test(url.toLowerCase());
    }

    // Delete confirmation
    const deleteButtons = document.querySelectorAll('.delete-btn');
    deleteButtons.forEach(button => {
        button.addEventListener('click', function(e) {
            if (!confirm('Are you sure you want to delete this user?')) {
                e.preventDefault();
            }
        });
    });
});