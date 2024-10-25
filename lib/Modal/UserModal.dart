class UserInfoModal {
  String? name, email;
  int? id;
  int? phone;

  UserInfoModal({
     this.name,
     this.email,
     this.phone,
     this.id,
  });

  factory UserInfoModal.fromJson(Map m1) {
    return UserInfoModal(
      id: m1['id'],
      name: m1['name'],
      email: m1['email'],
      phone: m1['phone'],

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
    };
  }
}
