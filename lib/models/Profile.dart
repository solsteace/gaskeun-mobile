class User {
  final int id;
  final String nama;
  final String email;
  final String role;
  final String token;

  User( {
    required this.id,
    required this.nama,
    required this.email,
    required this.role,
    required this.token
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nama: json['nama'],
      email: json['email'],
      role: json['role'],
      token: json['token'],
    );
  }
}

class Profile {
  final int id;
  final String nama;
  final String email;
  final String role;

  Profile({
    required this.id,
    required this.nama,
    required this.email,
    required this.role,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      nama: json['nama'],
      email: json['email'],
      role: json['role'],
    );
  }
}
