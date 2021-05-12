import 'package:flutter/material.dart';
import 'package:flutter_ddd/presentation/page/sign_up/sign_up_notifier.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';
enum SignUpResult { success }

class SignUpScreen extends StatelessWidget {
  static String routeName = '/sign_up';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUpChangeNotifier>(
      create:(context)=> SignUpChangeNotifier(),
      child: Scaffold(
        appBar: AppBar(
          //title: Text("Sign Up"),
          title: Text(AppLocalizations.of(context)!.signUp),
        ),
        body: Body(),
      ),
    );
  }
}
