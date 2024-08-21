import 'dart:developer';
import 'dart:js_interop';

import 'package:flutter_web_application_1/domain/actions/sign_message.dart';
import 'package:flutter_web_application_1/domain/window.dart';

Future<SignMessageReturnType> signMessage(
  SignMessageParameters signMessageParameters,
) async {
  try {
    return await window.signMessage(signMessageParameters).toDart;
  } catch (e) {
    log('Error sign message: $e');
    throw SignMessageErrorType;
  }
}
