abstract class AuthRepository {
  bool get isAuth;
  String? get token;
  String? get email;
  String? get uid;

  Future<void> signInWithGoogle();
  Future<void> tryAutoLogin();
  void logout();
}
