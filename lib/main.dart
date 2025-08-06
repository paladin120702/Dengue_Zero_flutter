import 'package:dengue_zero/firebase_options.dart';
import 'package:dengue_zero/models/auth.dart';
import 'package:dengue_zero/screens/auth_or_home.dart';
import 'package:dengue_zero/screens/my_complaints_screen.dart';
import 'package:dengue_zero/screens/new_complaint_screen.dart';
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
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.red.shade800,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(300, 60),
              backgroundColor: Colors.red.shade800,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 16,
              ),
            ),
          ),
          textTheme: TextTheme(
            headlineLarge: TextStyle(
              color: Colors.red.shade800,
              fontWeight: FontWeight.bold,
              fontSize: 50,
            ),
            headlineMedium: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 20,
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            //filled: true,
            fillColor: Colors.red.shade50,
            labelStyle: TextStyle(
              color: Colors.red.shade800,
              fontWeight: FontWeight.bold,
            ),
            floatingLabelStyle: TextStyle(
              color: Colors.red.shade900,
              fontWeight: FontWeight.bold,
            ),
            prefixIconColor: Colors.red.shade700,
            suffixIconColor: Colors.red.shade700,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.red.shade300,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.red.shade900,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.red.shade700,
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.red.shade900,
                width: 2,
              ),
            ),
            hintStyle: TextStyle(
              color: Colors.red.shade300,
            ),
            helperStyle: TextStyle(
              color: Colors.red.shade400,
            ),
          ),
        ),
        routes: {
          AppRoutes.AUTH_OR_HOME: (ctx) => const AuthOrHome(),
          AppRoutes.NEW_COMPLAINT_SCREEN: (ctx) => const NewComplaintScreen(),
          AppRoutes.MY_COMPLAINTS_SCREEN: (ctx) => const MyComplaintsScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
