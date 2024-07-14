import 'package:flutter/foundation.dart';
import 'package:grpc/grpc.dart';
import 'package:tremors/exceptions.dart';
import 'package:tremors/grpc/generated/webapi.v1.pbgrpc.dart';

const _tremorsGRPCHost = 'grpc_host';
const _tremorsGRPCPort = 'grpc_port';

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

  GRPCModule({
    required this.channel,
  });

  static Future<GRPCModule> _release() async {
    const channelHost = 'tremors-webapi.estrondo.one';
    return GRPCModule(channel: ClientChannel(channelHost));
  }

  static Future<GRPCModule> _debug() async {
    const channelHost = String.fromEnvironment(_tremorsGRPCHost);
    const port = int.fromEnvironment(_tremorsGRPCPort);

    if (channelHost != "" && port != 0) {
      return GRPCModule(channel: ClientChannel(channelHost, port: port));
    } else {
      throw ConfigurationException('Invalid GRPC Configuration!');
    }
  }
}

class SecurityModule {
  final SecurityServiceClient securityService;

  SecurityModule(this.securityService);

  static Future<SecurityModule> _debug(GRPCModule grpcModule) async {
    return _release(grpcModule);
  }

  static Future<SecurityModule> _release(GRPCModule grpcModule) async {
    return SecurityModule(
      SecurityServiceClient(grpcModule.channel),
    );
  }
}
