import 'dart:developer';
import 'dart:js_interop';

import 'package:flutter_web_application_1/domain/actions/get_token.dart';
import 'package:flutter_web_application_1/domain/window.dart';

Future<GetTokenReturnType> getToken(
  GetTokenParameters getTokenParameters,
) async {
  try {
    return await window.getToken(getTokenParameters).toDart;
  } catch (e) {
    log('Error fetching token: $e');
    throw GetTokenErrorType;
  }
}
