class User {
  final String email;
  final Role role;

  User(this.email, this.role);
}

enum Role {
  Employee,
  Manager,
  Admin
}
