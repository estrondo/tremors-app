import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tremors/exceptions.dart';
import 'package:tremors/grpc/generated/webapi.v1.pbgrpc.dart';
import 'package:tremors/main_panel/authorise_panel.dart';
import 'package:tremors/model/authenticator.dart';

import 'authorise_test.mocks.dart';
import 'grpc.dart';
import 'mixins.dart';
import 'router_helper.dart';

const expectedRoute = '/authorise/:provider/:token';

class Context with GoRouterAndWidgetTester {
  final MockSecurityServiceClient service;
  final MockAuthenticatorModel authenticatorModel;

  @override
  final GoRouter goRouter;

  @override
  final WidgetTester tester;

  Context({
    required this.service,
    required this.authenticatorModel,
    required this.goRouter,
    required this.tester,
  });
}

@GenerateMocks([SecurityServiceClient, AuthenticatorModel])
void main() async {
  provideDummy(TaskEither<SecurityException, AuthorisationSuccess>.left(
      SecurityException('@@@')));

  group('AuthorisePanel', () {
    contextTest(
      "should display 'loading'.",
      (context) async {
        final expectedRequest = AuthorisationRequest(
          version: '1.0.0',
          provider: 'zyb',
          token: 'aaabbb',
        );

        final completer = Completer<AuthorisationResponse>();

        when(context.service.authorise(expectedRequest)).thenAnswer(
          (_) => MockedResponseFuture(completer.future),
        );

        await context.goAndPump(
          '/authorise/${expectedRequest.provider}/${expectedRequest.token}',
        );

        final tokenFinder = find.text('Loading your account');
        expect(tokenFinder, findsOneWidget);
      },
    );

    contextTest(
      'should display any connection failure',
      (context) async {
        when(context.service.authorise(any))
            .thenAnswer((_) => MockedResponseFuture.error("@@@"));

        await context.goAndPump('/authorise/any/token');

        expect(find.text('Unable to communicate with the server.'),
            findsOneWidget);
      },
    );

    contextTest(
      'should display any remote error',
      (context) async {
        when(context.service.authorise(any)).thenAnswer(
          (_) => MockedResponseFuture.value(
            AuthorisationResponse(version: '1.0.0', error: Error(code: '1')),
          ),
        );

        await context.goAndPump('/authorise/any/token');

        expect(find.text('An error happened with the server.'), findsOneWidget);
      },
    );

    contextTest(
      'should display you are logged',
      (context) async {
        final expectedRequest = AuthorisationRequest(
            version: '1.0.0', provider: 'aeb', token: '789');

        final success = AuthorisationSuccess(
            version: '1.0.0',
            token: '987',
            email: 'r@r.c',
            name: 'Raa',
            configuration: [],
            meta: []);

        when(context.service.authorise(expectedRequest)).thenAnswer(
          (_) => MockedResponseFuture.value(
            AuthorisationResponse(success: success),
          ),
        );

        when(context.authenticatorModel.authorize(success))
            .thenAnswer((_) => TaskEither.right(success));

        await context.asyncGoAndPumpAndSettle(
            '/authorise/${expectedRequest.provider}/${expectedRequest.token}');

        expect(find.text('You are authorised.'), findsOneWidget);
      },
    );
  });
}

void contextTest(
  String description,
  Future<void> Function(Context) test, {
  bool? skip,
}) {
  return testWidgets(description, (tester) async {
    final serviceMock = MockSecurityServiceClient();
    final authenticatorModel = MockAuthenticatorModel();
    await tester.binding.setLocale('en', '');

    final router = await createGoRouter(tester, [
      GoRoute(
        path: expectedRoute,
        builder: (context, state) =>
            ChangeNotifierProvider<AuthenticatorModel>.value(
                value: authenticatorModel,
                child: AuthorisePanel(service: serviceMock)),
      )
    ]);

    return test(Context(
      service: serviceMock,
      authenticatorModel: authenticatorModel,
      goRouter: router,
      tester: tester,
    ));
  }, skip: skip);
}
