class UserModel {
  final String uid;
  final String fullname;
  final String email;
  final String phone;
  final String photoUrl;

  UserModel({
    required this.uid,
    required this.fullname,
    required this.email,
    required this.phone,
    required this.photoUrl,
  });

  factory UserModel.fromDocument(Map<String, dynamic> doc) {
    return UserModel(
      uid: doc['uid'] ?? '',
      fullname: doc['fullname'] ?? '',
      email: doc['email'] ?? '',
      phone: doc['phone'] ?? '',
      photoUrl: doc['photoUrl'] ?? '',
    );
  }
}
