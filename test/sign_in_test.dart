import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_ddd/components/default_button.dart';
import 'package:flutter_ddd/main.dart';
import 'package:flutter_ddd/presentation/page/sign_in/sign_in_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  testWidgets('sign in with wrong credentials', (WidgetTester tester)async{
    await tester.pumpWidget( SignInScreen());

    Finder input=find.byType(TextFormField);
    await tester.enterText(input.first, "ahmad.rahab@windwoslive.com");
    await tester.enterText(input.at(1), "aaaaaaa");
    await tester.tap(find.byType(DefaultButton).first);
    await tester.pump();

    expect(find.byType(CircularProgressIndicator),findsNothing);

  });
}