import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart' hide State;
import 'package:go_router/go_router.dart';
import 'package:tremors/exceptions.dart';
import 'package:tremors/grpc/generated/webapi.v1.pbgrpc.dart';

const _version = '1.0.0';

class GetTokenPanel extends StatelessWidget {
  final SecurityServiceClient securityService;

  const GetTokenPanel({
    super.key,
    required this.securityService,
  });

  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context);
    final provider = state.pathParameters['provider'];
    final token = state.pathParameters['token'];

    return GetTokenProgress(
      securityService: securityService,
      provider: provider,
      token: token,
    );
  }
}

class GetTokenProgress extends StatefulWidget {
  final String? provider;
  final String? token;
  final SecurityServiceClient securityService;

  const GetTokenProgress({
    super.key,
    this.provider,
    this.token,
    required this.securityService,
  });

  @override
  State createState() => _GetTokenProgress();
}

class _GetTokenProgress extends State<GetTokenProgress> {
  late Future<Either<SecurityException, AuthenticationResponse>> _future;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Text('Waiting...');
        } else if (snapshot.hasError) {
          return const Text('Error');
        } else {
          switch (snapshot.requireData) {
            case Left(value: final error):
              print(error);
              return const Text('Exception!');

            case Right(value: final response):
              return Text(response.token);
          }
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();

    if (widget.token == null || widget.provider == null) {
      _future = Future.value(Either.left(SecurityException('Uninitialized!')));
    } else {
      _future = TaskEither<SecurityException, AuthenticationResponse>.tryCatch(
        () => widget.securityService.authenticate(
          AuthenticationRequest(
            provider: widget.provider,
            token: widget.token,
            version: _version,
          ),
        ),
        (error, _) => SecurityException('Unexpected Exception!', error),
      ).run();
    }
  }
}
