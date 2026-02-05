import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:warmtrip/main.dart';

void main() {
  testWidgets('WarmTrip app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const WarmTripApp());

    expect(find.text('发现'), findsOneWidget);
    expect(find.text('首页'), findsOneWidget);
  });
}
