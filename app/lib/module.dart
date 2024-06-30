import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';
import 'package:tremors/grpc/generated/webapi.v1.pbgrpc.dart';
import 'package:tremors/grpc/webapi.dart';

class AppModule {
  final GRPCModule grpcModule;
  final SecurityModule securityModule;

  AppModule({
    required this.grpcModule,
    required this.securityModule,
  });

  static Future<AppModule> resolve() {
    return kDebugMode ? _debug() : _release();
  }

  static Future<AppModule> _debug() async {
    final grpcModule = await GRPCModule._debug();
    final securityModule = await SecurityModule._debug(grpcModule);
    return AppModule(grpcModule: grpcModule, securityModule: securityModule);
  }

  static Future<AppModule> _release() async {
    final grpcModule = await GRPCModule._release();
    final securityModule = await SecurityModule._release(grpcModule);
    return AppModule(grpcModule: grpcModule, securityModule: securityModule);
  }
}

class GRPCModule {
  final ClientChannel channel;
  final SecurityServiceClient securityServiceClient;

  GRPCModule({
    required this.channel,
  }) : securityServiceClient = SecurityServiceClient(channel);

  static Future<GRPCModule> _release() async {
    const channelHost = 'tremors-webapi.estrondo.one';
    return GRPCModule(channel: ClientChannel(channelHost));
  }

  static Future<GRPCModule> _debug() async {
    const channelHost = 'localhost';
    return GRPCModule(channel: ClientChannel(channelHost, port: 8080));
  }
}

class SecurityModule {
  final SecurityService securityService;

  SecurityModule(this.securityService);

  static Future<SecurityModule> _debug(GRPCModule grpcModule) async {
    return SecurityModule(SecurityService(grpcModule.securityServiceClient));
  }

  static Future<SecurityModule> _release(GRPCModule grpcModule) async {
    return SecurityModule(SecurityService(grpcModule.securityServiceClient));
  }
}
