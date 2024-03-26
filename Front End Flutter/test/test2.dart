import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:project/main.dart';
import 'package:project/screens/test_image_upload.dart';

void main() {
  testWidgets('Test Upload Image widget', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: HomeScreen())); // Create the HomeScreen widget inside a MaterialApp.
    expect(find.text('No image selected.'), findsOneWidget);
    await tester.tap(find.text('Select Image from Gallery'));
    await tester.pumpAndSettle();
  });
}
