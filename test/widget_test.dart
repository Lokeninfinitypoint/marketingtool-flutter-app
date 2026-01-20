import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:marketingtool_app/main.dart';

void main() {
  testWidgets('MarketingToolApp loads successfully', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(const MarketingToolApp());

    // Verify the app builds without errors
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
