import 'package:dengue_zero/data/repositories/auth/auth_repository_impl.dart';
import 'package:dengue_zero/firebase_options.dart';
import 'package:dengue_zero/ui/login/login_or_home.dart';
import 'package:dengue_zero/ui/my_complaints/my_complaints_screen.dart';
import 'package:dengue_zero/ui/new_complaint/new_complaint_screen.dart';
import 'package:dengue_zero/ui/core/themes/all_themes.dart';
import 'package:dengue_zero/utils/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthRepositoryImpl>(
          create: (_) => AuthRepositoryImpl(),
        ),
      ],
      child: MaterialApp(
        theme: AllThemes.theme,
        routes: {
          AppRoutes.LOGIN_OR_HOME: (ctx) => const LoginOrHome(),
          AppRoutes.NEW_COMPLAINT_SCREEN: (ctx) => const NewComplaintScreen(),
          AppRoutes.MY_COMPLAINTS_SCREEN: (ctx) => const MyComplaintsScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
