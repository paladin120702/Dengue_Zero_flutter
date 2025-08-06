import 'package:dengue_zero/models/auth.dart';
import 'package:dengue_zero/models/auth_exception.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { Signup, Login }

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.Login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };

  bool _isLogin() => _authMode == AuthMode.Login;
  bool _isSignup() => _authMode == AuthMode.Signup;

  void _switchAuthMode() {
    setState(() {
      if (_isLogin()) {
        _authMode = AuthMode.Signup;
      } else {
        _authMode = AuthMode.Login;
      }
    });
  }

  void _showErrorDialog(String msg) {
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

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    _formKey.currentState?.save();
    Auth auth = Provider.of(context, listen: false);

    try {
      if (_isLogin()) {
        await auth.signIn(
          _authData['email']!,
          _authData['password']!,
        );
      } else {
        await auth.signUp(
          _authData['email']!,
          _authData['password']!,
        );
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      _showErrorDialog('Ocorreu um erro inesperado!');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of<Auth>(context, listen: false);
    final deviceSize = MediaQuery.of(context).size;
    return Center(
      child: Card(
        elevation: 8,
        child: Container(
          padding: const EdgeInsets.all(16),
          width: deviceSize.width * 0.75,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (email) => _authData['email'] = email ?? '',
                  validator: (_email) {
                    final email = _email ?? '';
                    if (email.trim().isEmpty || !email.contains('@')) {
                      return 'E-mail inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  controller: _passwordController,
                  onSaved: (password) => _authData['password'] = password ?? '',
                  validator: (_password) {
                    final password = _password ?? '';
                    if (password.isEmpty || password.length <= 5) {
                      return 'A Senha tem que possuir 6 caracteres';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                if (_isSignup())
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Confirme a senha'),
                    obscureText: true,
                    validator: _isLogin()
                        ? null
                        : (_password) {
                            final password = _password ?? '';
                            if (password != _passwordController.text) {
                              return 'Senha Incorreta';
                            }
                            return null;
                          },
                  ),
                const SizedBox(height: 20),
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 8,
                      ),
                    ),
                    child: Text(
                      _authMode == AuthMode.Login ? 'ENTRAR' : 'REGISTRAR',
                    ),
                  ),
                TextButton(
                  onPressed: _switchAuthMode,
                  child: Text(
                      _isLogin() ? 'Quer se registrar?' : 'Já tem uma conta?'),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  icon: const Icon(Icons.login),
                  label: const Text('Entrar com Google'),
                  onPressed: _isLoading
                      ? null
                      : () async {
                          setState(() {
                            _isLoading = true;
                          });
                          try {
                            await auth.signInWithGoogle();
                          } on AuthException catch (error) {
                            _showErrorDialog(error.toString());
                          } catch (error) {
                            _showErrorDialog(
                                'Erro inesperado ao fazer login com Google.');
                          } finally {
                            setState(() {
                              _isLoading = false;
                            });
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
