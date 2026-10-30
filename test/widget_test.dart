import 'package:flutter_test/flutter_test.dart';
import 'package:catatanku/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const CatatanKuApp());
    expect(find.text('CatatanKu'), findsWidgets);
  });
}
