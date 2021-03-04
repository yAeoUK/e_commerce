import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = '/sign_in';
  static int signInSucceed=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text("Sign In"),
        title: Text(AppLocalizations.of(context).signIn)
      ),
      body: Body(),
    );
  }
}
