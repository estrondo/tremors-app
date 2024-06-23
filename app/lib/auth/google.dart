import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tremors/auth/id_token.dart';
import 'package:tremors/exceptions.dart';

const _clientId =
    '733899787017-ng3uuer33t1karqit4obko1l48drv2kq.apps.googleusercontent.com';

TaskEither<SecurityException, IdToken> getIdToken() => TaskEither.Do(($) async {
      final googleSignIn = GoogleSignIn(
        scopes: ['openid'],
        serverClientId: _clientId,
      );

      final account = await $(
        TaskEither.tryCatch(
          googleSignIn.signIn,
          (error, _) => SecurityException(
            'An error has occurred during finding for a Google Account!',
            error,
          ),
        ).chainEither<GoogleSignInAccount>(
          (account) => (account != null)
              ? Either.of(account)
              : Either.left(SecurityException('There is no Google Account!')),
        ),
      );

      return await $(
        TaskEither.tryCatch(
          () => account.authentication,
          (error, _) =>
              SecurityException('It was impossible to authenticate!', error),
        ).chainEither(
          (r) => r.idToken != null
              ? Either.of(IdToken(provider: 'google', token: r.idToken!))
              : Either.left(SecurityException('There is no IdToken!')),
        ),
      );
    });
