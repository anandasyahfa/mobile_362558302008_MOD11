import 'package:flutter_test/flutter_test.dart';
import 'package:mo06/modul_06/modul_06_app.dart';

void main() {
  testWidgets('Aplikasi Modul06App dapat dijalankan', (WidgetTester tester) async {
    await tester.pumpWidget(const Modul06App());
  });
}