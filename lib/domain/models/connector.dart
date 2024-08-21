import 'dart:js_interop';

@JS()
extension type Connector(JSObject _) implements JSObject {
  external JSBoolean? multiInjectedProviderDiscovery;
  external JSBoolean? ssr;
  external JSBoolean? syncConnectedChain;
}
