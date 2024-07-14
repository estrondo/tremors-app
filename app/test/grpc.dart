import 'dart:async';

import 'package:grpc/grpc.dart';

class MockedResponseFuture<R> implements ResponseFuture<R> {
  final Future<R> _future;

  MockedResponseFuture(this._future);

  factory MockedResponseFuture.value(R value) =>
      MockedResponseFuture(Future.value(value));

  factory MockedResponseFuture.error(dynamic error, [StackTrace? stackTrace]) =>
      MockedResponseFuture(Future.error(error, stackTrace));

  @override
  Stream<R> asStream() => _future.asStream();

  @override
  Future<void> cancel() => Future.value();

  @override
  Future<R> catchError(Function onError, {bool Function(Object error)? test}) =>
      _future.catchError(onError, test: test);

  @override
  Future<Map<String, String>> get headers => Future.value({});

  @override
  Future<S> then<S>(FutureOr<S> Function(R p1) onValue, {Function? onError}) =>
      _future.then(onValue, onError: onError);

  @override
  Future<R> timeout(Duration timeLimit, {FutureOr<R> Function()? onTimeout}) =>
      _future.timeout(timeLimit, onTimeout: onTimeout);

  @override
  Future<Map<String, String>> get trailers => Future.value({});

  @override
  Future<R> whenComplete(FutureOr Function() action) =>
      _future.whenComplete(action);
}
