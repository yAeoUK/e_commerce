import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../size_config.dart';
import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = '/otp';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        //title: Text("OTP Verification"),
        title: Text(AppLocalizations.of(context).oTPVerification),
      ),
      body: Body(),
    );
  }
}
