import 'dart:js_interop';
import 'package:flutter_web_application_1/domain/models/chain.dart';
import 'package:flutter_web_application_1/domain/models/connector.dart';

@JS()
extension type Account(JSObject _) implements JSObject {
  external JSString? get address;
  external JSString? get status;
  external Chain? get chain;
  external JSNumber? get chainId;
  external Connector? get connector;
  external JSBoolean? isConnecting;
  external JSBoolean? isReconnecting;
  external JSBoolean? isConnected;
  external JSBoolean? isDisconnected;
}
