class AuthException implements Exception {
  static const Map<String, String> errors = {
    'EMAIL_EXISTS': 'E-mail já cadastrado.',
    'OPERATION_NOT_ALLOWED': 'Esta operação não é permitida.',
    'TOO_MANY_ATTEMPTS_TRY_LATER':
        'Tentativas demais. Tente novamente mais tarde.',
    'USER_DISABLED': 'Este usuário está desativado.',
    'INVALID_LOGIN_CREDENTIALS': 'E-mail ou senha inválidos.',
  };

  final String key;

  AuthException(this.key);

  @override
  String toString() {
    return errors[key] ?? 'Ocorreu um erro no processo de autenticação.';
  }
}
