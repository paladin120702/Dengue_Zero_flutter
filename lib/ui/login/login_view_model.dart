import 'package:dengue_zero/data/repositories/auth/auth_repository.dart';
import 'package:dengue_zero/data/exception/auth_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class LoginViewModel with ChangeNotifier {
  final AuthRepository authRepository;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  LoginViewModel(this.authRepository);

  Future<void> signInWithGoogle(Function(String msg) onError) async {
    _setLoading(true);
    try {
      await authRepository.signInWithGoogle();
    } on AuthException catch (error) {
      onError(error.toString());
    } catch (e) {
      onError('Erro inesperado ao fazer login com Google.');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
