import 'dart:js_interop';

import 'package:flutter_web_application_1/domain/actions/get_balance.dart';
import 'package:flutter_web_application_1/domain/actions/get_token.dart';
import 'package:flutter_web_application_1/domain/actions/sign_message.dart';
import 'package:flutter_web_application_1/domain/actions/write_contract.dart';
import 'package:flutter_web_application_1/domain/models/account.dart';

@JS()
external JSWindow get window;

@JS()
extension type JSWindow(JSObject _) implements JSObject {
  external void openModal();
  external void closeModal();
  external Account getAccount();
  external JSNumber getChainId();
  external JSPromise<GetBalanceReturnType> getBalance(
    GetBalanceParameters getBalanceParameters,
  );
  external JSPromise<GetTokenReturnType> getToken(
    GetTokenParameters getTokenParameters,
  );
  external JSPromise<SignMessageReturnType> signMessage(
    SignMessageParameters signMessageParameters,
  );
  external JSPromise<WriteContractReturnType> writeContract(
    WriteContractParameters writeContractParameters,
  );
}
