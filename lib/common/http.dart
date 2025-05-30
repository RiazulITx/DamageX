import 'dart:io';

import 'package:errorx/common/common.dart';
import 'package:errorx/state.dart';

class ErrorXHttpOverrides extends HttpOverrides {
  static String handleFindProxy(Uri url) {
    if ([localhost].contains(url.host)) {
      return "DIRECT";
    }
    final port = globalState.config.patchClashConfig.mixedPort;
    final isStart = globalState.appState.runTime != null;
    commonPrint.log("find $url proxy:$isStart");
    if (!isStart) return "DIRECT";
    return "PROXY localhost:$port";
  }

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    client.findProxy = handleFindProxy;
    return client;
  }
}
