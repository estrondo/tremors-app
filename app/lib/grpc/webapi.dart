import 'package:tremors/grpc/generated/webapi.v1.pbgrpc.dart';

class SecurityService {
  final SecurityServiceClient _client;

  SecurityService(this._client);

  Future<AuthenticationResponse> authenticate(AuthenticationRequest request) {
    return _client.authenticate(request);
  }
}
