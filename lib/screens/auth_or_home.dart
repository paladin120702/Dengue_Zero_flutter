import 'package:dengue_zero/models/auth.dart';
import 'package:dengue_zero/screens/auth_screen.dart';
import 'package:dengue_zero/screens/overview_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthOrHome extends StatelessWidget {
  const AuthOrHome({super.key});

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
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
          return auth.isAuth ? const OverviewScreen() : const AuthScreen();
        }
      },
    );
  }
}
