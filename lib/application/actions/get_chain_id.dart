import 'dart:js_interop';
import 'package:flutter_web_application_1/domain/window.dart';

JSNumber getChainId() {
  return window.getChainId();
}
