// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:demo_project/homepage/postspage.dart';
import 'package:demo_project/models/usersmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Testing create post navigator from posts list page',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: PostPage(user: Users(id: '1'))));

    var button = find.byType(FloatingActionButton);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.text('Posts'), findsNothing);
    expect(find.text('Add Post'), findsWidgets);
  });
}
