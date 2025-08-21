import 'package:dengue_zero/data/repositories/auth/auth_repository.dart';
import 'package:dengue_zero/data/repositories/auth/auth_repository_impl.dart';
import 'package:dengue_zero/ui/home/overview_screen.dart';
import 'package:dengue_zero/ui/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginOrHome extends StatelessWidget {
  const LoginOrHome({super.key});

  @override
  Widget build(BuildContext context) {
    AuthRepository auth =
        Provider.of<AuthRepositoryImpl>(context) as AuthRepository;
    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.error != null) {
          return const Center(
            child: Text('Ocorreu um erro!'),
          );
        } else {
          return auth.isAuth ? const OverviewScreen() : const LoginScreen();
        }
      },
    );
  }
}
