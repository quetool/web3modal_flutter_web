import 'dart:js_interop';

/// [Documentation API](https://wagmi.sh/core/api/actions/getBalance)
@JS()
extension type GetBalanceParameters._(JSObject _) implements JSObject {
  external GetBalanceParameters({
    required JSString address,
    JSBigInt? blockNumber,
    JSString? blockTag,
    JSNumber? chainId,
    JSString? token,
    JSString? unit,
  });
  external JSString address;
  external JSBigInt? blockNumber;
  external JSString? blockTag;
  external JSNumber? chainId;
  external JSString? token;
  external JSString? unit;
}

@JS()
extension type GetBalanceReturnType(JSObject _) implements JSObject {
  external JSNumber decimal;
  external JSString formatted;
  external JSString symbol;
  external JSBigInt value;
}

@JS()
extension type GetBalanceErrorType(JSObject _) implements JSObject {}
