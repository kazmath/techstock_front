import 'ui_web_stub.dart' // Stub implementation
    if (dart.library.html) 'dart:ui_web'; // dart:html implementation

class Constants {
  Constants._();

  static const logHttpResponse = true;
  static const logHttpRequest = true;

  static const hostURL = "http://localhost:8090";
  static const apiURL = "$hostURL/api";

  static String get baseHref {
    var path = const BrowserPlatformLocation().getBaseHref() != null
        ? Uri.parse(const BrowserPlatformLocation().getBaseHref()!).path
        : '';
    path = path.replaceFirst(RegExp(r'/$'), '');
    return '$path/';
  }

  static String get baseHrefStripped =>
      baseHref.replaceFirst(RegExp(r'/$'), '');
}
