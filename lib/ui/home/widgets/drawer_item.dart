import 'package:dengue_zero/data/repositories/auth/auth_repository.dart';
import 'package:dengue_zero/data/repositories/auth/auth_repository_impl.dart';
import 'package:dengue_zero/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Drawer(
      child: Column(
        children: [
          SizedBox(height: deviceSize.height * 0.05),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair da Conta'),
            onTap: () {
              Provider.of<AuthRepositoryImpl>(context, listen: false).logout()
                  as AuthRepository;
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.LOGIN_OR_HOME);
            },
          ),
        ],
      ),
    );
  }
}
