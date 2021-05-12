import 'package:flutter/material.dart';
import 'package:flutter_ddd/presentation/page/sign_in/sign_in_notifier.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'components/body.dart';

enum SignInResult { success }

class SignInScreen extends StatelessWidget {
  static String routeName = '/sign_in';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInChangeNotifier>(
      create:(context)=> SignInChangeNotifier(),
      child: Scaffold(
        appBar: AppBar(
          //title: Text("Sign In"),
            title: Text(AppLocalizations.of(context)!.signIn)
        ),
        body: Body(),
      )
    );
  }
}
