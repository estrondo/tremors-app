import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fpdart/fpdart.dart';
import 'package:provider/provider.dart';
import 'package:tremors/exceptions.dart';
import 'package:tremors/model/authenticator.dart';
import 'package:tremors/router.dart';

import 'theme.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final either = await TaskEither<TremorsException, Widget>.Do(($) async {
    final authenticator = await $(AuthenticatorModel.getInstance());
    final materialApp = MaterialApp.router(
      color: Colors.redAccent,
      routerConfig: await $(router()),
      theme: theme(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale("en"), Locale("pt")],
    );

    return AppTheme(
      shadowTheme: const ShadowTheme(offset: Offset(2, 2), blurRadius: 10),
      child: ChangeNotifierProvider.value(
        value: authenticator,
        child: materialApp,
      ),
    );
  }).run();

  switch (either) {
    case Right(value: final app):
      runApp(app);

    case Left(value: final exception):
      print('Unfortunately you had an error: $exception!');
      runApp(Text(exception.toString()));
  }
}
