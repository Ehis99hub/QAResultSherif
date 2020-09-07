class LoginResponse {
  String name;
  String message;
  String telephone;
  bool isSuccessful;

  LoginResponse({
    this.name,
    this.telephone,
    this.message,
    this.isSuccessful,
  });
}