class UserLogin {
  String email;
  String password;

  UserLogin({required this.email, required this.password});

  Map <String, dynamic> toDatabaseJson() => {
    "email": this.email,
    "password": this.password
  };
}
