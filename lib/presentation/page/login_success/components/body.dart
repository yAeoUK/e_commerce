import 'package:flutter/material.dart';
import 'package:flutter_ddd/common/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../components/default_button.dart';
import '../../../../presentation/page/home/home_screen.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: SizeConfig.screenHeight!* 0.04),
        Image.asset(
          'assets/images/success.png',
          height: SizeConfig.screenHeight!* 0.4, //40%
        ),
        SizedBox(height: SizeConfig.screenHeight!* 0.08),
        Text(
          //"Login Success",
          AppLocalizations.of(context)!.loginSuccess,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(30),
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const Spacer(),
        SizedBox(
          width: SizeConfig.screenWidth! * 0.6,
          child: DefaultButton(
            //text: "Back to home",
            text: AppLocalizations.of(context)!.backToHome,
            press: () {
              Navigator.pushNamed(context, HomeScreen.routeName);
            },
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
