import 'dart:js_interop';

/// [Documentation API](https://wagmi.sh/core/api/actions/getToken)
@JS()
extension type GetTokenParameters._(JSObject _) implements JSObject {
  external GetTokenParameters({
    required JSString address,
    JSNumber? chainId,
    JSString? formatUnits,
  });
  external JSString address;
  external JSNumber? chainId;
  external JSString? formatUnits;
}

@JS()
extension type GetTokenReturnType(JSObject _) implements JSObject {
  external JSString address;
  external JSNumber decimals;
  external JSString? name;
  external JSString? symbol;
  external JSObject? totalSupply;
}

@JS()
extension type GetTokenErrorType(JSObject _) implements JSObject {}
