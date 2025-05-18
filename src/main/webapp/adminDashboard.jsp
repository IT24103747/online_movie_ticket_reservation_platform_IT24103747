<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Ticket Booking Dashboard</title>
    <link rel="stylesheet" href="login/css/AdminDashboard.css">
    <link rel="stylesheet" href="login/css/AdminDashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="dashboard-container">
    <aside class="sidenav">
        <div class="logo">
            <i class="fa fa-film"></i>
            <span>CineStar</span>
        </div>
        <ul class="nav-links">
            <li class="active">
                <a href="${pageContext.request.contextPath}/admin/users"><i class="fa fa-home"></i> <span>User Management</span></a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/movies"><i class="fa fa-video"></i> <span>Movie Management</span></a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/bookings"><i class="fa fa-calendar-alt"></i> <span>Booking Management</span></a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/admin/reviews"><i class="fa fa-user"></i> <span>Review Management</span></a>
            </li>
            <li>
                <a href="index.jsp"><i class="fa fa-sign-out-alt"></i> <span>Logout</span></a>
            </li>
        </ul>
    </aside>
    <main class="main-content">
        <div class="container">
            <h1 class="mb-4">User Management</h1>
            <div class="d-flex justify-content-between mb-3">
                <a href="dashboard.jsp" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                </a>
                <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addModal">
                    <i class="fas fa-plus"></i> Add New User
                </button>
            </div>

            <div class="row">
                <c:forEach items="${users}" var="user">
                    <div class="col-md-6 col-lg-4 mb-4">
                        <div class="user-card">
                            <div class="user-avatar">
                                <img src="${user.imageUrl != null ? user.imageUrl : 'https://thumbs.dreamstime.com/z/female-avatar-profile-picture-vector-female-avatar-profile-picture-vector-102690279.jpg?ct=jpeg' += user.name += '&background=random'}"
                                     alt="Chanmini" class="img-fluid rounded-circle">
                            </div>
                            <div class="user-info">
                                <h5>Chanmini Minduli</h5>
                                <p class="text-muted mb-1">it24103747@my.sliit.lk</p>
                                <p class="text-muted">Phone: 0712265189</p>
                                <p class="text-muted">Role: Admin</p>
                            </div>
                            <div class="action-buttons">
                                <button class="btn btn-primary btn-sm edit-btn"
                                        data-id="${user.id}"
                                        data-name="${user.name}"
                                        data-email="${user.email}"
                                        data-phone="${user.phone}"
                                        data-role="${user.role}"
                                        data-image="${user.imageUrl}">
                                    <i class="fas fa-edit"></i> Edit
                                </button>
                                <form action="${pageContext.request.contextPath}/admin/users" method="post" class="d-inline">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="id" value="${user.id}">
                                    <button type="submit" class="btn btn-danger btn-sm delete-btn" onclick="return confirm('Are you sure you want to delete this user?')">
                                        <i class="fas fa-trash"></i> Delete
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- Add User Modal -->
        <div class="modal fade" id="addModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Add New User</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/admin/users" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="add">
                        <div class="modal-body">
                            <div class="mb-3">
                                <label for="addName" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="addName" name="name" required>
                            </div>
                            <div class="mb-3">
                                <label for="addEmail" class="form-label">Email</label>
                                <input type="email" class="form-control" id="addEmail" name="email" required>
                            </div>
                            <div class="mb-3">
                                <label for="addPhone" class="form-label">Phone</label>
                                <input type="text" class="form-control" id="addPhone" name="phone" required>
                            </div>
                            <div class="mb-3">
                                <label for="addPassword" class="form-label">Password</label>
                                <input type="password" class="form-control" id="addPassword" name="password" required>
                            </div>
                            <div class="mb-3">
                                <label for="addRole" class="form-label">Role</label>
                                <select class="form-select" id="addRole" name="role" required>
                                    <option value="USER">User</option>
                                    <option value="ADMIN">Admin</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="addImage" class="form-label">Profile Image (URL)</label>
                                <input type="text" class="form-control" id="addImage" name="imageUrl" placeholder="https://example.com/image.jpg">
                                <small class="text-muted">Leave empty to use default avatar</small>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Add User</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Edit User Modal -->
        <div class="modal fade" id="editModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Edit User</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form action="${pageContext.request.contextPath}/admin/users" method="post">
                        <input type="hidden" name="action" value="edit">
                        <input type="hidden" name="id" id="editId">
                        <div class="modal-body">
                            <div class="text-center mb-3">
                                <img id="editImagePreview" src="" alt="User Image" class="img-fluid rounded-circle" style="width: 100px; height: 100px; object-fit: cover;">
                            </div>
                            <div class="mb-3">
                                <label for="editName" class="form-label">Full Name</label>
                                <input type="text" class="form-control" id="editName" name="name" required>
                            </div>
                            <div class="mb-3">
                                <label for="editEmail" class="form-label">Email</label>
                                <input type="email" class="form-control" id="editEmail" name="email" required>
                            </div>
                            <div class="mb-3">
                                <label for="editPhone" class="form-label">Phone</label>
                                <input type="text" class="form-control" id="editPhone" name="phone" required>
                            </div>
                            <div class="mb-3">
                                <label for="editPassword" class="form-label">Password (leave empty to keep current)</label>
                                <input type="password" class="form-control" id="editPassword" name="password">
                            </div>
                            <div class="mb-3">
                                <label for="editRole" class="form-label">Role</label>
                                <select class="form-select" id="editRole" name="role" required>
                                    <option value="USER">User</option>
                                    <option value="ADMIN">Admin</option>
                                </select>
                            </div>
                            <div class="mb-3">
                                <label for="editImage" class="form-label">Profile Image (URL)</label>
                                <input type="text" class="form-control" id="editImage" name="imageUrl">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-primary">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="login/js/AdminDashboard.js"></script>
        <script src="login/js/AdminDashboard.js"></script>
    </main>
</div>
</body>
</html>