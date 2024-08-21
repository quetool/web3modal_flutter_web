import 'dart:developer';
import 'dart:js_interop';

import 'package:flutter_web_application_1/domain/actions/get_balance.dart';
import 'package:flutter_web_application_1/domain/window.dart';

Future<GetBalanceReturnType> getBalance(
  GetBalanceParameters getBalanceParameters,
) async {
  try {
    return await window.getBalance(getBalanceParameters).toDart;
  } catch (e) {
    log('Error fetching balance: $e');
    throw GetBalanceErrorType;
  }
}
