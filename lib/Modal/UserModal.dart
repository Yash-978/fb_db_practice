/*
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

*/


class UserDataModal {
  String? name;
  int? id, age, phone;
  double? salary;

  UserDataModal({
    required this.name,
    required this.id,
    required this.age,
    required this.salary,
    required this.phone,
  });

  factory UserDataModal.formJson(Map m1) {
    return UserDataModal(
      name: m1['name'],
      id: m1['id'],
      age: m1['age'],
      salary: m1['salary'],
      phone: m1['phone'],
    );
  }
  Map<String,dynamic> toMap()
  {
    return {
      'name':name,
      'id':id,
      'age':salary,
      'phone':phone,
      'salary':salary,
    };
  }
}

