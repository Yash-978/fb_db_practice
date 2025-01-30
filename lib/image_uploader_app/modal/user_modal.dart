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

class ImageModal {
  late String email, name, profile;
  late List<Gallery> gallery;

  ImageModal({
    required this.email,
    required this.name,
    required this.profile,
    required this.gallery,
  });

  factory ImageModal.fromJson(Map m1) {
    return ImageModal(
      email: m1['email'],
      name: m1['name'],
      profile: m1['profile'],
      gallery: (m1['gallery'] as List)
          .map(
            (e) => Gallery.fromJson(e),
          )
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'profile': profile,
      'gallery': gallery,
    };
  }
}

class Gallery {
  late String url, id, deleteId;

  Gallery({
    required this.url,
    required this.id,
    required this.deleteId,
  });

  factory Gallery.fromJson(Map m1) {
    return Gallery(
      url: m1['url'],
      id: m1['id'],
      deleteId: m1['deleteId'],
    );
  }
}
