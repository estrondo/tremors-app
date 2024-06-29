import 'package:grpc/grpc.dart';
import 'package:tremors/grpc/generated/webapi.v1.pbgrpc.dart';

class AppModule {
  final GRPCModule grpcModule;

  AppModule({
    required this.grpcModule,
  });
}

class GRPCModule {
  final ClientChannel channel;
  final SecurityServiceClient securityService;

  GRPCModule({
    required this.channel,
  }) : securityService = SecurityServiceClient(channel);

  factory GRPCModule.live() {
    const channelHost = 'tremors-webapi.estrondo.one';

    return GRPCModule(channel: ClientChannel(channelHost));
  }
}
