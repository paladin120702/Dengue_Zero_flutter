import 'package:dengue_zero/ui/login/widgets/sign_in_google.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SizedBox(
          height: kToolbarHeight,
          child: Image.asset(
            'assets/images/Z.png',
            fit: BoxFit.contain,
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: deviceSize.height * 0.50,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/dengue_zero.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SignInGoogle(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
