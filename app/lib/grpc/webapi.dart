import 'package:tremors/grpc/generated/webapi.v1.pbgrpc.dart';

class SecurityService {
  final SecurityServiceClient _client;

  SecurityService(this._client);

  Future<AuthorisationResponse> authenticate(AuthorisationRequest request) {
    return _client.authorise(request);
  }
}
