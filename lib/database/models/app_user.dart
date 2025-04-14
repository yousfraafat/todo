class AppUser {
  String? userName;
  String? email;
  String? authId;

  AppUser({this.userName, this.email, this.authId});

  AppUser.fromFireStore(Map<String, dynamic?>? data)
    : this(
        userName: data?['userName'],
        email: data?['email'],
        authId: data?['authId'],
      );

  Map<String, dynamic> toFireStore() {
    return {'userName': userName, 'email': email, 'authId': authId};
  }
}
