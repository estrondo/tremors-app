import 'package:fpdart/fpdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tremors/exceptions.dart';

TaskEither<PreferencesException, SharedPreferences> tryLoadPreferences() =>
    TaskEither.tryCatch(
      SharedPreferences.getInstance,
      (error, _) => PreferencesException(
          'It was impossible to load your preferences!', error),
    );
