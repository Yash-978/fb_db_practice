class UserModal {
  late String name, email;

  UserModal({
    required this.name,
    required this.email,
  });

  factory UserModal.fromJson(Map m1) {
    return UserModal(
      name: m1['name'],
      email: m1['email'],
    );
  }
}
