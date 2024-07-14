import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:go_router/go_router.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:tremors/components/button.dart';
import 'package:tremors/components/logo.dart';
import 'package:tremors/exceptions.dart';
import 'package:tremors/foundation.dart';
import 'package:tremors/grpc/generated/webapi.v1.pb.dart';
import 'package:tremors/grpc/generated/webapi.v1.pbgrpc.dart';
import 'package:tremors/localization.dart';
import 'package:tremors/model/authenticator.dart';

const _version = '1.0.0';

const _redirectTimeout = Duration(seconds: 5);

const _loadingImage = SizedBox(
  height: 50,
  width: 50,
  child: LoadingIndicator(
    indicatorType: Indicator.ballScaleMultiple,
  )
);

class AuthorisePanel extends StatelessWidget {
  final SecurityServiceClient service;

  const AuthorisePanel({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context);
    final provider = state.pathParameters['provider'];
    final token = state.pathParameters['token'];

    if (provider == null || token == null) {
      return _noToken(context);
    } else {
      return _Stateful(
        service: service,
        provider: provider,
        token: token,
        authenticatorModel: context.read(),
      );
    }
  }

  Widget _noToken(BuildContext context) {
    final l10n = localization(context);
    final theme = Theme.of(context);

    return FollowUpPanel(
        header: const Logo(),
        body: Text(
          l10n.authorise_no_token,
          style: theme.textTheme.labelLarge,
        ));
  }
}

class _Stateful extends StatefulWidget {
  final SecurityServiceClient service;
  final AuthenticatorModel authenticatorModel;
  final String provider;
  final String token;

  const _Stateful({
    super.key,
    required this.service,
    required this.provider,
    required this.token,
    required this.authenticatorModel,
  });

  @override
  State createState() {
    return _State();
  }
}

class _State extends State<_Stateful> {
  late final Future<_Outcome> _future;

  @override
  void initState() {
    super.initState();
    _future = _run();
  }

  Future<_Outcome> _run() async {
    AuthorisationResponse response;
    try {
      response = await widget.service.authorise(AuthorisationRequest(
          version: _version, provider: widget.provider, token: widget.token));
    } catch (e) {
      return _RemoteFailure(e);
    }

    if (response.hasError()) {
      return _RemoteError(response.error);
    }

    Either<SecurityException, dynamic> outcome;

    try {
      outcome =
          await widget.authenticatorModel.authorize(response.success).run();
    } catch (e) {
      return _LocalFailure(e);
    }

    switch (outcome) {
      case Left(value: final cause):
        return _LocalError(cause);
      case Right(value: final success):
        return _Success(success);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = localization(context);

    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return FollowUpPanel(
            header: _loadingImage,
            body: Text(
              l10n.authorise_loading,
              style: theme.textTheme.labelLarge,
            ),
          );
        } else {
          switch (snapshot.requireData) {
            case _RemoteFailure(cause: final cause):
              return _error(l10n.authorise_remote_failure, cause, theme, l10n);
            case _RemoteError(error: final cause):
              return _error(l10n.authorise_remote_error, cause, theme, l10n);
            case _LocalFailure(cause: final cause):
              return _error(l10n.authorise_local_failure, cause, theme, l10n);
            case _LocalError(error: final error):
              return _error(l10n.authorise_local_error, error, theme, l10n);
            case _Success(success: final success):
              return _success(l10n, success, theme);
          }
        }
      },
    );
  }

  Widget _error(
    String data,
    dynamic error,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    final media = MediaQuery.of(context);
    return FollowUpPanel(
      header: _loadingImage,
      body: Column(
        children: [
          Text(
            data,
            style: theme.textTheme.labelLarge,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: media.size.width * 0.4,
            child: Button(
              title: l10n.authorise_try_again,
              action: () {
                context.go('/login');
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _success(
      AppLocalizations l10n, AuthorisationSuccess success, ThemeData theme) {
    Timer(_redirectTimeout, () {
      if (context.mounted) {
        context.go('/');
      }
    });

    return Column(
      children: [
        Text(
          l10n.authorise_success,
          style: theme.textTheme.labelLarge,
        ),
        Button(title: l10n.authorise_goto_main)
      ],
    );
  }
}

sealed class _Outcome {}

class _RemoteFailure extends _Outcome {
  final dynamic cause;
  _RemoteFailure(this.cause);
}

class _RemoteError extends _Outcome {
  final Error error;
  _RemoteError(this.error);
}

class _LocalFailure extends _Outcome {
  final dynamic cause;
  _LocalFailure(this.cause);
}

class _LocalError extends _Outcome {
  final SecurityException error;
  _LocalError(this.error);
}

class _Success extends _Outcome {
  final AuthorisationSuccess success;
  _Success(this.success);
}
