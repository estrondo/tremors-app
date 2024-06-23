import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tremors/exceptions.dart';
import 'package:tremors/settings.dart';

const _tokenKey = 'security.token';

class AuthenticatorModel extends ChangeNotifier {
  String? _token;
  final SharedPreferences sharedPreferences;

  AuthenticatorModel({
    required this.sharedPreferences,
    String? token,
  }) : _token = token;

  bool get isLogged => _token != null;

  static TaskEither<SecurityException, AuthenticatorModel> getInstance() =>
      TaskEither.Do(($) async {
        final sharedPreferences = await $(
          tryLoadPreferences().mapLeft(
            (l) => SecurityException.fromError(
                SecurityError.failedTokenStorage, l),
          ),
        );

        return AuthenticatorModel(
          sharedPreferences: sharedPreferences,
          token: sharedPreferences.getString(_tokenKey),
        );
      });
}
