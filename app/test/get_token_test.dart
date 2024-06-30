import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tremors/grpc/generated/webapi.v1.pbgrpc.dart';
import 'package:tremors/grpc/webapi.dart';
import 'package:tremors/main_panel/get_token.dart';

import 'get_token_test.mocks.dart';
import 'router_helper.dart';

const expectedGoRouterPath = '/get-token/:provider/:token';

@GenerateMocks([SecurityService])
void main() async {
  testWidgets('GetToken panel should display the token.', (tester) async {
    final serviceMock = MockSecurityService();

    final router = await createGoRouter(tester, [
      GoRoute(
        path: expectedGoRouterPath,
        builder: (context, state) => GetTokenPanel(service: serviceMock),
      )
    ]);

    final expectedRequest = AuthenticationRequest(
        provider: 'zyb', token: 'aaabbb', version: '1.0.0');

    final expectedResponse = AuthenticationResponse(
      email: 'albert@mc.2',
      name: 'Einstein',
      token: 'aaabbbccc',
    );

    final completer = Completer<AuthenticationResponse>();

    when(serviceMock.authenticate(expectedRequest)).thenAnswer(
      (_) {
        completer.complete(expectedResponse);
        return completer.future;
      },
    );

    await router.goAndPump(
      '/get-token/${expectedRequest.provider}/${expectedRequest.token}',
      tester,
    );

    final tokenFinder = find.text('aaabbbccc');
    expect(tokenFinder, findsOneWidget);
  });

  testWidgets('GetTokenPanel should report any expected error.',
      (tester) async {
    final serviceMock = MockSecurityService();

    final goRouter = await createGoRouter(tester, [
      GoRoute(
        path: expectedGoRouterPath,
        builder: (context, state) => GetTokenPanel(service: serviceMock),
      )
    ]);

    final expectedRequest = AuthenticationRequest(
        provider: 'yuiop', token: '0192837465', version: '1.0.0');

    when(serviceMock.authenticate(expectedRequest))
        .thenAnswer((_) => Future.error('ERROR!'));

    await goRouter.goAndPump(
      '/get-token/${expectedRequest.provider}/${expectedRequest.token}',
      tester,
    );

    expect(find.text('Exception!'), findsOneWidget);
  });
}
