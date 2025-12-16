class UserProfile {
  final int id;
  final String firstName;
  final String lastName;
  final int age;
  final String gender;
  final String email;
  final String phone;
  final String image;
  final String role;

  // khởi tạo hàm (constructor)
  UserProfile({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.email,
    required this.phone,
    required this.image,
    required this.role,
  });

  // chuyển json từ api => dart
  factory UserProfile.formJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      age: json['age'],
      gender: json['gender'],
      email: json['email'],
      phone: json['phone'],
      image: json['image'],
      role: json['role'],
    );
  }

  /// Họ tên đầy đủ (tiện dùng cho UI)
  String get fullName => "$firstName $lastName";

  /// Giới tính tiếng Việt
  String get genderVN {
    if (gender == 'male') return 'Nam';
    if (gender == 'female') return 'Nữ';
    return 'Khác';
  }
}
