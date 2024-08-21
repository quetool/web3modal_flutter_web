import 'dart:js_interop';

@JS()
extension type Chain(JSObject _) implements JSObject {
  external JSNumber? id;
  external JSString? name;
}
