import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:tremors/auth/google.dart' as google;
import 'package:tremors/auth/id_token.dart';
import 'package:tremors/exceptions.dart';
import 'package:tremors/svg.dart';

class LoginPanel extends StatelessWidget {
  const LoginPanel({super.key});

  Widget _googleSignIn(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return _signIn(
      context,
      'images/logo-google.svg',
      const Color.fromRGBO(0x42, 0x85, 0xf4, 1),
      Colors.white,
      localization!.sign_in_google,
      google.getIdToken,
    );
  }

  Widget _signIn(
    BuildContext context,
    String image,
    Color color,
    Color labelColor,
    String label,
    TaskEither<SecurityException, IdToken> Function() login,
  ) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => _run(login(), context),
      child: Container(
        padding: const EdgeInsets.all(10),
        color: color,
        child: Row(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(5),
              child: Svg.asset(image,
                  height: MediaQuery.of(context).size.width * 0.07),
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: Text(
                label,
                style: theme.textTheme.labelLarge!.copyWith(color: labelColor),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _logo(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Svg.asset(
          'images/logo.svg',
          width: MediaQuery.of(context).size.width * 0.4,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    final theme = Theme.of(context);

    return ColoredBox(
      color: theme.dialogBackgroundColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: mediaQueryData.size.width / 2,
              child: Column(children: [
                _logo(context),
              ]),
            ),
            SizedBox(
              height: mediaQueryData.size.height * 0.05,
            ),
            SizedBox(
              width: mediaQueryData.size.width * 0.90,
              child: Column(
                children: [
                  _googleSignIn(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // TODO: Improve it.
  Future<void> _run(TaskEither<SecurityException, IdToken> login,
      BuildContext context) async {
    switch (await login.run()) {
      case Right(value: final idToken):
        context.go('/authorise/${idToken.provider}/${idToken.token}');
      case Left(value: final exception):
    }
  }
}
