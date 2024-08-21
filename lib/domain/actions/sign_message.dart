import 'dart:js_interop';
import 'package:flutter_web_application_1/domain/models/connector.dart';

/// [Documentation API](https://wagmi.sh/core/api/actions/signMessage)
@JS()
extension type SignMessageParameters._(JSObject _) implements JSObject {
  external SignMessageParameters({
    JSString account,
    Connector? connector,
    JSString? message,
  });
  external JSString account;
  external Connector? connector;
  external JSString? message;
}

@JS()
extension type SignMessageReturnType(JSString _) implements JSString {}

@JS()
extension type SignMessageErrorType(JSObject _) implements JSObject {}
