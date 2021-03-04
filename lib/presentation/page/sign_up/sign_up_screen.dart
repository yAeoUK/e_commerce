import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = '/sign_up';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text("Sign Up"),
        title: Text(AppLocalizations.of(context).signUp),
      ),
      body: Body(),
    );
  }
}
