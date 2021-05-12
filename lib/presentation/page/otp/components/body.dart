import 'package:flutter/material.dart';
import 'package:flutter_ddd/common/parameters.dart';
import 'package:flutter_ddd/common/size_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'otp_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: SizeConfig.screenHeight!* 0.05),
              Text(
                //"OTP Verification",
                AppLocalizations.of(context)!.oTPVerification,
                style: headingStyle,
              ),
              //Text("We sent your code to +1 898 860 ***"),
              Text(AppLocalizations.of(context)!.weSentCodeToPhoneNumber),
              buildTimer(context),
              const OtpForm(),
              SizedBox(height: SizeConfig.screenHeight!* 0.1),
              GestureDetector(
                onTap: () {
                  // OTP code resend
                },
                child: Text(
                  //"Resend OTP Code",
                  AppLocalizations.of(context)!.resendOTP,
                  style: const TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Row buildTimer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //Text("This code will expired in "),
        Text(AppLocalizations.of(context)!.thisCodeWillExpireIn),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: const Duration(seconds: 30),
          builder: (_,double value, child) => Text(
            '00:${value.toInt()}',
            style: const TextStyle(color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}
