import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tremors/exceptions.dart';
import 'package:tremors/grpc/generated/webapi.v1.pb.dart';
import 'package:tremors/settings.dart';

class AuthenticatorModel extends ChangeNotifier {
  String? _token;
  final SharedPreferences sharedPreferences;

  AuthenticatorModel({
    required this.sharedPreferences,
    String? token,
  }) : _token = token;

  bool get isLogged => _token != null;

  TaskEither<SecurityException, AuthorisationSuccess> authorize(
    AuthorisationSuccess response,
  ) {
    if (isSupported(response.version)) {
      return TaskEither.Do(($) async {
        await $(_setString('token', response.token));
        await $(_setString('name', response.name));
        await $(_setString('email', response.email));
        await $(_setString('version', response.version));
        await $(_setBytes('configuration', response.configuration));
        await $(_setBytes('meta', response.meta));

        return response;
      });
    } else {
      return TaskEither.left(
          SecurityException('Unsupported Version ${response.version}!'));
    }
  }

  TaskEither<SecurityException, void> _setString(String key, String value) {
    return TaskEither.tryCatch(
      () => sharedPreferences.setString('security.$key', value),
      (error, _) =>
          SecurityException('Unable to persist security.$key.', error),
    );
  }

  TaskEither<SecurityException, void> _setBytes(String key, List<int> value) =>
      TaskEither.Do(($) async {
        final base64 = await $(TaskEither.fromEither(Either.tryCatch(
          () => const Base64Encoder().convert(value),
          (error, _) => SecurityException('Unable to prepare security.$key.'),
        )));

        return $(_setString(key, base64));
      });

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
          token: sharedPreferences.getString('security.token'),
        );
      });
}

bool isSupported(String version) {
  return true;
}
