import 'package:dengue_zero/ui/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInGoogle extends StatelessWidget {
  const SignInGoogle({super.key});

  void _showErrorDialog(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (cxt) => AlertDialog(
        title: const Text('Ocorreu um erro'),
        content: Text(msg),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LoginViewModel>();
    final deviceSize = MediaQuery.of(context).size;
    return SizedBox(
      width: deviceSize.width * 0.80,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade200,
          padding: EdgeInsets.zero,
        ),
        onPressed: vm.isLoading
            ? null
            : () => vm.signInWithGoogle(
                  (msg) => _showErrorDialog(context, msg),
                ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Visibility(
                visible: !vm.isLoading,
                replacement: const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      color: Colors.black,
                      strokeWidth: 1,
                    ),
                  ),
                ),
                child: Image.asset('assets/images/google_logo.png'),
              ),
            ),
            Text(
              !vm.isLoading ? 'Entrar com o Google' : 'Realizando login...',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
