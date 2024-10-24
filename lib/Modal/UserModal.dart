class UserModal {
  String? name, profilePicUrl, gender, maritalStatus, preferredContactMethod;
  bool receiveNotification;
  DateTime? dateOfBirth;

  UserModal({
    required this.name,
    required this.profilePicUrl,
    required this.gender,
    required this.maritalStatus,
    required this.preferredContactMethod,
    this.receiveNotification = false,
    required this.dateOfBirth,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dateOfBirth': dateOfBirth,
      'profilePicUrl': profilePicUrl,
      'receiveNotification': receiveNotification,
      'gender': gender,
      'maritalStatus': maritalStatus,
      'preferredContactMethod': preferredContactMethod,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'profilePicUrl': profilePicUrl,
      'receiveNotification': receiveNotification ? 1 : 0,
      'gender': gender,
      'maritalStatus': maritalStatus,
      'preferredContactMethod': preferredContactMethod,
    };
  }

  factory UserModal.fromJson(Map m1) {
    return UserModal(
      name: m1['name'],
      profilePicUrl: m1['profilePicUrl'],
      gender: m1['gender'],
      maritalStatus: m1['maritalStatus'],
      preferredContactMethod: m1['preferredContactMethod'],
      dateOfBirth: m1['dateOfBirth'],
    );
  }
}


class UserInfoModal{
  // String? name,
}