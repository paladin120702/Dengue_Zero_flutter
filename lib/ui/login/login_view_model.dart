import 'package:dengue_zero/data/repositories/auth/auth_repository.dart';
import 'package:dengue_zero/models/auth_exception.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier {
  final AuthRepository auth;

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  LoginViewModel({required this.auth});

  Future<void> loginWithGoogle() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await auth.signInWithGoogle();
    } on AuthException catch (error) {
      _errorMessage = error.toString();
    } catch (_) {
      _errorMessage = 'Erro inesperado ao fazer login com Google.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
