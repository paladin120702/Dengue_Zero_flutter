import 'dart:async';
import 'package:dengue_zero/data/repositories/auth/auth_repository.dart';
import 'package:dengue_zero/data/services/local_storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImpl with ChangeNotifier implements AuthRepository {
  String? _token;
  String? _email;
  String? _uid;
  DateTime? _expiryDate;
  Timer? _logoutTimer;

  @override
  bool get isAuth {
    final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  @override
  String? get token {
    return isAuth ? _token : null;
  }

  @override
  String? get email {
    return isAuth ? _email : null;
  }

  @override
  String? get uid {
    return isAuth ? _uid : null;
  }

  @override
  Future<void> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final user = userCredential.user;
    if (user == null) return;

    _token = await user.getIdToken();
    _email = user.email;
    _uid = user.uid;
    _expiryDate = DateTime.now().add(const Duration(hours: 1));

    Storage.saveMap('userData', {
      'token': _token,
      'email': _email,
      'uId': _uid,
      'expiryDate': _expiryDate!.toIso8601String(),
    });

    _autoLogout();
    notifyListeners();
  }

  @override
  Future<void> tryAutoLogin() async {
    if (isAuth) return;

    final userData = await Storage.getMap('userData');
    if (userData.isEmpty) return;

    final expiryDate = DateTime.parse(userData['expiryDate']);
    if (expiryDate.isBefore(DateTime.now())) return;

    _token = userData['token'];
    _email = userData['email'];
    _uid = userData['uId'];
    _expiryDate = expiryDate;

    _autoLogout();
    notifyListeners();
  }

  @override
  void logout() {
    _token = null;
    _email = null;
    _uid = null;
    _expiryDate = null;
    _clearLogoutTimer();

    FirebaseAuth.instance.signOut();
    GoogleSignIn(scopes: ['email']).signOut();

    Storage.remove('userData').then((_) {
      notifyListeners();
    });
  }

  void _autoLogout() {
    _clearLogoutTimer();
    final timeLogout = _expiryDate?.difference(DateTime.now()).inSeconds;
    _logoutTimer = Timer(Duration(seconds: timeLogout ?? 0), logout);
  }

  void _clearLogoutTimer() {
    _logoutTimer?.cancel();
    _logoutTimer = null;
  }
}
