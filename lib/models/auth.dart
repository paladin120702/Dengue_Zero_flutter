import 'dart:async';
import 'dart:convert';
import 'package:dengue_zero/data/storage.dart';
import 'package:dengue_zero/models/auth_exception.dart';
import 'package:dengue_zero/utils/data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _email;
  String? _uid;
  DateTime? _expiryDate;
  Timer? _logoutTimer;

  bool get isAuth {
    final isValid = _expiryDate?.isAfter(DateTime.now()) ?? false;
    return _token != null && isValid;
  }

  String? get token {
    return isAuth ? _token : null;
  }

  String? get email {
    return isAuth ? _email : null;
  }

  String? get uid {
    return isAuth ? _uid : null;
  }

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

  Future<void> _authenticate(
      String email, String password, String urlFragment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlFragment?key=${Data.AUTHENTICATE_BASE_URL}';
    final response = await post(
      Uri.parse(url),
      body: jsonEncode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    final body = jsonDecode(response.body);

    if (body['error'] != null) {
      throw AuthException(body['error']['message']);
    } else {
      _token = body['idToken'];
      _email = body['email'];
      _uid = body['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(body['expiresIn']),
        ),
      );

      Storage.saveMap('userData', {
        'token': _token,
        'email': _email,
        'uId': _uid,
        'expiryDate': _expiryDate!.toIso8601String(),
      });

      _autoLogout();
      notifyListeners();
    }
  }

  Future<void> signUp(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> signIn(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }

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
