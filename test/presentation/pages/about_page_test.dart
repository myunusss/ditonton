import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  MaterialApp app = MaterialApp(
    home: Scaffold(
      body: AboutPage(),
    ),
  );

  testWidgets("Should contain stack widget as Parent of column and center widget",
      (WidgetTester tester) async {
    await tester.pumpWidget(app);

    expect(find.byKey(Key('stack')), findsOneWidget);
    expect(find.byKey(Key('column')), findsOneWidget);
    expect(find.byKey(Key('center')), findsOneWidget);
  });
}
