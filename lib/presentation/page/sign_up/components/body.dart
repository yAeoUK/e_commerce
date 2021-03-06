import 'package:flutter/material.dart';
import 'package:flutter_ddd/common/parameters.dart';
import 'package:flutter_ddd/common/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../components/social_card.dart';
import 'sign_up_form.dart';

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
                SizedBox(height: SizeConfig.screenHeight!* 0.04), // 4%
                Text(AppLocalizations.of(context)!.registerAccount, style: headingStyle),
                //Text("Register Account", style: headingStyle),
                Text(
                  //"Complete your details or continue \nwith social media",
                  AppLocalizations.of(context)!.completeDetailsOrSocialMedia,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight!* 0.08),
                SignUpForm(),
                SizedBox(height: SizeConfig.screenHeight!* 0.08),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialCard(
                      icon: 'assets/icons/google-icon.svg',
                      press: () {},
                    ),
                    SocialCard(
                      icon: 'assets/icons/facebook-2.svg',
                      press: () {},
                    ),
                    // SocialCard(
                    //   icon: 'assets/icons/twitter.svg',
                    //   press: () {},
                    // ),
                  ],
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  //'By continuing your confirm that you agree \nwith our Term and Condition',
                  AppLocalizations.of(context)!.confirmAgreeTermCondition,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}