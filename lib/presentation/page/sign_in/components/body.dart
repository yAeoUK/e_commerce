import 'package:flutter/material.dart';
import 'package:flutter_ddd/common/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../../components/no_account_text.dart';
import '../../../../components/social_card.dart';
import '../sign_in_notifier.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight!* 0.04),
                Text(
                  AppLocalizations.of(context)!.welcomeBack,//"Welcome Back",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  //'Sign in with your email and password  \nor continue with social media',
                  AppLocalizations.of(context)!.signInText,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight!* 0.08),
                SignForm(),
                SizedBox(height: SizeConfig.screenHeight!* 0.08),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialCard(
                      icon: 'assets/icons/google-icon.svg',
                      press: () {
                        context.read<SignInChangeNotifier>().googleVerification(context);
                      },
                    ),
                    SocialCard(
                      icon: 'assets/icons/facebook-2.svg',
                      press: () {
                        context.read<SignInChangeNotifier>().facebookVerification(context);
                      },
                    ),
                    // SocialCard(
                    //   icon: 'assets/icons/twitter.svg',
                    //   press: () {},
                    // ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                const NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}