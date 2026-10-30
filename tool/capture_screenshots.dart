import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:catatanku/screens/home_screen.dart';
import 'package:catatanku/theme/app_theme.dart';

Future<void> capture(
  WidgetTester tester,
  Widget widget,
  String name,
) async {
  tester.view.physicalSize = const Size(1080, 2340);
  tester.view.devicePixelRatio = 3.0;

  final repaintKey = GlobalKey();
  await tester.pumpWidget(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: RepaintBoundary(
        key: repaintKey,
        child: widget,
      ),
    ),
  );
  await tester.pump(const Duration(milliseconds: 100));

  final boundary =
      repaintKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
  if (boundary != null) {
    final image = await boundary.toImage(pixelRatio: 2.0);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData != null) {
      File('screenshots/$name.png')
          .writeAsBytesSync(byteData.buffer.asUint8List());
      // ignore: avoid_print
      print('Saved screenshots/$name.png');
    }
  }

  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pumpWidget(const SizedBox());
}

void main() {
  testWidgets('Capture 3 Home', (tester) async {
    await capture(tester, const HomeScreen(), '3_home_screen');
  });
}
