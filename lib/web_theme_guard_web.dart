// ignore: avoid_web_libraries_in_flutter
// ignore: deprecated_member_use
import 'dart:html' as html;

void resetBrowserChrome() {
  final document = html.document;
  final body = document.body;
  final root = document.documentElement;

  body?.style.background = 'white';
  body?.style.color = '#111827';
  root?.style.background = 'white';
  root?.style.color = '#111827';

  final existingMeta = document.head?.querySelector('meta[name="theme-color"]');
  if (existingMeta != null) {
    existingMeta.setAttribute('content', '#ffffff');
    return;
  }

  final meta = html.MetaElement()
    ..name = 'theme-color'
    ..content = '#ffffff';
  document.head?.append(meta);
}
