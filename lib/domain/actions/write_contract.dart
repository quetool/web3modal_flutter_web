import 'dart:js_interop';
import 'package:flutter_web_application_1/domain/models/connector.dart';

/// [Documentation API](hhttps://wagmi.sh/core/api/actions/writeContract)
@JS()
extension type WriteContractParameters._(JSObject _) implements JSObject {
  external WriteContractParameters({
    required JSString abi,
    required JSString address,
    required JSString functionName,
    JSArray? accessList,
    JSString? account,
    JSArray? args,
    JSNumber? chainId,
    Connector? connector,
    JSString? dataSuffix,
    JSBigInt? gas,
    JSBigInt? gasPrice,
    JSBigInt? maxFeePerGas,
    JSBigInt? maxPriorityFeePerGas,
    JSNumber? nonce,
    JSString? type,
    JSBigInt? value,
  });

  external JSString abi;
  external JSString address;
  external JSArray? accessList;
  external JSString? account;
  external JSString functionName;
  external JSArray? args;
  external JSNumber? chainId;
  external Connector? connector;
  external JSString? dataSuffix;
  external JSBigInt? gas;
  external JSBigInt? gasPrice;
  external JSBigInt? maxFeePerGas;
  external JSBigInt? maxPriorityFeePerGas;
  external JSNumber? nonce;
  external JSString? type;
  external JSBigInt? value;
}

@JS()
extension type WriteContractReturnType(JSObject _) implements JSObject {
  external JSString hash;
}

@JS()
extension type WriteContractErrorType(JSObject _) implements JSObject {}
